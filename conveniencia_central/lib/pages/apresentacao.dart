import 'package:conveniencia_central/control/control.dart';
import 'package:conveniencia_central/pages/exibir_pedidos.dart';
import 'package:conveniencia_central/pages/tela_carrinho.dart';
import 'package:conveniencia_central/pages/tela_inicio.dart';
import 'package:conveniencia_central/pages/tela_principal_usuario.dart';
import 'package:conveniencia_central/pages/verificar_produtos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Apresentacao extends StatefulWidget {
  @override
  _ApresentacaoState createState() => _ApresentacaoState();
}

class _ApresentacaoState extends State<Apresentacao> {
  final controller = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: <Widget>[
        tela1(),
        tela2(),
        tela3(),
      ],
    );
  }

  Widget tela1() {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/Apresentacao1.png', fit: BoxFit.fill),
        ),
        Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.58,
              child:
                  Image.asset('assets/Logo_apresentacao.png', fit: BoxFit.fill),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.17),
              width: MediaQuery.of(context).size.width,
              child: Row(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    "Deslize para saber mais",
                    style: TextStyle(
                        color: Colors.purple[500],
                        fontSize: 17,
                        fontFamily: "Montserrat",
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.purple[500],
                    size: 15,
                  ),
                )
              ]),
            ),
          ],
        ),
      ],
    );
  }

  Widget tela2() {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/Apresentacao2.png', fit: BoxFit.fill),
        ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15),
              alignment: Alignment.topCenter,
              child: Text(
                "Falta pouco pra",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: "Montserrat",
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                "matar a sua fome",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontFamily: "Montserrat",
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.63,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerificarProdutos()));
                  },
                  color: Colors.white,
                  child: Text("Conheça os nossos produtos",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: "Montserrat",
                          color: Colors.purple[500])),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget tela3() {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/Apresentacao3.png', fit: BoxFit.fill),
        ),
        Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15),
                alignment: Alignment.topCenter,
                child: Text("Falta pouco pra",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontFamily: "Montserrat",
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w300))),
            Container(
              //padding: EdgeInsets.only(top: 5),
              alignment: Alignment.topCenter,
              child: Text(
                "matar a sua fome",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontFamily: "Montserrat",
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.63,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TelaInicio()));
                  },
                  color: Colors.white,
                  child: Text("Fazer login",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: "Montserrat",
                          color: Colors.purple[500])),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
