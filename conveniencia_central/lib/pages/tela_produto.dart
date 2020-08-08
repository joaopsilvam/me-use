import 'package:conveniencia_central/pages/tela_carrinho.dart';
import 'package:flutter/material.dart';
import 'package:conveniencia_central/model/produto.dart';
import 'package:conveniencia_central/control/control.dart';
import 'package:intl/intl.dart';

class TelaProduto extends StatefulWidget {
  Produto produto;
  bool verificar;

  TelaProduto(this.produto, this.verificar);

  @override
  _TelaProdutoState createState() => _TelaProdutoState(produto, verificar);
}

class _TelaProdutoState extends State<TelaProduto> {
  Produto produto;
  bool verificar;
  int quant = 1;
  List<Produto> bag = List<Produto>();
  Control control = Control();
  final scafolldKey = GlobalKey<ScaffoldState>();
  NumberFormat formatador = NumberFormat("0.00");

  _TelaProdutoState(this.produto, this.verificar);

  @override
  Widget build(BuildContext context) {
    print("verifi");
    print(this.verificar);
    return Scaffold(
      key: scafolldKey,
      body: page(),
    );
  }

  Widget page() {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            child: Container(
              width: 60,
              height: 25,
              child: FlatButton(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 15,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Container(
            color: Colors.blue,
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              child: Image.network(
                '${this.produto.imagem}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "${this.produto.nome}",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        color: Colors.black,
                        fontFamily: "Century Gothic",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                //Padding(padding: EdgeInsets.only(top: 10),),
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        '\$${formatador.format(num.parse(this.produto.preco.toStringAsPrecision(10)))}',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.1,
                            color: Colors.yellow[800],
                            fontFamily: "Aharoni",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      width: MediaQuery.of(context).size.width / 3,
                      child: verificar
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  width: 35,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        side: BorderSide(
                                            color: Colors.yellow[800])),
                                    onPressed: () {
                                      setState(() {
                                        quant <= 1 ? quant = quant : --quant;
                                      });
                                    },
                                    color: Colors.white,
                                    padding: EdgeInsets.all(5.0),
                                    child: Column(
                                      // Replace with a Row for horizontal icon + text
                                      children: <Widget>[
                                        Icon(
                                          Icons.remove,
                                          size: 15,
                                          color: Colors.yellow[800],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                Container(
                                  child: Text(
                                    quant.toString(),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                Container(
                                  width: 35,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    onPressed: () {
                                      setState(() {
                                        ++quant;
                                      });
                                    },
                                    color: Colors.yellow[800],
                                    padding: EdgeInsets.all(5.0),
                                    child: Column(
                                      // Replace with a Row for horizontal icon + text
                                      children: <Widget>[
                                        Icon(
                                          Icons.add,
                                          size: 15,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Container(
                  child: Text(
                    "Sobre o produto",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        color: Colors.black,
                        fontFamily: "Century Gothic",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Container(
                    height: 50,
                    child: SingleChildScrollView(
                      child: Text(
                        "${this.produto.descricao}",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            color: Colors.grey,
                            fontFamily: "Century Gothic",
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
          ),
          /*Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
            // height: MediaQuery.of(context).size.height / 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.tightFor(
                    width: 30,
                    height: 30
                  ),                  
                  child:                 RawMaterialButton(
                  child: Icon(Icons.remove, color: Colors.yellow[800], size: 15,),

                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  fillColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      quant<=1?
                       quant = quant: --quant;
                    });
                  },
                ),
                ),
                Text(
                  quant.toString(),
                ),
                RawMaterialButton(
                  child: Icon(Icons.add, color: Colors.white, size: 10.0,),
                  elevation: 6.0,
                  constraints: BoxConstraints.tightFor(
                    width: 20.0,
                    height: 20.0
                  ),
                  shape: CircleBorder(),
                  fillColor: Colors.yellow[800],
                  onPressed: () {
                    setState(() {
                      ++quant;
                    });
                  },
                ),
                Material(
                  elevation: 5.0,
                  color: Colors.yellow[800],
                  child: MaterialButton(
                    minWidth: 100.0,
                    onPressed: () async{
                      this.produto.setQuantidade(quant);
                      print(await control.adicionarNoCarrinho(this.produto));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TelaCarrinho()));
                    },
                    child: Text('Adicionar     \$${(this.produto.preco) * quant}', style: TextStyle(color: Colors.white),),
                  ),
                )
              ],
            ),
          ),*/
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            child: verificar
                ? Container()
                : RaisedButton(
                    onPressed: () async {
                      this.produto.setQuantidade(quant);
                      print(await control.adicionarNoCarrinho(this.produto));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaCarrinho()));
                    },
                    color: Colors.yellow[800],
                    child: Text("Adicionar ao carrinho",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: "Century Gothic",
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
          ),
        ],
      ),
    );
  }

  _showSnackBar(String text) {
    final keyState = scafolldKey.currentState;
    keyState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }
}
