import 'dart:math';

import 'package:conveniencia_central/model/categoria.dart';
import 'package:conveniencia_central/model/produto.dart';
import 'package:conveniencia_central/pages/tela_cadastro_produto.dart';
import 'package:flutter/material.dart';
import 'package:conveniencia_central/control/control.dart';
import 'package:conveniencia_central/model/usuario.dart';
import 'package:conveniencia_central/pages/tela_inicio.dart';

class PrincipalLoja extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PrincipalLojaState();
}

class _PrincipalLojaState extends State<PrincipalLoja> {

  Control controle = Control();
  Usuario usuario;
  final controlador = TextEditingController();
  final controlador2 = TextEditingController();
  List<Produto> produtos;

  void initState() {
    super.initState();
    _ayncInitMethod();
  }

  _ayncInitMethod() async {
    Control controle = Control();
    await controle.pegarProdutos().then((value) {
      setState(() {
        this.produtos = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    this.usuario = controle.usuario;
    return Scaffold(
      appBar: AppBar(title: Text("MeUse.com"),
        backgroundColor: Colors.pink[800],
        centerTitle: true,
      ),
      drawer: menu(),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget> [
            Padding(padding: EdgeInsets.only(top: 20)),
            barra_de_busca(),
            Padding(padding: EdgeInsets.only(top: 20)),
            categorias1(),
            categorias2(),
          ],
        ),
      ),
    );
  }

  Widget barra_de_busca(){
    return Container(
      alignment: Alignment.center,
      //padding: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width-50,
      height: 40,
      child: TextFormField(
      style: TextStyle(
        color: Colors.black),
        //controller: emailControlador,
        decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.black, fontFamily: "WorkSansLight", fontSize: 18.0),
        filled: true,
        fillColor: Colors.white24,
        hintText: "Buscar produto",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(90.0)),
          borderSide: BorderSide(color: Colors.pink[700], width: 0.5)),
          prefixIcon: const Icon(Icons.search, color: Colors.black,),
        ),
      ),
    );
  }

  Widget categorias1(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/3,
      color: Colors.pink,
    );
  }

  Widget categorias2(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/2,
      color: Colors.white,
      child: lista_produtos(),
    );
  }

 Widget lista_produtos() {
    if (this.produtos.isEmpty) {
      return Center(
        child: Text('Sem produtos cadastrados'),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(top:5),
        width: MediaQuery.of(context).size.width,
        height: 125,
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(this.produtos.length, (index){
            return Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              width: 10,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () => print("${this.produtos[index].categoria}"),         
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 10),),
                  Container(
                    child: Image.network('${this.produtos[index].imagem}',
                      width: 170,
                      height: 170,
                    ),
                  ),
                  Text("${this.produtos[index].quantidade}x ${this.produtos[index].nome}", style: TextStyle(color: Colors.pink[800], fontSize: 20, fontWeight: FontWeight.bold),),
                  Padding(padding: EdgeInsets.only(top: 10),),
                  Text("R\$ ${this.produtos[index].preco}0", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[500]),),
                  ],
                ),
              ),
            );
          })
        ),
      );
    }
  }

  Widget menu(){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text("MeUse.com", style: TextStyle(color: Colors.white, fontSize: 20),),
            decoration: BoxDecoration(
              color: Colors.pink[700],
            ),
          ),
          ListTile(
            title: Text("Perfil"),
            leading: Icon(Icons.account_circle),
            onTap: () {

            },
          ),
          ListTile(
            title: Text("Pedidos"),
            leading: Icon(Icons.assignment),
            onTap: () {

            },
          ),
          ListTile(
            title: Text("Cadastrar produto"),
            leading: Icon(Icons.assignment),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CadastrarProduto()));
            },
          ),
          ListTile(
            title: Text("Cadastrar categoria"),
            leading: Icon(Icons.help),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    title: null,
                    content: cadastrar_categoria(),
                  );
                }
              );
            },
          ),
          ListTile(
            title: Text("Configurações"),
            leading: Icon(Icons.settings),
            onTap: () {

            },
          ),
          ListTile(
            title: Text("Sair"),
            leading: Icon(Icons.close),
            onTap: () {
              Control controle = Control();
              controle.setUsuario(null);
              Navigator.push(context, MaterialPageRoute(builder: (context) => TelaInicio()));
            },
          ),
        ],
      ),
    );
  }


  Widget cadastrar_categoria() {
    String nome;
    String link;
    this.controlador.clear();
    return Container(
      height: 160,
      width: 300.0,
      child: Column(
        children: <Widget>[
            TextField(
              controller: this.controlador,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: "Informe o nome da categoria",
                  fillColor: Colors.white70),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            TextField(
              controller: this.controlador2,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: "Informe o link da imagem",
                  fillColor: Colors.white70),
            ),
          MaterialButton(
            height: 20,
            minWidth: 100,
            onPressed: () {
              nome = this.controlador.text;
              link = this.controlador2.text;
              Categoria categoria = Categoria(nome, link, "Nova Categoria");
              controle.criarCategoria(categoria);
              Navigator.pop(context);
            },
            child: Text(
              'Confirmar',
              style: TextStyle(fontSize: 16, color: Colors.pink[700]),
            ),
          )
        ],
      ),
    );
  }
}