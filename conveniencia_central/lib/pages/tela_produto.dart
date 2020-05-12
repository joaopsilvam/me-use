import 'package:conveniencia_central/pages/tela_carrinho.dart';
import 'package:flutter/material.dart';
import 'package:conveniencia_central/model/produto.dart';
import 'package:conveniencia_central/control/control.dart';

class TelaProduto extends StatefulWidget {
  Produto produto;

  TelaProduto(this.produto);

  @override
  _TelaProdutoState createState() => _TelaProdutoState(produto);
}

class _TelaProdutoState extends State<TelaProduto> {

  Produto produto;
  int quant = 1;
  List<Produto> bag = List<Produto>();
  Control control = Control();
  
  final scafolldKey = GlobalKey<ScaffoldState>();

  _TelaProdutoState(this.produto);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafolldKey,
      body: page(),
    );
  }

  Widget page()
  {
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
                      right: MediaQuery.of(context).size.width / 9,),
                ),
                Text(
                  'Detalhes do item',
                  style: TextStyle(fontSize: 16, letterSpacing: 1.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),

          Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1
                )),
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20)),
                  child: Image.network(
                    '${this.produto.imagem}',
                    //fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height*0.35,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                ),
                Text(
                  '${this.produto.nome}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                
                Text(
                  '${this.produto.descricao}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  )
                
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(
                  'R\$ ${this.produto.preco}0',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  )
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Container(
            height: 10,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade200,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
            // height: MediaQuery.of(context).size.height / 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                RawMaterialButton(
                  child: Icon(Icons.remove, color: Colors.white, size: 10.0,),
                  elevation: 6.0,
                  constraints: BoxConstraints.tightFor(
                    width: 20.0,
                    height: 20.0
                  ),
                  shape: CircleBorder(),
                  fillColor: Colors.yellow[800],
                  onPressed: () {
                    setState(() {
                      quant<=1?
                       quant = quant: --quant;
                    });
                  },
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