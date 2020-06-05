import 'package:conveniencia_central/control/control.dart';
import 'package:conveniencia_central/model/categoria.dart';
import 'package:conveniencia_central/model/produto.dart';
import 'package:conveniencia_central/pages/tela_produto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProdutosPorCategoria extends StatefulWidget {

  Categoria categoria;
  ProdutosPorCategoria(this.categoria);
  @override
  _ProdutosPorCategoriaState createState() => _ProdutosPorCategoriaState(categoria);
}

class _ProdutosPorCategoriaState extends State<ProdutosPorCategoria> {

  Categoria categoria;
  List<Produto> produtos = List<Produto>();
  NumberFormat formatador = NumberFormat("0.00");

  _ProdutosPorCategoriaState(this.categoria);

  void initState() {
    super.initState();
    _ayncInitMethod();
  }

  _ayncInitMethod() async {
    Control controle = Control();
    await controle.pegarProdutosPorCategoria(this.categoria).then((value) {
      setState(() {
        this.produtos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buscar por categoria", style: TextStyle(fontSize: 23, color: Colors.white, fontFamily: "Aharoni", fontWeight: FontWeight.bold),),
        backgroundColor: Colors.yellow[800],
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 20,),
        onPressed: () => Navigator.pop(context)
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if(this.produtos.isNotEmpty){
      return Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        padding: EdgeInsets.only(top:5),
        
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.95,
        child: GridView.count(
          childAspectRatio: (170/260),
          crossAxisCount: 2,
          children: List.generate(this.produtos.length, (index){
            return Center(
                    /*height: 120,
                    minWidth: MediaQuery.of(context).size.width * 0.95,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TelaProduto(this.produtos[index])));
                    },*/
                    child: Container(
                      //margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(color: Colors.white, 
                            borderRadius: BorderRadius.all(Radius.circular(15)),

                      boxShadow: [BoxShadow(
                        
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset: Offset(1.0, 1.0)
                      )],),
                      width: 165,
                      height: 245,
                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 15)),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Image.network(
                              '${this.produtos[index].imagem}',
                              height: 100,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text('${this.produtos[index].nome}', style: TextStyle(fontSize: 14, fontFamily: "Century Gothic", fontWeight: FontWeight.bold, color: Colors.black)),
                                Padding(padding: EdgeInsets.only(top: 7)),
                                Text('${this.produtos[index].litragem}', style: TextStyle(fontSize: 12, fontFamily: "Century Gothic", fontWeight: FontWeight.bold, color: Colors.grey)),
                                Padding(padding: EdgeInsets.only(top: 7)),
                                Text('\$${formatador.format(num.parse(this.produtos[index].preco.toStringAsPrecision(2)))}', style: TextStyle(fontSize: 25, fontFamily: "Aharoni", fontWeight: FontWeight.bold, color: Colors.yellow[800]),),
                                Padding(padding: EdgeInsets.only(top: 7)),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8, right: 8),
                            child: Divider(height: 1, color: Colors.grey[300],),
                          ),
                          Padding(padding: EdgeInsets.only(top: 7)),
                          Container(
                            height: 25,
                            child:  FlatButton(
                              child: Text(
                                "Verificar produto",
                                style: TextStyle(fontSize: 12.0, color: Colors.yellow[800]),
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TelaProduto(this.produtos[index])));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
          })
        ),
      );
    /*
    return Container(
      color: Colors.grey[300],
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              itemCount: this.produtos.length,
              itemBuilder: (BuildContext context, int index) {
                if (this.produtos.isEmpty) {
                  return Center(
                    child: Text('Produto não encontrado.'),
                  );
                } else {
                  return Center(
                    /*height: 120,
                    minWidth: MediaQuery.of(context).size.width * 0.95,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TelaProduto(this.produtos[index])));
                    },*/
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        //border: Border.all(width: 1),
                        //borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: 170,
                      height: 260,
                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 10)),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Image.network(
                              '${this.produtos[index].imagem}',
                              height: 111,
                              width: 150,
                            ),
                          ),
                          Container(
                            child: Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'R\$ ${this.produtos[index].preco}0',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.yellow[800]),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 3)),
                                    Text(
                                      '${this.produtos[index].nome}',
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 3)),
                                    Text(
                                      '${this.produtos[index].litragem}g',
                                      style: TextStyle(fontSize: 13, color: Colors.grey),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Divider(height: 5, color: Colors.grey[300],),
                          FlatButton(
                            child: Text(
                              "Verificar produto",
                              style: TextStyle(fontSize: 12.0, color: Colors.yellow[800]),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TelaProduto(this.produtos[index])));
                            },
                          ),
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
    );*/}
  }
}