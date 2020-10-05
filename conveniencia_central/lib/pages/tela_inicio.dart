import 'package:conveniencia_central/components/gerenciar_telas_usuario.dart';
import 'package:conveniencia_central/pages/alterar_senha.dart';
import 'package:conveniencia_central/pages/apresentacao.dart';
import 'package:conveniencia_central/pages/tela_principal_loja.dart';
import 'package:flutter/material.dart';
import 'package:conveniencia_central/pages/tela_cadastro.dart';
import 'package:conveniencia_central/control/control.dart';
import 'package:flutter/services.dart';

class TelaInicio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
  String email;
  String senha;
  final emailControlador = TextEditingController();
  final senhaControlador = TextEditingController();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => Apresentacao())),
      child: Material(
          child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          reverse: true,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.08)),
              Container(
                height: MediaQuery.of(context).size.width * 0.25,
                width: MediaQuery.of(context).size.width * 0.45,
                child:
                    Image.asset('assets/Logo_login.png', fit: BoxFit.scaleDown),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.08)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: FittedBox(
                          child: Text(
                            "Prossiga com seu",
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
                            "Login",
                            style: TextStyle(
                              fontFamily: "Aharoni",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.2)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.13,
                      child: FittedBox(
                        child: Text(
                          "E-mail",
                          style: TextStyle(
                            fontFamily: "Century Gothic",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "WorkSansLight",
                            fontSize:
                                MediaQuery.of(context).size.width * 0.035),
                        controller: emailControlador,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: "WorkSansLight",
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035),
                          filled: true,
                          fillColor: Colors.white24,
                          hintText: "jose_lucas@gmail.com",
                          suffixIcon: const Icon(Icons.person,
                              color: Colors.black, size: 15),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.13,
                        child: FittedBox(
                          child: Text(
                            "Senha",
                            style: TextStyle(
                              fontFamily: "Century Gothic",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "WorkSansLight",
                            fontSize:
                                MediaQuery.of(context).size.width * 0.035),
                        controller: senhaControlador,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: "WorkSansLight",
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035),
                          filled: true,
                          fillColor: Colors.white24,
                          hintText: "*********",
                          suffixIcon: const Icon(
                            Icons.lock,
                            color: Colors.black,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.15)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () => logarUsuario(),
                        color: Colors.yellow[800],
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: FittedBox(
                            child: Text("Entrar",
                                style: TextStyle(
                                    fontFamily: "Century Gothic",
                                    color: Colors.white)),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.09,
                width: MediaQuery.of(context).size.width * 0.27,
                child: FlatButton(
                  child: FittedBox(
                    child: Text(
                      "Cadastre-se",
                      style: TextStyle(
                          fontFamily: "Century Gothic", color: Colors.grey),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaCadastro()));
                  },
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.09,
                width: MediaQuery.of(context).size.width * 0.38,
                child: FlatButton(
                  child: FittedBox(
                    child: Text(
                      "Esqueceu a senha?",
                      style: TextStyle(
                          fontFamily: "Century Gothic", color: Colors.grey),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AlterarSenha()));
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  void logarUsuario() async {
    this.email = emailControlador.text;
    this.senha = senhaControlador.text;
    Control controle = Control();
    var usuario = await controle.pegarUsuarioPorCredenciais(
        this.email.split(" ")[0], this.senha.split(" ")[0]);
    print("Usuário: ${usuario}");
    if (usuario != null) {
      controle.setUsuario(usuario);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => GerenciarTelas()));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Container(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.info,
                    color: Colors.red,
                  ),
                  Padding(padding: EdgeInsets.only(right: 7)),
                  Text('Usuário ou senha incorretos.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: "Century Gothic",
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ));
          });
    }
  }

  Widget setupAlertDialoadContainer() {
    return Container(child: Text("AAA"));
  }

  void rest() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PrincipalLoja()));
  }
}
