import 'package:conveniencia_central/components/busca.dart';
import 'package:conveniencia_central/model/categoria.dart';
import 'package:conveniencia_central/model/produto.dart';
import 'package:conveniencia_central/pages/exibir_pedidos.dart';
import 'package:conveniencia_central/pages/produtos_por_categoria.dart';
import 'package:flutter/material.dart';
import 'package:conveniencia_central/control/control.dart';
import 'package:conveniencia_central/model/usuario.dart';
import 'package:conveniencia_central/pages/tela_inicio.dart';
import 'package:carousel_slider/carousel_slider.dart';
class PrincipalUsuario extends StatefulWidget {
  State<StatefulWidget> createState() => _PrincipalUsuarioState();
}

class _PrincipalUsuarioState extends State<PrincipalUsuario> {

  Control controle = Control();
  Usuario usuario;
  List<Categoria> categorias = List();
  List<Produto> produtos = List();
  bool buscando = false;

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
    this.usuario = controle.usuario;
    return Material(
      child: buscando ? corpo_busca() : corpo_home(),

    );
  }

  Widget corpo_busca(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Busca(this)
    );
  }

  Widget corpo_home(){
    return Container(
      color: Colors.grey[100],
      alignment: Alignment.topCenter,
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
                        child: Icon(Icons.settings, color: Colors.white,)
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
            Padding(padding: EdgeInsets.only(top: 10)),
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
      //height: 20,
      alignment: Alignment.center,
      //padding: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width-50,
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        onTap: (){
          print("aa");
          buscando = true;  
        },
        decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.grey, fontFamily: "San Francisc", fontSize: 18.0),
        filled: true,
        fillColor: Colors.white,
        hintText: "Buscar produto",
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),),
          prefixIcon: Icon(Icons.search, color: Colors.grey,),
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
                print("AA");
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
                        child: Text('${this.produtos[index].litragem} kg',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),      
                      ),     
                      Container(
                        padding: EdgeInsets.only(top: 5, left: 20),
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Text('R\$ ${this.produtos[index].preco}0', style: TextStyle(fontSize: 13, color: Colors.yellow[800])),
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
}