import 'package:conveniencia_central/model/item_carrinho.dart';
import 'package:conveniencia_central/model/pedido.dart';
import 'package:conveniencia_central/model/produto.dart';
import 'package:flutter/material.dart';
import 'package:conveniencia_central/control/control.dart';

class TelaCarrinho extends StatefulWidget {
  @override
  TelaCarrinhoState createState() => TelaCarrinhoState();
}

class TelaCarrinhoState extends State<TelaCarrinho> {

  static Control control = Control();
  List<Produto> _itens = List<Produto>();
  double precoTotal = 0;
  int quant = 0;
  String endereco = control.usuario.endereco;
  final scafolldKey = GlobalKey<ScaffoldState>();
  final controller = TextEditingController();

  void initState() {
    super.initState();
    _ayncInitMethod();

  }

  _ayncInitMethod() async {
    await control.pegarItensDoCarrinho().then((onValue) {
      setState(() {
        this._itens = onValue;
        print(onValue[0].imagem);
      });
    });
  }

  void calcularPreco(){
    double temp = 0;
    for(Produto i in _itens){
      temp += i.preco;
    }
    this.precoTotal = temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafolldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
          children: <Widget>[
            page(),
          ],
        ),
      ),
    );
  }

  double calculatePreco() {
    double value = 0;
    for (int i = 0; i < this._itens.length; i++) {
      value += this._itens[i].preco * this._itens[i].quantidade;
    }
    return value;
  }

  Widget page() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50),
          ),
          Container(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.yellow[800],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width / 6,
                  ),
                ),
                Text(
                  'Carrinho',
                  style: TextStyle(fontSize: 17, letterSpacing: 1.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.02,
                0,
                MediaQuery.of(context).size.width * 0.02,
                0),
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            width: MediaQuery.of(context).size.width * 0.95,
            height: 40,
            alignment: Alignment.center,
            child: MaterialButton(
              onPressed: () {
                setAdress();
                print("Altera o endereço");
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Entregar em $endereco',
                      style: TextStyle(color: Colors.yellow[800]),
                    ),
                    Icon(
                      Icons.mode_edit,
                      color: Colors.yellow[800],
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 10),),
          Container(padding: EdgeInsets.only(right:20, left: 20),
          child: Divider(color: Colors.grey, height: 1,),),
          getListViewItens(),
        ],
      ),
    );
  }

  Widget getListViewItens() {
    if (this._itens.isEmpty) {
      return Container(
        padding: EdgeInsets.only(top: 30),
        child: Center(
          child: Text(
            'Sem itens no carrinho.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    } else {
      return Container(
          child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height*0.6,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: this._itens.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      width: MediaQuery.of(context).size.width,
                      height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Material(
                            elevation: 2,
                            child: Container(
                            width: MediaQuery.of(context).size.width*0.7,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Image.network(
                                      '${this._itens[index].imagem}',
                                      height: 80,
                                      width: 80,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        '${this._itens[index].nome}',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey[800], fontWeight: FontWeight.bold)),),
                                    Container(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        'Preço un. R\$ ${(this._itens[index].preco).toStringAsFixed(2)}',
                                        style: TextStyle(fontSize: 10, color: Colors.grey))),
                                    Padding(padding: EdgeInsets.only(bottom: 15)),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 40,
                                          height: 20,
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18),
                                            ),
                                            color: Colors.orange[100],
                                            onPressed: () async {
                                              setState(() {
                                                if(this._itens[index].quantidade > 1){
                                                  this._itens[index].setQuantidade(this._itens[index].quantidade-1);
                                                }
                                              });
                                            },
                                            child: Icon(Icons.remove, size: 10, color: Colors.yellow[800],)
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.only(left: 15)),
                                        Text("${this._itens[index].quantidade}"),
                                        Padding(padding: EdgeInsets.only(right: 15)),
                                        Container(
                                          width: 40,
                                          height: 20,
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18),
                                            ),
                                            color: Colors.orange[100],
                                            onPressed: () async {
                                              setState(() {
                                                this._itens[index].setQuantidade(this._itens[index].quantidade+1);
                                              });
                                            },
                                            child: Icon(Icons.add, size: 10, color: Colors.yellow[800],)
                                          ),
                                        ),
                                      ],
                                    ),                         
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ),
                          Container(
                            //width: 60,
                            child: Column(
                              children: <Widget>[
                                /*Text(
                                  'Preço total',
                                  style: TextStyle(fontSize: 12, color: Colors.black),
                                ),
                                Text(
                                  'R\$ ${(this._itens[index].preco * this._itens[index].quantidade).toStringAsFixed(2)}',
                                  style: TextStyle(fontSize: 12, color: Colors.black),
                                ),
                                Padding(padding: EdgeInsets.only(left: 15),),*/
                                Container(
                                  height: 90,
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                  onTap: () {
                                    control.removeItemCarrinho(this._itens[index], 1);
                                  
                                  },
                                  child: Icon(
                                    Icons.delete_sweep,
                                    color: Colors.yellow[800],
                                  ),
                                ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 15),),
                    ],
                  );
                },
              ),
            ),
          ),
          Container(padding: EdgeInsets.only(right:20, left: 20),
          child: Divider(color: Colors.grey, height: 1,),),
          Container(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 30),
                  width: MediaQuery.of(context).size.width/2,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Total  R\$ ${calculatePreco()}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                                    width: MediaQuery.of(context).size.width/4.5,

                  child:                 FlatButton(
                  onPressed: () {
                    control.limparCarrinho();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('Limpar', style: TextStyle(fontSize: 13, color: Colors.yellow[800]),),
                ),
        
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width/4,
                  height: 35,
                  child: FlatButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18),),
                        color: Colors.yellow[800],
                        onPressed: () async {
                          calcularPreco();
                          Pedido pedido = Pedido(control.usuario, DateTime.now(), this.precoTotal, this.endereco, this._itens);
                          bool response = await control.cadastrarPedido(pedido);
                          if (response) {
                            control.limparCarrinho();
                            _showSnackBar('Compra realizada');
                            await Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            });
                          } else {
                            _showSnackBar('Houve algum erro durante o pedido.');
                          }
                        },
                        child: Text('Comprar', style: TextStyle(fontSize: 13, color: Colors.white),),
                      ),
                ),

              ],
              
            ),
          ),
        ],
      ));
    }
  }

  void setAdress() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            title: null,
            content: escolherEndereco(),
          );
        });
  }

  Widget escolherEndereco() {
    this.controller.clear();
    return Container(
      height: 88.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            child: TextField(
              controller: this.controller,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: "Informe o novo endereço",
                  fillColor: Colors.white70),
            ),
          ),
          MaterialButton(
            height: 20,
            minWidth: 100,
            onPressed: () {
              this.endereco = this.controller.text;
              Navigator.pop(context);
            },
            child: Text(
              'Confirmar',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          )
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