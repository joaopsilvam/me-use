import 'package:conveniencia_central/components/gerenciar_telas_usuario.dart';
import 'package:conveniencia_central/model/pedido.dart';
import 'package:conveniencia_central/pages/tela_carrinho.dart';
import 'package:flutter/material.dart';
import 'package:conveniencia_central/model/produto.dart';
import 'package:conveniencia_central/control/control.dart';
import 'package:intl/intl.dart';

class ExibirPedidos extends StatefulWidget {
  @override
  _ExibirPedidosState createState() => _ExibirPedidosState();
}

class _ExibirPedidosState extends State<ExibirPedidos> {
  int quant = 1;
  List<Produto> bag = List<Produto>();
  Control control = Control();
  NumberFormat formatador = NumberFormat("0.00");

  final scafolldKey = GlobalKey<ScaffoldState>();

  _ExibirPedidosState();
  List<Pedido> _pedidos;

  @override
  void initState() {
    _asyncMethod();
    super.initState();
  }

  void _asyncMethod() async {
    Control control = Control();
    await control.pegarPedidosDoUsuario(control.usuario).then((onValue) {
      setState(() {
        this._pedidos = onValue;
        print(this._pedidos.length);
        print(this._pedidos.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => GerenciarTelas())),
      child: Scaffold(
        key: scafolldKey,
        body: body(),
      ),
    );
  }

  Widget body() {
    return Stack(
      alignment: Alignment.center,
      /*child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,*/
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/Pedidos.png', fit: BoxFit.fill),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40),
            ),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GerenciarTelas()));
                      },
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(right: 20),
                  //width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    "Pedidos",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: "Arial",
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.45,
              child: requests(),
            ),
          ],
        ),
      ],
      //),
    );
  }

  Widget requests() {
    if (this._pedidos == null) {
      return Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(
              left: 20,
              right: 20,
              top: MediaQuery.of(context).size.height * 0.1),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.data_usage,
                size: 30,
                color: Colors.yellow[800],
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
          ));
    } else {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _pedidos.length,
        itemBuilder: (BuildContext cntx, int index) {
          return Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.84,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                margin: EdgeInsets.only(right: 15),
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 1.0))
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          height: 150,
                          alignment: Alignment.topCenter,
                          child: Icon(
                            Icons.location_on,
                            size: 50,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 15),
                              ),
                              Container(
                                  child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text("${this._pedidos[index].endereco}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      fontFamily: "Century Gothic",
                                    )),
                              )),
                              Padding(
                                padding: EdgeInsets.only(bottom: 3),
                              ),
                              Text("CPF: ${this._pedidos[index].cpf}",
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontFamily: "Century Gothic",
                                  )),
                              Padding(
                                padding: EdgeInsets.only(bottom: 3),
                              ),
                              Text("${this._pedidos[index].data}",
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontFamily: "Century Gothic",
                                  )),
                              Padding(
                                padding: EdgeInsets.only(bottom: 5),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Subtotal:",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                        fontFamily: "Century Gothic",
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "R\$ ${formatador.format(num.parse((this._pedidos[index].precoTotal - 3).toStringAsFixed(10)))}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                        fontFamily: "Century Gothic",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 3)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Taxa de entrega:",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                        fontFamily: "Century Gothic",
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "R\$ 3.00",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                        fontFamily: "Century Gothic",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 5)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Total:",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Century Gothic",
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "R\$ ${(this._pedidos[index].precoTotal).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Century Gothic",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 5)),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(150))),
                        height: 25,
                        alignment: Alignment.center,
                        child: RaisedButton(
                          child: Text(
                            "Produtos",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Century Gothic",
                                fontWeight: FontWeight.bold),
                          ),
                          color: Colors.yellow[800],
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Produtos',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontFamily: "Century Gothic",
                                            fontWeight: FontWeight.bold)),
                                    content: setupAlertDialoadContainer(
                                        this._pedidos[index]),
                                  );
                                });
                          },
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 20,
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Widget setupAlertDialoadContainer(Pedido p) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(color: Colors.grey)),
            height: 250.0, // Change as per your requirement
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: p.produtos.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    '${p.produtos[index].quantidade}x  ${p.produtos[index].nome}',
                    style: TextStyle(
                      fontFamily: "Century Gothic",
                    ),
                  ),
                  subtitle: Text(
                      "R\$ ${(p.produtos[index].preco).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontFamily: "Century Gothic",
                      )),
                );
              },
            ),
          ),
          MaterialButton(
            height: 20,
            minWidth: 100,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Voltar',
              style: TextStyle(
                fontSize: 16,
                color: Colors.yellow[800],
                fontFamily: "Century Gothic",
              ),
            ),
          )
        ],
      ),
    );
  }
}
