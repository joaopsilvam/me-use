import 'package:conveniencia_central/components/busca.dart';
import 'package:conveniencia_central/components/gerenciar_telas_usuario.dart';
import 'package:conveniencia_central/model/categoria.dart';
import 'package:conveniencia_central/model/produto.dart';
import 'package:conveniencia_central/pages/exibir_pedidos.dart';
import 'package:conveniencia_central/pages/produtos_por_categoria.dart';
import 'package:conveniencia_central/pages/tela_configuracoes.dart';
import 'package:conveniencia_central/pages/tela_produto.dart';
import 'package:flutter/material.dart';
import 'package:conveniencia_central/control/control.dart';
import 'package:conveniencia_central/model/usuario.dart';
import 'package:conveniencia_central/pages/tela_inicio.dart';
import 'package:intl/intl.dart';

class PrincipalUsuario extends StatefulWidget {
  State<StatefulWidget> createState() => _PrincipalUsuarioState();
}

class _PrincipalUsuarioState extends State<PrincipalUsuario> {

  Control controle = Control();
  Usuario usuario;
  List<Categoria> categorias = List();
  List<Produto> produtos = List();
  bool buscando = false;
  NumberFormat formatador = NumberFormat("0.00");
  final key = GlobalKey<FormState>();
  
  Icon naoPesquisando;
  IconButton pesquisando;

  //var principal = this;
  String text = '';
  List<Produto> produtos2 = new List<Produto>();

  Future<bool> _willpop() async {
    this.alterarBusca();
    return false;
  }

  void initState() {
    super.initState();
    _ayncInitMethod();
  }

  _ayncInitMethod() async {
    Control controle = Control();
    await controle.pegarCategorias().then((value) {
      setState(() {
        this.categorias = value;
      });
    });
    await controle.pegarProdutos().then((value){
      setState((){
        this.produtos = value;
      });
    });
  }

