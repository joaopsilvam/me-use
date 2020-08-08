import 'package:conveniencia_central/control/control.dart';
import 'package:flutter/material.dart';

class AlterarSenha extends StatefulWidget {
  State<StatefulWidget> createState() => _AlterarSenhaState();
}

class _AlterarSenhaState extends State<AlterarSenha> {
  final scafolldKey = GlobalKey<ScaffoldState>();
  bool isLoading;
  final formKey = GlobalKey<FormState>();
  String email;
  String pass;
  String pass2;
  String name;
  var verificado = Icons.clear;
  void initState() {
    super.initState();
    _ayncInitMethod();
  }

  _ayncInitMethod() async {
    bool icone = await pass == pass2;
    print("AAA");
    if (icone) {
      setState(() {
        print("AAA");
        verificado = Icons.check;
      });
    }
  }

  Widget build(BuildContext context) {
    return Material(
        key: scafolldKey,
        child: SingleChildScrollView(
            reverse: true,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            //width: MediaQuery.of(context).size.width*0.8,
            child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      //width: MediaQuery.of(context).size.width,
                      child: Container(
                        alignment: Alignment.centerLeft,
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
                      padding: EdgeInsets.only(top: 40),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 30,
                      child: Text(
                        'Altere sua',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Century Gothic",
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Container(
                      padding: EdgeInsets.only(right: 25, left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: 30,
                            child: Text('Senha',
                                style: TextStyle(
                                  fontSize: 35,
                                  fontFamily: "Aharoni",
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.15),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "Nome",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Century Gothic",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "WorkSansLight",
                                    fontSize: 12.0),
                                filled: true,
                                fillColor: Colors.white24,
                                hintText: "João Lucas",
                                suffixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                              onSaved: (val) => name = val,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 15)),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "E-mail",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Century Gothic",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "WorkSansLight",
                                    fontSize: 12.0),
                                filled: true,
                                fillColor: Colors.white24,
                                hintText: "joao_lucas@gmail.com",
                                suffixIcon: const Icon(
                                  Icons.mail,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                              onSaved: (val) => email = val,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 15)),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "Nova senha",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Century Gothic",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "WorkSansLight",
                                    fontSize: 12.0),
                                filled: true,
                                fillColor: Colors.white24,
                                hintText: "*********",
                                suffixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                              onSaved: (val) => pass = val,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 15)),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "Confirme sua senha",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Century Gothic",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "WorkSansLight",
                                    fontSize: 12.0),
                                filled: true,
                                fillColor: Colors.white24,
                                hintText: "*********",
                                suffixIcon: Icon(
                                  Icons.check,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                              onSaved: (val) => pass2 = val,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).size.height *
                                      0.15)),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      child: RaisedButton(
                        onPressed: alterar,
                        color: Colors.purple[500],
                        child: Text("Confirmar",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Century Gothic",
                                color: Colors.white)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                  ],
                ))));
  }

  void alterar() async {
    if (pass == pass2) {
      final form = formKey.currentState;
      if (form.validate()) {
        setState(() {
          form.save();
          isLoading = true;
        });
      }
      Control control = Control();
      bool confirmate = await control.alterarSenha(name, email, pass);
      if (confirmate) {
        Navigator.pop(context);
      } else {
        _showSnackBar('Erro! Preencha os campos ou troque o email');
      }
    } else {
      print("As senhas não coincidem.");
    }
  }

  _showSnackBar(String text) {
    final key = scafolldKey.currentState;
    key.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }
}
