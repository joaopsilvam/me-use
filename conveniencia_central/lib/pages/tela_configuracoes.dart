import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conveniencia_central/control/control.dart';
import 'package:conveniencia_central/pages/ajuda.dart';
import 'package:conveniencia_central/pages/editar_perfil.dart';
import 'package:conveniencia_central/pages/pagamento.dart';
import 'package:conveniencia_central/pages/tela_inicio.dart';
import 'package:conveniencia_central/pages/termos_de_uso.dart';
import 'package:flutter/material.dart';

class TelaConfiguracoes extends StatefulWidget {
  State<StatefulWidget> createState() => _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {
  // Firestore.instance.collection("col").document("doc").setData({"texto" : "daniel"});

  Control control = Control();

  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.yellow[800],
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        //width: MediaQuery.of(context).size.width,
                        child: Container(
                          width: 60,
                          height: 25,
                          child: FlatButton(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 15,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(right: 20),
                        //width: MediaQuery.of(context).size.width * 0.65,
                        child: Text(
                          "Configurações",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: Colors.white,
                            fontFamily: "Arial",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 80),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person_pin,
                          size: MediaQuery.of(context).size.width * 0.27,
                          color: Colors.white,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: FittedBox(
                                  child: Text(
                                    " Olá,",
                                    style: TextStyle(
                                        fontFamily: "Century Gothic",
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: FittedBox(
                                    child: Text(
                                  '${control.usuario.nome.split(" ")[0]} ${control.usuario.nome.split(" ")[1]}',
                                  style: TextStyle(
                                      fontFamily: "Century Gothic",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                              ),
                              Padding(
                                padding: EdgeInsets.all(0),
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: FittedBox(
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0),
                                      child: Text(
                                        "Editar perfil",
                                        style: TextStyle(
                                            fontFamily: "Century Gothic",
                                            color: Colors.white,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditarPerfil()));
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 55, left: 20, right: 20),
              alignment: Alignment.topLeft,
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.purple[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    height: 30,
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: FittedBox(
                              child: Text(
                                "Pagamento",
                                style: TextStyle(
                                    fontFamily: "Century Gothic",
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 15,
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Pagamento()));
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  Divider(
                    height: 1,
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  Container(
                    alignment: Alignment.topLeft,
                    height: 30,
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.17,
                            child: FittedBox(
                              child: Text(
                                "Ajuda",
                                style: TextStyle(
                                    fontFamily: "Century Gothic",
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 15,
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Ajuda()));
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  Divider(
                    height: 1,
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  Container(
                    alignment: Alignment.topLeft,
                    height: 30,
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.16,
                            child: FittedBox(
                              child: Text(
                                "Sobre",
                                style: TextStyle(
                                    fontFamily: "Century Gothic",
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 15,
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermosDeUso()));
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  Divider(
                    height: 1,
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  Container(
                    alignment: Alignment.topLeft,
                    height: 30,
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: FittedBox(
                              child: Text(
                                "Sair",
                                style: TextStyle(
                                    fontFamily: "Century Gothic",
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 15,
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaInicio()));
                        control.setUsuario(null);
                        control.tirarUsuario();
                        control.limparCarrinho();
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