  void alterarBusca() {
    setState(() {
      buscando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    pesquisando = IconButton(onPressed: () {
      this.alterarBusca();
      Navigator.push(context, MaterialPageRoute(builder: (context) => GerenciarTelas()));
      },
      icon: Icon(Icons.close, color: Colors.red, size: 17),
    );
    naoPesquisando = Icon(Icons.search, color: Colors.grey, size: 22);
    this.usuario = controle.usuario;
    return Material(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget> [
              Container(
                color: Colors.yellow[800],
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget> [
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 25, top: 20),
                          width: MediaQuery.of(context).size.width*0.6,
                          child: Text("Olá, ${this.controle.usuario.nome}.", style: TextStyle(fontSize: 17, color: Colors.white, fontFamily: "Century Gothic", fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          alignment: Alignment.topRight,
                          width: MediaQuery.of(context).size.width*0.4,
                          child: IconButton(
                            icon: Icon(Icons.settings, color: Colors.white,),
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TelaConfiguracoes()))
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 25),
                      child: Text("Encontre o produto", style: TextStyle(fontSize: 25, color: Colors.black, fontFamily: "Aharoni", fontWeight: FontWeight.bold),),),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 25),
                      child: Text("perfeito pra voce.", style: TextStyle(fontSize: 25, color: Colors.black, fontFamily: "Aharoni", fontWeight: FontWeight.bold),),),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    barra_de_busca(),
                    Padding(padding: EdgeInsets.only(bottom: 20)),
                  ] 
                ),
              ),
              buscando ? corpo_busca() : corpo_home(),
            ]
          )
        )
      )
    );
  }

  Widget corpo_busca(){
    return WillPopScope(
      child: getBody(),
      onWillPop: () => _willpop(),
    ); 
  }

  Widget getBody() {
    return Container(
      color: Colors.grey[100],
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView.builder(
              itemCount: this.produtos2.length,
              itemBuilder: (BuildContext context, int index) {
                if (this.produtos2.length == 0) {
                  print("ZXX");
                  print(this.produtos2.length);
                  return Center(
                    child: text == ''
                        ? Text('AAA')
                        : Text('Produto não encontrado.'),
                  );
                } else {
                  print("ZXX");
                  print(this.produtos2[index].nome);
                  return MaterialButton(
                    height: 120,
                    minWidth: MediaQuery.of(context).size.width * 0.95,
                    onPressed: () {
                      goToProduct(this.produtos2[index]);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, boxShadow: [BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset: Offset(1.0, 1.0)
                      )],),
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 130,
                      child: Row(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Container(
                            width: 100,
                            height: 100,                   
                            //decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black,),                    
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                '${this.produtos2[index].imagem}',
                                fit: BoxFit.cover,
                              ),
                            )
                          ),
                          Padding(padding: EdgeInsets.only(left: 20, top: 10)),
                          Container(
                            height: 75,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  width: MediaQuery.of(context).size.width*0.5,
                                  height: 25,
                                  child: Text('${this.produtos2[index].nome}', style: TextStyle(fontSize: 17, fontFamily: "Century Gothic", fontWeight: FontWeight.bold, color: Colors.black)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  width: MediaQuery.of(context).size.width*0.5,
                                  height: 25,
                                  child: Text('${this.produtos2[index].litragem}', style: TextStyle(fontSize: 13, fontFamily: "Century Gothic", fontWeight: FontWeight.bold, color: Colors.grey)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  width: MediaQuery.of(context).size.width*0.5,
                                  height: 25,
                                  child: Text('\$${formatador.format(num.parse(this.produtos2[index].preco.toStringAsPrecision(2)))}', style: TextStyle(fontSize: 30, fontFamily: "Aharoni", fontWeight: FontWeight.bold, color: Colors.yellow[800])),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
  Widget corpo_home(){
    return Container(
      padding: EdgeInsets.only(top: 10),
      color: Colors.grey[100],
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 25),
              child: Text("Buscar por categoria", style: TextStyle(fontSize: 20, color: Colors.grey[900], fontWeight: FontWeight.bold),),),
            Padding(padding: EdgeInsets.only(top: 10)),
            categorias1(),
            //Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 25),
              child: Text("Produtos mais pedidos", style: TextStyle(fontSize: 20, color: Colors.grey[900], fontWeight: FontWeight.bold),),),
            Padding(padding: EdgeInsets.only(top: 10)),
            maisPedidos(),
          ],
        ),
      )
    );
  }

  Widget barra_de_busca(){
    return Container(
      height: 45,
      alignment: Alignment.center,
      //padding: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width-50,
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        onTap: (){
          print("aa");
          buscando = true;  
        },
        onChanged: (value) {
          onChangeSearch(value);
        },
        onFieldSubmitted: (term) {
          search();
        },
        key: key,
        decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.grey, fontFamily: "San Francisc", fontSize: 15.0),
        filled: true,
        fillColor: Colors.white,
        hintText: "Buscar produto",
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),),
          suffixIcon: buscando ? pesquisando: naoPesquisando,
        ),
      ),
    );
  }

  Widget categorias1(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.36,
      //color: Colors.grey[100],
      child: lista_categorias(),
    );
  }

  Widget lista_categorias() {
    if (this.categorias.isEmpty) {
      return Center(
        child: Text('Sem categorias cadastradas'),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(top:5),
        width: MediaQuery.of(context).size.width,
        //height: 125,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: this.categorias.length,
          itemBuilder: (BuildContext context, int index) {
            return FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProdutosPorCategoria(this.categorias[index])));
              },
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      '${this.categorias[index].imagem}',
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width*0.65,
                      height: MediaQuery.of(context).size.width*0.45,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Container(
                    padding: EdgeInsets.only(top: 5, left: 5),
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width*0.65,
                    child: Text('${this.categorias[index].nome}', style: TextStyle(fontSize: 15)),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5, left: 5),
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width*0.65,
                    child: Text('${this.categorias[index].subtitulo}', style: TextStyle(fontSize: 13, color: Colors.grey)),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }

  Widget maisPedidos(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 110,
      //color: Colors.blue,
      child: lista_mais_pedidos(),
    );
  }

  Widget lista_mais_pedidos() {
      if (this.categorias.isEmpty) {
      return Center(
        child: Text('Produtos não encontrados'),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: this.produtos.length,
          itemBuilder: (BuildContext context, int index) {
            return FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TelaProduto(this.produtos[index])));
              },
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white, boxShadow: [BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(1.0, 1.0)
                )],),
                child:Row(
                children: <Widget>[
                  Container(
                      width: 70,
                      height: 70,                   
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(90), color: Colors.black,),                    
                    child: ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: Image.network(
                      '${this.produtos[index].imagem}',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width*0.2,
                      height: MediaQuery.of(context).size.width*0.2,
                    ),
                  ),
                  ),
                  //Padding(padding: EdgeInsets.only(top: 10, left: 10)),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 17, left: 20),
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Text('${this.produtos[index].nome}', style: TextStyle(fontSize: 15)),
                      ),

                      Container(
                        padding: EdgeInsets.only(top: 5, left: 20),
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Text('${this.produtos[index].litragem}',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),      
                      ),     
                      Container(
                        padding: EdgeInsets.only(top: 5, left: 20),
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Text('R\$ ${formatador.format(num.parse(this.produtos[index].preco.toStringAsPrecision(2)))}', style: TextStyle(fontSize: 13, color: Colors.yellow[800])),
                      ),                                                          
                    ],
                  ),
                ],
              ),
              )
            );
          },
        ),
      );
    }
 }

  void search() {
    final k = key.currentState;
    setState(() {
      k.save();
    });
  }
  void onChangeSearch(String value) async {
    print('value --> $value');
    if (value == '') {
      setState(() {
        this.produtos2 = new List<Produto>();
      });
    }
    else{
      print(produtos2.length);
      Control control = Control();
      await control.pegarProdutosComecandoCom(value).then((onValue) {
        setState(() {
          this.produtos2 = onValue;
        });
      });
    }
  }

  void goToProduct(Produto r) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TelaProduto(r)));
  }
}