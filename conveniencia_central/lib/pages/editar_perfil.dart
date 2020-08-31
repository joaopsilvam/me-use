import 'package:flutter/material.dart';
import 'package:conveniencia_central/control/control.dart';
import 'package:conveniencia_central/model/usuario.dart';

class EditarPerfil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  final scafolldKey = GlobalKey<ScaffoldState>();
  bool isLoading;
  final formKey = GlobalKey<FormState>();
  String pass;
  String number;
  String name;
  String address;
  final nomeControlador = TextEditingController();
  final numeroControlador = TextEditingController();
  final enderecoControlador = TextEditingController();
  final senhaControlador = TextEditingController();
  Control control = Control();

  void initState() {
    super.initState();
    _ayncInitMethod();
  }

  _ayncInitMethod() async {}

  @override
  Widget build(BuildContext context) {
    nomeControlador.text = control.usuario.nome;
    numeroControlador.text = control.usuario.telefone;
    enderecoControlador.text = control.usuario.endereco;
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
                      padding: EdgeInsets.only(top: 40),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 30,
                      child: Text(
                        'Editar',
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
                      child: Text('Perfil',
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
                      padding: EdgeInsets.only(right: 25, left: 25),
                      child: Column(
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
                              //initialValue: control.usuario.nome,
                              controller: nomeControlador,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "WorkSansLight",
                                  fontSize: 12.0),
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
                              "Senha",
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
                              controller: senhaControlador,
                              //initialValue: "*******",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "WorkSansLight",
                                  fontSize: 12.0),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "WorkSansLight",
                                    fontSize: 12.0),
                                filled: true,
                                fillColor: Colors.white24,
                                hintText: "********",
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
                              //initialValue: control.usuario.telefone,
                              controller: numeroControlador,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "WorkSansLight",
                                  fontSize: 12.0),
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
                            child: TextField(
                              controller: enderecoControlador,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "WorkSansLight",
                                  fontSize: 12.0),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.15),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      child: RaisedButton(
                        onPressed: _update,
                        color: Colors.purple[500],
                        child: Text("Alterar",
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

  void _update() async {
    Control control = Control();
    this.name = nomeControlador.text;
    this.number = numeroControlador.text;
    this.address = enderecoControlador.text;

    if (pass != "********") {
      this.pass = senhaControlador.text;
    } else {
      this.pass = control.usuario.senha;
    }
    print(name);
    print(pass);
    print(number);
    print(address);
    control.setUsuario(
        Usuario(name, pass, control.usuario.email, address, number));

    bool confirmate = await control.alterarDados(control.usuario);
    if (confirmate) {
      Navigator.pop(context);
      telaAvisos("Dados alterados com sucesso.", Colors.green);
    } else {
      telaAvisos("Erro inesperado.", Colors.red);
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
                        fontSize: 12,
                        color: Colors.black,
                        fontFamily: "Century Gothic",
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ));
        });
  }
}
