import 'package:flutter/material.dart';

class Ajuda extends StatefulWidget {
  State<StatefulWidget> createState() => _AjudaState();
}

class _AjudaState extends State<Ajuda> {
  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
            child: Form(
                child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40),
        ),
        Container(
          alignment: Alignment.centerLeft,
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
          height: 35,
          child: Text('Ajuda',
              style: TextStyle(
                fontSize: 25,
                fontFamily: "Aharoni",
              )),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
        Container(
          padding: EdgeInsets.only(right: 25, left: 25),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.info,
                color: Colors.red[200],
                size: 60,
              ),
              Padding(padding: EdgeInsets.only(right: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  "Para mais informações ou relatar problemas técnicos, envie um e-mail para:\n\nmeuseempresa@gmail.com.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
            ],
          ),
        ),
      ],
    ))));
  }
}
