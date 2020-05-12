import 'package:conveniencia_central/control/control.dart';
import 'package:conveniencia_central/pages/exibir_pedidos.dart';
import 'package:conveniencia_central/pages/tela_carrinho.dart';
import 'package:conveniencia_central/pages/tela_principal_usuario.dart';
import 'package:flutter/material.dart';

class GerenciarTelas extends StatefulWidget {


  @override
  _GerenciarTelasState createState() => _GerenciarTelasState();
}

class _GerenciarTelasState extends State<GerenciarTelas> {


  final scaffolKey = GlobalKey<ScaffoldState>();

  int corrente = 0;
  PrincipalUsuario principal;
  ExibirPedidos pedidos;
  TelaCarrinho carrinho;

  List<Widget> paginas;
  Widget paginaCorrente;

  @override
  void initState() {
    principal = PrincipalUsuario();
    pedidos = ExibirPedidos();
    carrinho = TelaCarrinho();
    paginas = [principal, pedidos, carrinho];
    paginaCorrente = principal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffolKey,
      backgroundColor: Colors.white,
      body: paginaCorrente,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: corrente,
        onTap: (int index) {
          setState(() {
              corrente = index;
              paginaCorrente = paginas[index];
            },
          );
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.yellow[800],
            ),
            title: Text(
              '',
              style: TextStyle(color: Colors.black54, fontSize: 1),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
              color: Colors.yellow[800],
            ),
            title: Text(
              '',
              style: TextStyle(color: Colors.black54, fontSize: 1),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.yellow[800],
            ),
            title: Text(
              '',
              style: TextStyle(color: Colors.black54, fontSize: 1),
            ),
          ),
        ],
      ),
    );
  }
}