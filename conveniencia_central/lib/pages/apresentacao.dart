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
  double l;
  double a;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    l = MediaQuery.of(context).size.width;
    a = MediaQuery.of(context).size.height;
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
          child: Image.asset('assets/Apresentacao1.png', fit: BoxFit.cover),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: FittedBox(
                          child: Text(
                        "Deslize para saber mais",
                        style: TextStyle(
                            color: Colors.purple[500],
                            fontFamily: "Montserrat",
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w600),
                      )),
                    ),
                    Padding(padding: EdgeInsets.only(right: 10)),
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Color.fromRGBO(176, 5, 200, 1),
                  Color.fromRGBO(143, 5, 163, 1)
                ]),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/Apresentacao2.png', fit: BoxFit.fitWidth),
        ),
        Column(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15),
                alignment: Alignment.topCenter,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text("Falta pouco para",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: l * 0.0583,
                          fontFamily: "Montserrat",
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w300)),
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.6,
                //padding: EdgeInsets.only(top: 5),
                alignment: Alignment.topCenter,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    "fazer suas compras",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: l * 0.0638,
                        fontFamily: "Montserrat",
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w600),
                  ),
                )),
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
                  child: FittedBox(
                    child: Text("Conheça os nossos produtos",
                        style: TextStyle(
                            fontSize: l * 0.044,
                            fontFamily: "Montserrat",
                            color: Colors.purple[500])),
                  ),
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Color.fromRGBO(249, 167, 59, 1),
                  Color.fromRGBO(214, 136, 29, 1)
                ]),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/Apresentacao3.png', fit: BoxFit.fitWidth),
        ),
        Column(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15),
                alignment: Alignment.topCenter,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text("Falta pouco para",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: l * 0.0583,
                          fontFamily: "Montserrat",
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w300)),
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.6,
                //padding: EdgeInsets.only(top: 5),
                alignment: Alignment.topCenter,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    "fazer suas compras",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: l * 0.0638,
                        fontFamily: "Montserrat",
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w600),
                  ),
                )),
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
                  child: FittedBox(
                    child: Text("Fazer login",
                        style: TextStyle(
                            fontSize: l * 0.044,
                            fontFamily: "Montserrat",
                            color: Colors.purple[500])),
                  ),
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
