import 'package:conveniencia_central/components/gerenciar_telas_usuario.dart';
import 'package:conveniencia_central/control/control.dart';
import 'package:conveniencia_central/pages/apresentacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Control c = Control();
    c.pegarUsuario();

    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(seconds: 4)).then((_) {
      if (c.usuario == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Apresentacao()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => GerenciarTelas()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Colors.blue,
        child: Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset("assets/Splashscreen.png", fit: BoxFit.cover),
      ),
    ));
  }
}
