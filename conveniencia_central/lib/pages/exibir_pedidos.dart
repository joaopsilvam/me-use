import 'package:conveniencia_central/model/pedido.dart';
import 'package:conveniencia_central/pages/tela_carrinho.dart';
import 'package:flutter/material.dart';
import 'package:conveniencia_central/model/produto.dart';
import 'package:conveniencia_central/control/control.dart';

class ExibirPedidos extends StatefulWidget {


  @override
  _ExibirPedidosState createState() => _ExibirPedidosState();
}

class _ExibirPedidosState extends State<ExibirPedidos> {

  int quant = 1;
  List<Produto> bag = List<Produto>();
  Control control = Control();
  
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafolldKey,
      body: body(),
    );
  }

  Widget body() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 20),),
          Row(
            children: <Widget>[
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width/2,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 15,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),              
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width*0.9,
            child: Text("Pedidos", style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: "Aharoni", fontWeight: FontWeight.bold),),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.78,
            child: requests(),
          ),
        ],
      ),
    );
  }

  Widget requests(){
    if (this._pedidos == null) {
      return (Center(child: Text('Nenhum pedido realizado')));
    } else {
      return ListView.builder(
        itemCount: _pedidos.length,
        itemBuilder: (BuildContext cntx, int index) {
          return Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.84,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 230,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                color: Colors.white, border: Border.all(color: Colors.grey)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width*0.65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(top:15),),
                              Text("Entregue em", style: TextStyle(fontSize: 11.0, color: Colors.grey)),
                              Text("${this._pedidos[index].endereco}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 25,
                          alignment: Alignment.topRight,
                          //color: Colors.blue,
                          child: IconButton(
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('ITENS', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                                    content: setupAlertDialoadContainer(this._pedidos[index]),
                                  );
                                }
                              );
                            },
                            icon: Icon(Icons.more_vert, color: Colors.yellow[800],
                            ),
                          )
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom:5),),
                    Text("CPF", style: TextStyle(fontSize: 11.0, color: Colors.grey)),
                    Text("${this._pedidos[index].cpf}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    Padding(padding: EdgeInsets.only(bottom:5),),
                    Text("Número do Cartão", style: TextStyle(fontSize: 11.0, color: Colors.grey)),
                    Text("${this._pedidos[index].numeroCartao}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    Padding(padding: EdgeInsets.only(bottom:10),),
                    Text("${this._pedidos[index].data}", style: TextStyle(color: Colors.grey, fontSize: 11)),
                    Divider(color: Colors.grey),
                    Padding(padding: EdgeInsets.only(bottom:7),),
                    Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width*0.72/2,
                          child: Text("Subtotal",
                          style: TextStyle(
                            fontSize: 13, color: Colors.grey),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width*0.72/2,
                          child: Text("R\$ ${(this._pedidos[index].precoTotal-3).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 13, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 5)),
                    Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width*0.72/2,
                          child: Text("Taxa de entrega",
                          style: TextStyle(
                            fontSize: 13, color: Colors.grey),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width*0.72/2,
                          child: Text("R\$ 3.00",
                          style: TextStyle(
                            fontSize: 13, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 5)),
                    Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width*0.72/2,
                          child: Text("Total",
                          style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width*0.72/2,
                          child: Text("R\$ ${(this._pedidos[index].precoTotal).toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),                    
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom:20),),
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
            height: 250.0, // Change as per your requirement
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: p.produtos.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('${p.produtos[index].quantidade}x  ${p.produtos[index].nome}'),
                  subtitle: Text("R\$ ${(p.produtos[index].preco).toStringAsFixed(2)}"),
                );
              },
            ),
          ),
          MaterialButton(
            height: 20,
            minWidth: 100,
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('Voltar', style: TextStyle(fontSize: 16, color: Colors.yellow[800]),
          ),)

        ],
      ),
    );
  }
}