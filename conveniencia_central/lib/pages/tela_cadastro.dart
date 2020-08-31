import 'package:conveniencia_central/pages/termos_de_uso.dart';
import 'package:flutter/material.dart';
import 'package:conveniencia_central/control/control.dart';
import 'package:conveniencia_central/model/usuario.dart';

class TelaCadastro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final scafolldKey = GlobalKey<ScaffoldState>();
  bool isLoading;
  final formKey = GlobalKey<FormState>();
  String email;
  String pass;
  String pass2;
  String number;
  String name;
  String address;
  bool checkBoxValue = false;
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

  @override
  Widget build(BuildContext context) {
    return Material(
        key: scafolldKey,
        child: SingleChildScrollView(
            reverse: true,
            padding: EdgeInsets.only(
                top: 60, bottom: MediaQuery.of(context).viewInsets.bottom),
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
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 30,
                      child: Text(
                        'Criar uma',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Century Gothic",
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 30,
                      child: Text('Conta',
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: "Aharoni",
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 25, left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
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
                              "Informe uma senha",
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
                              obscureText: true,
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
                              obscureText: true,
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
                          Padding(padding: EdgeInsets.only(bottom: 15)),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "Número de celular",
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
                                hintText: "(83)98115-2763",
                                suffixIcon: const Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                              onSaved: (val) => number = val,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 15)),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "Endereço",
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
                                hintText: "Rua Ana Zélia da Fonseca",
                                suffixIcon: const Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                              onSaved: (val) => address = val,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          Container(
                            height: 30,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Checkbox(
                                      value: checkBoxValue,
                                      activeColor: Colors.yellow[800],
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          checkBoxValue = newValue;
                                        });
                                      }),
                                ),
                                Container(
                                  width: 250,
                                  child: FlatButton(
                                    child: Text(
                                      "Aceitar Termos de Uso e Política de Privacidade.",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: "Century Gothic",
                                          color: Colors.grey),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TermosDeUso()));
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.06),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      child: RaisedButton(
                        onPressed: checkBoxValue ? _create : null,
                        color: Colors.yellow[800],
                        child: Text("Cadastrar",
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

  void _create() async {
    if (pass == pass2) {
      final form = formKey.currentState;
      if (form.validate()) {
        setState(() {
          form.save();
          isLoading = true;
        });
      }
      Control control = Control();
      Usuario temp = Usuario(name, pass, email, address, number);
      print('$name');
      bool confirmate = await control.criarUsuario(temp);
      if (confirmate) {
        Navigator.pop(context);
        telaAvisos("Cadastro realizado com sucesso.", Colors.green);
      } else {
        telaAvisos("Esse e-mail já foi cadastrado.", Colors.red);
      }
    } else {
      telaAvisos("As senhas não coincidem.", Colors.red);
    }
  }

  telaAvisos(String msg, Color cor) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Container(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.info,
                  color: cor,
                ),
                Padding(padding: EdgeInsets.only(right: 7)),
                Text(msg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                        fontFamily: "Century Gothic",
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ));
        });
  }
}
