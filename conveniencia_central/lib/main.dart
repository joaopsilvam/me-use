import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:conveniencia_central/pages/splashscreen.dart';

void main(){
  runApp(MyApp());
  Firestore.instance.collection("usuarios").document("2").setData({"email" : "joao_lucas@gmail.com",
  "endereco": "Rua Jardim da Rosa", "nome": "João Lucas", "senha": "123", "telefone": "0800151286" });

}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MeUse.com",
      home: Splash(),
    );
  }
}
