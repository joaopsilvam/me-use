import 'package:conveniencia_central/control/control.dart';
import 'package:conveniencia_central/model/categoria.dart';
import 'package:conveniencia_central/model/produto.dart';
import 'package:conveniencia_central/pages/tela_produto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VerificarProdutos extends StatefulWidget {
  @override
  _VerificarProdutosState createState() => _VerificarProdutosState();
}

class _VerificarProdutosState extends State<VerificarProdutos> {
  Categoria categoria;
  List<Produto> produtos = List();
  NumberFormat formatador = NumberFormat("0.00");
  Control control = Control();
  bool buscando = false;
  Icon naoPesquisando;
  IconButton pesquisando;
  final key = GlobalKey<FormState>();

  void initState() {
    super.initState();
    _ayncInitMethod();
  }

  _ayncInitMethod() async {
    Control controle = Control();
    print("QQQ");
    await controle.pegarProdutos().then((value) {
      setState(() {
        this.produtos = value;
      });
    });
    print("AQAQ");
    print(produtos);
  }

  void alterarBusca() {
    setState(() {
      buscando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    pesquisando = IconButton(
      onPressed: () {
        this.alterarBusca();
        //Navigator.push(context, MaterialPageRoute(builder: (context) => GerenciarTelas()));
      },
      icon: Icon(Icons.close, color: Colors.red, size: 17),
    );
    naoPesquisando = Icon(Icons.search, color: Colors.grey, size: 22);
    return Material(
        child: Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.yellow[800],
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 40)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      //width: MediaQuery.of(context).size.width,
                      child: Container(
                        width: 60,
                        height: 25,
                        child: FlatButton(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 15,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(right: 20),
                      //width: MediaQuery.of(context).size.width * 0.65,
                      child: Text(
                        "Verificar produtos",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: "Arial",
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                barra_de_busca(),
                Padding(padding: EdgeInsets.only(top: 15)),
              ],
            ),
          ),
          getBody(),
        ],
      ),
    ));
  }

  Widget barra_de_busca() {
    return Container(
      height: 45,
      alignment: Alignment.center,
      //padding: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width - 50,
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        onTap: () {
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
          hintStyle: TextStyle(
              color: Colors.grey, fontFamily: "San Francisc", fontSize: 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "Buscar produto",
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          suffixIcon: buscando ? pesquisando : naoPesquisando,
        ),
      ),
    );
  }

  Widget getBody() {
    if (this.produtos == null || this.produtos.isEmpty) {
      return Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          padding: EdgeInsets.only(top: 5),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.75,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.data_usage,
                size: 30,
                color: Colors.green,
              ),
              Padding(padding: EdgeInsets.only(right: 10)),
              Text(
                "Carregando...",
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: "Century Gothic",
                    color: Colors.grey),
              ),
            ],
          )));
    } else {
      return Container(
          //color: Colors.black,
          margin: EdgeInsets.only(left: 20, right: 20),
          padding: EdgeInsets.only(top: 5),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.75,
          child: SingleChildScrollView(
              child: Column(
                  children: List.generate(this.produtos.length, (index) {
            return Column(children: <Widget>[
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text('${this.produtos[index].nome}',
                              style: TextStyle(fontSize: 15)),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            '${produtos[index].litragem}',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                          'R\$ ${formatador.format(num.parse((this.produtos[index].preco * this.produtos[index].quantidade).toStringAsPrecision(10)))}',
                          style: TextStyle(
                              fontSize: 13, color: Colors.yellow[800])),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        alignment: Alignment.center,
                        child: IconButton(
                            icon: Icon(
                              Icons.open_in_new,
                              color: Colors.green,
                              size: 18,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TelaProduto(
                                          this.produtos[index], true)));
                            }))
                  ],
                ),
              ),
              Container(
                child: Divider(
                  color: Colors.grey,
                  height: 1,
                ),
              ),
            ]);
          }))));
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
        this.produtos = new List<Produto>();
      });
    } else {
      Control control = Control();
      await control.pegarProdutosComecandoCom(value).then((onValue) {
        setState(() {
          this.produtos = onValue;
        });
      });
    }
  }
}
