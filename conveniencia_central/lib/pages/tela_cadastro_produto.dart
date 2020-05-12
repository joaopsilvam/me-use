import 'package:conveniencia_central/model/produto.dart';
import 'package:flutter/material.dart';
import 'package:conveniencia_central/control/control.dart';

class CadastrarProduto extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CadastrarProdutoState();
}

class _CadastrarProdutoState extends State<CadastrarProduto> {
  final scafolldKey = GlobalKey<ScaffoldState>();
  bool isLoading;
  final formKey = GlobalKey<FormState>();
  String nome;
  double litragem;
  int quantidade;
  double preco;
  String categoria;
  String imagem;
  String descricao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: scafolldKey,
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                height: MediaQuery.of(context).size.height / 3 * 2,
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
                        Text(
                          'Cadastrar produto',
                          //style: kTextTitle.copyWith(fontSize: 21.0),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'nome'),
                          onSaved: (val) => nome = val,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'litragem'),
                          onSaved: (val) => litragem = double.parse(val),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'quantidade'),
                          onSaved: (val) => quantidade = int.parse(val),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        TextFormField(
                          decoration: InputDecoration
                          (hintText: 'preco'),
                          onSaved: (val) => preco = double.parse(val),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'categoria'),
                          onSaved: (val) => categoria = val,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'imagem'),
                          onSaved: (val) => imagem = val,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'descrição'),
                          onSaved: (val) => descricao = val,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),
                        RaisedButton(
                          color: Color(0xff38ad53),
                          onPressed: _create,
                          child: Text(
                            'Cadastrar',
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),
                      ],
                    )),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Positioned(
                        child: new Align(
                          alignment: FractionalOffset.bottomCenter,
                          //child: Image.asset('./assets/comida2.jpg'),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void _create() async {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        form.save();
        isLoading = true;
      });
    }
    Control control = Control();
    Produto temp = Produto(nome, litragem, quantidade, preco, categoria, imagem, descricao);
    print('$nome');
    bool confirmate = await control.criarProduto(temp);
    if (confirmate) {
      Navigator.pop(context);
    } else {
      _showSnackBar('Erro! Preencha os campos ou troque o nome');
    }
  }

  _showSnackBar(String text) {
    final key = scafolldKey.currentState;
    key.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }
}