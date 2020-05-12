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
        print(onValue);
        this._pedidos = onValue;
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
          Padding(padding: EdgeInsets.only(top: 50)),
          Text(
            'Pedidos',
            style: TextStyle(fontSize: 20.0),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade200,
            ),
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
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                height: 230,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //Icon(Icons.check_circle_outline, color: Color(0xff38ad53),),
                    Padding(padding: EdgeInsets.only(bottom:5),),
                    Text('MeUse', style: TextStyle(fontSize: 20, color: Colors.black,  fontWeight: FontWeight.bold)),
                    Padding(padding: EdgeInsets.only(bottom:5),),
                    Text('${this._pedidos[index].data}', style: TextStyle(fontSize: 15, color: Colors.grey,)),
                    Padding(padding: EdgeInsets.only(bottom:5),),
                    Text('Pedido nº ${this._pedidos[index].idPedido}', style: TextStyle(fontSize: 15, color: Colors.grey,)),
                    Padding(padding: EdgeInsets.only(bottom:10),),
                    Divider(color: Colors.grey),
                    Padding(padding: EdgeInsets.only(bottom:7),),
                    Text('Entregue em: ${this._pedidos[index].endereco}', style: TextStyle(fontSize: 12, color: Colors.grey,)),                    
                    Padding(padding: EdgeInsets.only(bottom:5),),
                    Text('Total R\$ ${(this._pedidos[index].precoTotal).toStringAsFixed(2)}', style: TextStyle(fontSize: 15, color: Colors.black,)),
                    Padding(padding: EdgeInsets.only(bottom:7),),
                    Center(
                      child: MaterialButton(
                        height: 20,
                        minWidth: 100,
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
                        child: Text('Ver recibo', style: TextStyle(fontSize: 13, color: Colors.yellow[800]),),
                      ),
                    )
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