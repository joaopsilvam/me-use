import 'package:conveniencia_central/pages/tela_inicio.dart';
import 'package:conveniencia_central/pages/termos_de_uso.dart';
import 'package:flutter/material.dart';
import 'package:conveniencia_central/control/control.dart';
import 'package:conveniencia_central/model/usuario.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
  String sobrenome;
  String rua;
  String bairro;
  String no;
  var maskFormatter = new MaskTextInputFormatter(
      mask: '(##) ###############', filter: {"#": RegExp(r'[0-9]')});
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
            padding: EdgeInsets.only(
                top: 30, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: formKey,
              child: Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 25,
                      child: FlatButton(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 15,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TelaInicio()));
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1,
                        right: MediaQuery.of(context).size.width * 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: FittedBox(
                              child: Text(
                                "Crie sua",
                                style: TextStyle(
                                  fontFamily: "Century Gothic",
                                ),
                              ),
                            )),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: FittedBox(
                              child: Text(
                                "Conta",
                                style: TextStyle(
                                  fontFamily: "Aharoni",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.1),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  child: FittedBox(
                                    child: Text(
                                      "Nome",
                                      style: TextStyle(
                                        fontFamily: "Century Gothic",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                              Container(
                                height: 40,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "WorkSansLight",
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "WorkSansLight",
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.19,
                                  child: FittedBox(
                                    child: Text(
                                      "Sobrenome",
                                      style: TextStyle(
                                        fontFamily: "Century Gothic",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                              Container(
                                height: 40,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "WorkSansLight",
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "WorkSansLight",
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                    filled: true,
                                    fillColor: Colors.white24,
                                    hintText: "Andrade Monteiro",
                                    suffixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  ),
                                  onSaved: (val) => sobrenome = val,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 15)),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  child: FittedBox(
                                    child: Text(
                                      "E-mail",
                                      style: TextStyle(
                                        fontFamily: "Century Gothic",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                              Container(
                                height: 40,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "WorkSansLight",
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "WorkSansLight",
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.31,
                                  child: FittedBox(
                                    child: Text(
                                      "Informe uma senha",
                                      style: TextStyle(
                                        fontFamily: "Century Gothic",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                              Container(
                                height: 40,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "WorkSansLight",
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "WorkSansLight",
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: FittedBox(
                                    child: Text(
                                      "Confirme sua senha",
                                      style: TextStyle(
                                        fontFamily: "Century Gothic",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                              Container(
                                height: 40,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "WorkSansLight",
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "WorkSansLight",
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: FittedBox(
                                    child: Text(
                                      "Número de celular",
                                      style: TextStyle(
                                        fontFamily: "Century Gothic",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                              Container(
                                height: 40,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [maskFormatter],
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "WorkSansLight",
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "WorkSansLight",
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035),
                                    filled: true,
                                    fillColor: Colors.white24,
                                    hintText: "(83) 98115-2763",
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                  child: FittedBox(
                                    child: Text(
                                      "Rua",
                                      style: TextStyle(
                                        fontFamily: "Century Gothic",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                              Container(
                                height: 40,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "WorkSansLight",
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "WorkSansLight",
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035),
                                    filled: true,
                                    fillColor: Colors.white24,
                                    hintText: "Rua Ana Zélia da Fonseca",
                                    suffixIcon: const Icon(
                                      Icons.location_on,
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  ),
                                  onSaved: (val) => rua = val,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 15)),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.09,
                                              child: FittedBox(
                                                child: Text(
                                                  "Bairro",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        "Century Gothic",
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )),
                                          Container(
                                            height: 40,
                                            child: TextFormField(
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily: "WorkSansLight",
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.035),
                                              decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: "WorkSansLight",
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.035),
                                                filled: true,
                                                fillColor: Colors.white24,
                                                hintText: "Centro",
                                                suffixIcon: const Icon(
                                                  Icons.location_on,
                                                  color: Colors.black,
                                                  size: 15,
                                                ),
                                              ),
                                              onSaved: (val) => bairro = val,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.038,
                                              child: FittedBox(
                                                child: Text(
                                                  "Nº",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        "Century Gothic",
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            height: 40,
                                            child: TextFormField(
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    50)
                                              ],
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily: "WorkSansLight",
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.035),
                                              decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: "WorkSansLight",
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.035),
                                                filled: true,
                                                fillColor: Colors.white24,
                                                hintText: "12",
                                                suffixIcon: const Icon(
                                                  Icons.location_on,
                                                  color: Colors.black,
                                                  size: 15,
                                                ),
                                              ),
                                              onSaved: (val) => no = val,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
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
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: FlatButton(
                                        child: Text(
                                          "Aceitar Termos de Uso e Política de Privacidade.",
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.035,
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
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045,
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
                    ),
                  )
                ],
              )),
            )));
  }

  void _create() async {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        form.save();
        isLoading = true;
      });
    }
    print(pass);
    if (pass == pass2 && email.contains("@") && email.contains(".com")) {
      if (name == null ||
          sobrenome == null ||
          pass == null ||
          email == null ||
          bairro == null ||
          rua == null ||
          no == null ||
          number == null ||
          name.isEmpty ||
          sobrenome.isEmpty ||
          pass.isEmpty ||
          email.isEmpty ||
          bairro.isEmpty ||
          rua.isEmpty ||
          no.isEmpty ||
          number.isEmpty) {
        print(
            "${name}, ${pass.split(" ")[0]}, ${email.split(" ")[0]},${this.bairro}, ${this.rua}, ${this.no}., ${number}");
        telaAvisos("Informe todos os dados.", Colors.yellow);
      } else {
        Control control = Control();
        Usuario temp = Usuario("$name $sobrenome", pass, email,
            "${this.bairro}, ${this.rua}, ${this.no}.", number);
        print('$name');
        bool confirmate = await control.criarUsuario(temp);
        if (confirmate) {
          Navigator.pop(context);
          telaAvisos("Cadastro realizado com sucesso.", Colors.green);
        } else {
          telaAvisos("Esse e-mail já foi cadastrado.", Colors.red);
        }
      }
    } else if (pass != pass2) {
      telaAvisos("As senhas não coincidem.", Colors.red);
    } else {
      telaAvisos("Informe um e-mail válido.", Colors.red);
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
                        fontSize: MediaQuery.of(context).size.width * 0.033,
                        color: Colors.black,
                        fontFamily: "Century Gothic",
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ));
        });
  }
}
