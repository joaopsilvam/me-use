import 'dart:async';
import 'dart:core';
import 'package:conveniencia_central/model/item_carrinho.dart';
import 'package:conveniencia_central/model/pedido.dart';
import 'package:conveniencia_central/model/produto.dart';
import 'package:conveniencia_central/model/usuario.dart';
import 'package:conveniencia_central/data/database.dart';
import 'package:conveniencia_central/model/categoria.dart';

class Control {
  final DatabaseHelper _db = DatabaseHelper.internal();

  static Control _instance;
  static Usuario _usuario = null;

  factory Control() {
    _instance ??= Control._internal();
    return _instance;
  }
  Control._internal();

  Usuario get usuario => Control._usuario;

  void setUsuario(Usuario usuario) => Control._usuario = usuario;

  Future<Usuario> pegarUsuarioPorCredenciais(String email, String senha) async {
    return await this._db.pegarUsuarioPorCredenciais(email, senha);
  }

  Future<bool> criarUsuario(Usuario usuario) async {
    return await this._db.criarUsuario(usuario);
  }

  Future<bool> criarProduto(Produto produto) async {
    return await this._db.criarProduto(produto);
  }

  Future<bool> criarCategoria(Categoria categoria) async {
    return await this._db.criarCategoria(categoria);
  }

  Future<bool> adicionarNoCarrinho(Produto produto) async {
    return await this._db.adicionarNoCarrinho(produto);
  }

  Future<bool> cadastrarPedido(Pedido pedido) async {
    return await this._db.criarPedido(pedido);
  }

  Future<List<Usuario>> pegarUsuarios() async {
    return await this._db.pegarUsuarios();
  }

  Future<List<Produto>> pegarProdutos() async {
    return await this._db.pegarProdutos();
  }

  Future<List<Produto>> pegarProdutosPorChave() async {
    return await this._db.pegarProdutosPorChave();
  }

  Future<List<Produto>> pegarProdutosComecandoCom(String inicio) async {
    return await this._db.pegarProdutosComecandoCom(inicio);
  }

  Future<List<Produto>> pegarProdutosPorCategoria(Categoria categoria) async {
    return await this._db.pegarProdutosPorCategoria(categoria);
  }

  Future<List<Produto>> pegarItensDoCarrinho() async {
    return await this._db.pegarItensDoCarrinho();
  }

  Future<List<Categoria>> pegarCategorias() async {
    return await this._db.pegarCategorias();
  }

  Future<List<Pedido>> pegarPedidosDoUsuario(Usuario usuario) async {
    return await this._db.pegarPedidos(usuario);
  }

  Future<bool> removeItemCarrinho(Produto p, int quant) async {
    return await this._db.removeItemCarrinho(p, quant);
  }

  Future<int> limparCarrinho() async {
    return await this._db.limparCarrinho();
  }

  Future<bool> alterarSenha(String nome, String email, String senha) async {
    return await this._db.alterarSenha(nome, email, senha);
  }

  Future<bool> alterarDados(Usuario usuario) async {
    return await this._db.alterarDados(usuario);
  }
}
