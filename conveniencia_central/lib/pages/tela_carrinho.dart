import 'package:conveniencia_central/components/gerenciar_telas_usuario.dart';
import 'package:conveniencia_central/model/item_carrinho.dart';
import 'package:conveniencia_central/model/pedido.dart';
import 'package:conveniencia_central/model/produto.dart';
import 'package:conveniencia_central/pages/tela_principal_usuario.dart';
import 'package:flutter/material.dart';
import 'package:conveniencia_central/control/control.dart';
import 'package:intl/intl.dart';

class TelaCarrinho extends StatefulWidget {
  @override
  TelaCarrinhoState createState() => TelaCarrinhoState();
}

class TelaCarrinhoState extends State<TelaCarrinho> {

  static Control control = Control();
  List<Produto> _itens = List<Produto>();
  double precoTotal = 0;
  int quant = 0;
  double taxaEntrega = 3;
  String numeroCartao = "Escolha um cartão";
  String cpf = "Informe seu CPF";
  String endereco = control.usuario.endereco;
  final scafolldKey = GlobalKey<ScaffoldState>();
  final controller = TextEditingController();
  NumberFormat formatador = NumberFormat("0.00");
  
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
    return Material(
      key: scafolldKey,
      child: SingleChildScrollView(
        child: page()
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
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          /*Row(
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
                      /*Container(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          'Voltar',
                          style: TextStyle(fontSize: 13, letterSpacing: 1.0),
                          textAlign: TextAlign.center,
                        ),
                      )*/
                    ],
                  ),
                ),
              ),
              /*Container(
                width: MediaQuery.of(context).size.width/2,
                padding: EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.home, color: Colors.yellow[800], size: 20,),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GerenciarTelas()));
                  },
                )
              )*/
            ],
          ),*/
          Padding(padding: EdgeInsets.only(top: 20),),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width*0.9,
            child: Text("Carrinho", style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: "Aharoni", fontWeight: FontWeight.bold),),
          ),
          Padding(padding: EdgeInsets.only(bottom: 10),),
          Container(padding: EdgeInsets.only(right:20, left: 20),
          child: Divider(color: Colors.grey, height: 1,),),
          getListViewItens(),
          rodape(),
        ],
      ),
    );
  }

  Widget getListViewItens() {
    if (this._itens.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.height*0.5,
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
            width: MediaQuery.of(context).size.width*0.8,
            height: MediaQuery.of(context).size.height*0.5,
            child: SizedBox(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: this._itens.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget> [
                      Container(
                        height: 70,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width*0.1,
                              child: Text("${this._itens[index].quantidade}x"),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width*0.4,
                                  child: Text('${this._itens[index].nome}', style: TextStyle(fontSize: 15)),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.4,
                                  child: Text('Preço por un. R\$ ${formatador.format(num.parse(this._itens[index].preco.toStringAsPrecision(2)))}',
                                    style: TextStyle(fontSize: 11, color: Colors.grey),
                                  ),      
                                ),           
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.2,
                              child: Text('R\$ ${formatador.format(num.parse((this._itens[index].preco*this._itens[index].quantidade).toStringAsPrecision(2)))}', style: TextStyle(fontSize: 13, color: Colors.yellow[800])),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.1,
                              alignment: Alignment.topCenter,
                              child: IconButton(
                                icon: Icon(Icons.delete_outline, color: Colors.red, size: 18,),
                              onPressed: (){
                                control.removeItemCarrinho(this._itens[index], this._itens[index].quantidade);
                              })
                            )
                          ],
                        ),
                      ),
                      Container(child: Divider(color: Colors.grey, height: 1,),),
                    ]
                  );
                  
                  /*Container(
                    height: 60,
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
                          child: Text("${this._itens[index].quantidade}x"),
                        ),
                        //Padding(padding: EdgeInsets.only(top: 10, left: 10)),
                        Column(
                          children: <Widget>[
                            Container(
                              //padding: EdgeInsets.only(top: 17, left: 20),
                              //alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width*0.48,
                              child: Text('${this._itens[index].nome}', style: TextStyle(fontSize: 15)),
                            ),
                            Container(
                              //padding: EdgeInsets.only(top: 5, left: 20),
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width*0.4,
                              child: Text('Preço por un. R\$ ${formatador.format(num.parse(this._itens[index].preco.toStringAsPrecision(2)))}',
                                style: TextStyle(fontSize: 11, color: Colors.grey),
                              ),      
                            ),                                                        
                          ],
                        ),
                        Container(
                              padding: EdgeInsets.only(top: 5, left: 20),
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width*0.2,
                              child: Text('R\$ ${formatador.format(num.parse((this._itens[index].preco*this._itens[index].quantidade).toStringAsPrecision(2)))}', style: TextStyle(fontSize: 13, color: Colors.yellow[800])),
                            ),       
                        /*Column(
                                      children: <Widget>[
                                        Padding(padding: EdgeInsets.only(top: 15)),
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
                                        Padding(padding: EdgeInsets.only(left: 15, bottom: 2)),
                                        Text("${this._itens[index].quantidade}"),
                                        Padding(padding: EdgeInsets.only(right: 15, bottom: 2)),
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
                                      ],
                                    ),*/
                                    Container(

                                      child: IconButton(
                                        icon: Icon(Icons.close, color: Colors.red, size: 18,),
                                        onPressed: ()=> print("AA"),)
                                    )            
                      ],
                    ),
                  );*/
                },
              ),
              /*ListView.builder(
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
              ),*/
            ),
          ),
        ],
      ));
    }
  }

  Widget rodape(){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width*0.8,
                  child: FlatButton(child: Text("Adicionar itens", style: TextStyle(fontSize: 12, color: Colors.yellow[800])),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GerenciarTelas()));
                    },
                    )
                ),
                Container(padding: EdgeInsets.only(right:20, left: 20, bottom: 15),
                child: Divider(color: Colors.grey, height: 1,),),                
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width/2,
                      child: Text("Subtotal",
                      style: TextStyle(
                        fontSize: 13, color: Colors.grey),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width/2,
                      child: Text("R\$ ${formatador.format(num.parse(calculatePreco().toStringAsPrecision(2)))}",
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
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width/2,
                      child: Text("Taxa de entrega",
                      style: TextStyle(
                        fontSize: 13, color: Colors.grey),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width/2,
                      child: Text("R\$ ${formatador.format(num.parse(taxaEntrega.toStringAsPrecision(2)))}",
                      style: TextStyle(
                        fontSize: 13, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 7)),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width/2,
                      child: Text("Total",
                      style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width/2,
                      child: Text("R\$ ${formatador.format(num.parse((taxaEntrega+calculatePreco()).toStringAsPrecision(2)))}",
                      style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(padding: EdgeInsets.only(right:20, left: 20, top: 15),
          child: Divider(color: Colors.grey, height: 1,),),
          Container(
            width: MediaQuery.of(context).size.width*0.8,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.credit_card),
                          Padding(padding: EdgeInsets.only(right: 10)),
                          Text(this.numeroCartao),
                        ]
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width*0.3,
                      child: FlatButton(
                        child: Text("Adicionar", style: TextStyle(color: Colors.yellow[800]),),
                        onPressed: ()=>print("Coloca o cartão."),
                        )
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.folder_shared),
                          Padding(padding: EdgeInsets.only(right: 10)),
                          Text(this.cpf),
                        ]
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width*0.3,
                      child: FlatButton(
                        child: Text("Adicionar", style: TextStyle(color: Colors.yellow[800]),),
                        onPressed: ()=>print("Coloca o cartão."),
                        )
                    )
                  ],
                )
              ],
            )
          ),
          Container(padding: EdgeInsets.only(right:20, left: 20),
          child: Divider(color: Colors.grey, height: 1,),),
          MaterialButton(
            onPressed: ()=> setAdress(),
            child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width*0.8,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(Icons.location_on)
                  ),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  Container(
                    width: MediaQuery.of(context).size.width*0.65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Entregar em", style: TextStyle(fontSize: 11.0, color: Colors.grey)),
                        Text("${this.endereco}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ]
                    )
                  ),
                  Container(
                    child: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.yellow[800]),
                  ),
                ]
              ),
            ),
          ),
          Container(padding: EdgeInsets.only(right:20, left: 20),
          child: Divider(color: Colors.grey, height: 1,),),
          Padding(padding: EdgeInsets.only(bottom: 20),),
          Container(
            width: MediaQuery.of(context).size.width*0.8,
            height: 50,
            child: RaisedButton(
              onPressed: () => comprar(),
              color: Colors.yellow[800],
              child: Text("Comprar", style: TextStyle(fontSize: 16.0, fontFamily: "Century Gothic", color: Colors.white)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          //Padding(padding: EdgeInsets.only(bottom: 20)),
          Container(
            height: 40,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width*0.8,
            child: FlatButton(child: Text("Limpar Carrinho", style: TextStyle(fontSize: 12, color: Colors.grey)),
              onPressed: (){
                control.limparCarrinho();
                Navigator.push(context, MaterialPageRoute(builder: (context) => GerenciarTelas()));
              },
            )
          ),          /*Container(
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
                        onPressed: () => comprar(),
                        child: Text('Comprar', style: TextStyle(fontSize: 13, color: Colors.white),),
                      ),
                ),

              ],
              
            ),
          ),*/
        ],
      ),
    );
  }

  void comprar()async{
    calcularPreco();
    if(this.cpf == "Informe seu CPF"){ 
      this.cpf = "Não definido";
    }
    if(this.numeroCartao == "Escolha um cartão"){
      this.numeroCartao = "Não definido";
    }
      print(this.cpf);
    Pedido pedido = Pedido(control.usuario, DateTime.now(), this.precoTotal, this.endereco, this.cpf, this.numeroCartao, this._itens);
    bool response = await control.cadastrarPedido(pedido);
    print(response);
    if (response) {
      control.limparCarrinho();
      //_showSnackBar('Compra realizada');
      await Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          Navigator.push(context, MaterialPageRoute(builder: (context) => GerenciarTelas()));
        });
      });
    } else {
        //_showSnackBar('Houve algum erro durante o pedido.');
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