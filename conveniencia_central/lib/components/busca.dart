import 'package:conveniencia_central/model/produto.dart';
import 'package:conveniencia_central/pages/tela_produto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Control/Control.dart';
import 'package:conveniencia_central/pages/tela_principal_usuario.dart';

class Busca extends StatefulWidget {
  var principal;

  Busca(this.principal);
  @override
  State<StatefulWidget> createState() => _BuscaState(this.principal);
}

class _BuscaState extends State<Busca> {
  _BuscaState(this.principal);

  final key = GlobalKey<FormState>();
  var principal;
  String text = '';
  List<Produto> produtos = new List<Produto>();

  Future<bool> _willpop() async {
    this.principal.alterarBusca();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: getBody(),
      ),
      onWillPop: () => _willpop(),
    );
  }

  Widget getBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: <Widget>[
                    Form(
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          onChanged: (value) {
                            onChangeSearch(value);
                          },
                          onFieldSubmitted: (term) {
                            search();
                          },
                          key: key,
                          decoration: InputDecoration(
                            //hintText: 'Prato ou restaurante',
                            icon: Icon(Icons.search),
                            hintStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade200, width: 0.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade200, width: 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    this.principal.alterarBusca();
                  },
                  icon: Icon(Icons.close))
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              itemCount: this.produtos.length,
              itemBuilder: (BuildContext context, int index) {
                if (this.produtos.isEmpty) {
                  return Center(
                    child:
                        text == '' ? Text('') : Text('Produto não encontrado.'),
                  );
                } else {
                  return MaterialButton(
                    height: 120,
                    minWidth: MediaQuery.of(context).size.width * 0.95,
                    onPressed: () {
                      goToProduct(this.produtos[index]);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.pink[700],
                      ),
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 130,
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Image.network(
                              '${this.produtos[index].imagem}',
                              height: 100,
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
                                      '${this.produtos[index].nome}',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 10)),
                                    Text(
                                      '${this.produtos[index].descricao}',
                                      style: TextStyle(color: Colors.white),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
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
    );
  }

  Widget barra_de_busca() {
    return Container(
      alignment: Alignment.center,
      //padding: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width - 50,
      height: 40,
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        onTap: () {
          print("aa");
        },
        //controller: emailControlador,
        decoration: InputDecoration(
          hintStyle: TextStyle(
              color: Colors.black, fontFamily: "WorkSansLight", fontSize: 18.0),
          filled: true,
          fillColor: Colors.white24,
          hintText: "Buscar produto",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(90.0)),
              borderSide: BorderSide(color: Colors.pink[700], width: 0.5)),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
      ),
    );
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
      return;
    }
    Control control = Control();
    await control.pegarProdutosComecandoCom(value).then((onValue) {
      setState(() {
        this.produtos = onValue;
      });
    });
  }

  void goToProduct(Produto r) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => TelaProduto(r, false)));
  }
}
