import 'dart:io';
import 'dart:math';
import 'package:conveniencia_central/control/control.dart';
import 'package:conveniencia_central/model/item_carrinho.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:conveniencia_central/model/usuario.dart';
import 'package:conveniencia_central/model/produto.dart';
import 'package:conveniencia_central/model/pedido.dart';
import 'package:conveniencia_central/model/categoria.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path,
        version: 1, onCreate: _onCreate, onConfigure: _onConfigure);
    return ourDb;
  }

  void _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Usuario(idUsuario TEXT PRIMARY KEY, nome TEXT, senha TEXT, email TEXT UNIQUE, endereco TEXT, telefone TEXT)");
  }

  Future<bool> mantemUsuario(Usuario usuario) async {
    var dbClient = await db;
    try {
      await dbClient.rawInsert(
          "INSERT INTO Usuario(idUsuario, nome, senha, email, endereco, telefone) VALUES(?,?,?,?,?,?)",
          [
            usuario.id,
            usuario.nome,
            usuario.senha,
            usuario.email,
            usuario.endereco,
            usuario.telefone
          ]);
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<Usuario> pegarUsuario() async {
    var dbClient = await db;
    dynamic test = await dbClient.rawQuery('SELECT * FROM Usuario');
    print("ZZ");
    print(test[0]);
    try {
      print("c");
      return Usuario.map(test[0]);
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<int> limparUsuario() async {
    var dbClient = await db;
    int res = await dbClient.rawDelete("DELETE From Usuario");
    return res;
  }

  Future<bool> criarUsuario(Usuario usuario) async {
    QuerySnapshot bd = await Firestore.instance
        .collection("usuarios")
        .where('email', isEqualTo: usuario.email)
        .getDocuments();
    if (bd.documents.isEmpty) {
      print("QQQQQQ");
      try {
        Firestore.instance
            .collection("usuarios")
            .document("${usuario.email}")
            .setData(
          {
            "email": "${usuario.email}",
            "endereco": "${usuario.endereco}",
            "nome": "${usuario.nome}",
            "senha": "${usuario.senha}",
            "telefone": "${usuario.telefone}"
          },
        );
        return true;
      } catch (err) {
        print(err);
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> criarProduto(Produto produto) async {
    try {
      Firestore.instance.collection("produtos").document().setData(
        {
          "nome": "${produto.nome}",
          "litragem": "${produto.litragem}",
          "quantidade": "${produto.quantidade}",
          "preco": "${produto.preco}",
          "categoria": "${produto.categoria}",
          "imagem": "${produto.imagem}",
          "descricao": "${produto.descricao}"
        },
      );
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> criarCategoria(Categoria categoria) async {
    var dbClient = await db;
    try {
      await dbClient.rawInsert(
          "INSERT INTO Categoria(nome, imagem) VALUES(?,?)",
          [categoria.nome, categoria.imagem]);
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> adicionarNoCarrinho(Produto produto) async {
    try {
      Firestore.instance.collection("carrinho").document().setData(
        {
          "nome": "${produto.nome}",
          "quantidade": produto.quantidade,
          "preco": produto.preco,
          "imagem": "${produto.imagem}"
        },
      );
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> cadastrarPedido(Pedido pedido) async {
    int id = Random().nextInt(1000);
    try {
      Firestore.instance.collection("pedidos").document("$id").setData({
        "idUsuario": "${pedido.usuario.id}",
        "precoTotal": pedido.precoTotal,
        "endereco": "${pedido.endereco}",
        "cpf": "${pedido.cpf}",
        "numeroCartao": "${pedido.numeroCartao}",
        "data": "${pedido.data}"
      });
      List<Produto> produtos = pedido.produtos;
      for (int i = 0; i < produtos.length; i++) {
        print("Id do produto atual: ${produtos[i].nome}");
        Firestore.instance
            .collection("pedidos")
            .document("$id")
            .collection("produtos")
            .document()
            .setData({
          "nome": "${produtos[i].nome}",
          "idPedido": "$id",
          "idUsuario": "${pedido.usuario.id}",
          "idProduto": "${produtos[i].idProduto}",
          "quantidade": produtos[i].quantidade,
          "preco": produtos[i].preco
        });
      }
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> criarPedido(Pedido pedido) async {
    QuerySnapshot bd = await Firestore.instance
        .collection("usuarios")
        .document("${pedido.usuario.email}")
        .collection("pedidos")
        .getDocuments();
    int id;
    if (bd.documents.isEmpty) {
      id = 0;
    } else {
      id = int.parse(bd.documents.last.documentID);
    }
    try {
      Firestore.instance
          .collection("usuarios")
          .document("${pedido.usuario.email}")
          .collection("pedidos")
          .document("${id + 1}")
          .setData({
        "precoTotal": pedido.precoTotal,
        "endereco": "${pedido.endereco}",
        "cpf": "${pedido.cpf}",
        "numeroCartao": "${pedido.numeroCartao}",
        "data": "${pedido.data}"
      });

      List<Produto> produtos = pedido.produtos;
      for (int i = 0; i < produtos.length; i++) {
        print("Id do produto atual: ${produtos[i].nome}");
        Firestore.instance
            .collection("usuarios")
            .document("${pedido.usuario.email}")
            .collection("pedidos")
            .document("${id + 1}")
            .collection("produtos")
            .document()
            .setData({
          "nome": "${produtos[i].nome}",
          "idPedido": "${id + 1}",
          "idUsuario": "${pedido.usuario.id}",
          "idProduto": "${produtos[i].idProduto}",
          "quantidade": produtos[i].quantidade,
          "preco": produtos[i].preco
        });
      }
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> alterarSenha(String nome, String email, String senha) async {
    QuerySnapshot bd = await Firestore.instance
        .collection("usuarios")
        .where('email', isEqualTo: email)
        .getDocuments();

    try {
      if (bd.documents.isNotEmpty) {
        print("Usuário encontrado.");
        var usuario = bd.documents[0].data;
        usuario.addAll({'idUsuario': bd.documents[0].documentID});
        Firestore.instance.collection("usuarios").document(email).setData({
          "email": "${usuario['email']}",
          "endereco": "${usuario['endereco']}",
          "nome": "${usuario['nome']}",
          "telefone": "${usuario['telefone']}",
          "senha": senha
        });
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<bool> alterarDados(Usuario user) async {
    QuerySnapshot bd = await Firestore.instance
        .collection("usuarios")
        .where('email', isEqualTo: user.email)
        .getDocuments();
    print("AAA");
    try {
      if (bd.documents.isNotEmpty) {
        print("Usuário encontrado.");
        var usuario = bd.documents[0].data;
        usuario.addAll({'idUsuario': bd.documents[0].documentID});
        Firestore.instance.collection("usuarios").document(user.email).setData({
          "email": "${usuario['email']}",
          "endereco": "${user.endereco}",
          "nome": "${user.nome}",
          "telefone": "${user.telefone}",
          "senha": "${user.senha}",
        });
      }
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<Usuario> pegarUsuarioPorCredenciais(String email, String senha) async {
    /*Firestore.instance.collection("produtos").document().setData({"nome" : "Arroz Camil",
    "litragem": "5 kg", "quantidade": 1, "preco": "15.50", 
    "categoria": "Mercearia", "imagem": "https://static.carrefour.com.br/medias/sys_master/images/images/hfb/h28/h00/h00/9476860543006.jpg", "descricao": "Arroz que teve a sua casca, farelo e germe removido. Isso altera o sabor, a textura e a aparência do arroz e ajuda a evitar a deterioração, além de prolongar sua vida útil. Após a moagem, o arroz é polido, resultando em uma semente com uma aparência brilhante e branca."},);
   */
    QuerySnapshot bd = await Firestore.instance
        .collection("usuarios")
        .where('email', isEqualTo: email)
        .where('senha', isEqualTo: senha)
        .getDocuments();
    if (bd.documents.isNotEmpty) {
      print("Usuário encontrado.");
      var usuario = bd.documents[0].data;
      usuario.addAll({'idUsuario': bd.documents[0].documentID});
      return Usuario.map(usuario);
    } else {
      print("Usuário não encontrado no sistema.");
      return null;
    }
  }

  Future<List<Usuario>> pegarUsuarios() async {
    QuerySnapshot bd =
        await Firestore.instance.collection("usuarios").getDocuments();
    if (bd.documents.isNotEmpty) {
      List<Usuario> usuarios = new List<Usuario>();
      var usuario;
      for (dynamic i in bd.documents) {
        usuario = i.data;
        usuario.addAll({'idUsuario': i.documentID});
        usuarios.add(Usuario.map(usuario));
      }
      print("Usuário encontrado.");
      return usuarios;
    } else {
      print("Usuários não encontrados no sistema.");
      return null;
    }
  }

  Future<List<Produto>> pegarProdutos() async {
    QuerySnapshot bd =
        await Firestore.instance.collection("produtos").getDocuments();
    if (bd.documents.isNotEmpty) {
      List<Produto> produtos = new List<Produto>();
      var produto;
      for (dynamic i in bd.documents) {
        produto = i.data;
        produto.addAll({'idProduto': i.documentID});
        produtos.add(Produto.map(produto));
      }
      print("Produtos encontrados.");
      return produtos;
    } else {
      print("Nenhum produto foi encontrado no sistema.");
      return null;
    }
  }

  Future<List<Produto>> pegarProdutosPorChave() async {
    List<String> chaves = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];
    List<Produto> produtos2 = List();
    for (int i = 0; i < chaves.length; i++) {
      QuerySnapshot bd = await Firestore.instance
          .collection("produtos")
          .where('chave', isEqualTo: chaves[i].toUpperCase())
          .getDocuments();
      if (bd.documents.isNotEmpty) {
        List<Produto> produtos = new List<Produto>();
        var produto;
        for (dynamic i in bd.documents) {
          produto = i.data;
          produto.addAll({'idProduto': i.documentID});
          produtos.add(Produto.map(produto));
        }
        produtos2.addAll(produtos);
      }
    }
    return produtos2;
    /*} else {
      print("Nenhum produto foi encontrado no sistema.");
      return null;
    }*/
  }

  Future<List<Categoria>> pegarCategorias() async {
    QuerySnapshot bd =
        await Firestore.instance.collection("categorias").getDocuments();
    if (bd.documents.isNotEmpty) {
      List<Categoria> categorias = new List<Categoria>();
      var categoria;
      for (dynamic i in bd.documents) {
        categoria = i.data;
        categoria.addAll({'idCategoria': i.documentID});
        categorias.add(Categoria.map(categoria));
      }
      return categorias;
    } else {
      print("Nenhum produto foi encontrado no sistema.");
      return null;
    }
  }

  Future<List<Pedido>> pegarPedidosDoUsuario(Usuario usuario) async {
    QuerySnapshot bd = await Firestore.instance
        .collection("pedidos")
        .where('idUsuario', isEqualTo: usuario.id)
        .getDocuments();
    if (bd.documents.isNotEmpty) {
      List<Pedido> pedidos = new List<Pedido>();
      QuerySnapshot produtos;
      List<Produto> itens;
      for (dynamic i in bd.documents) {
        produtos = await Firestore.instance
            .collection("pedidos")
            .document(i.documentID)
            .collection("produtos")
            .getDocuments();
        itens = List<Produto>();

        for (dynamic j in produtos.documents) {
          itens.add(Produto.map(j));
        }
        var temp = i.data;

        temp.addAll({'idPedido': i.documentID});
        Pedido p = Pedido.maps(temp);
        p.setProdutos(itens);
        pedidos.add(p);
      }

      return pedidos;
    } else {
      print("Nenhum pedido foi encontrado no sistema.");
      return null;
    }
  }

  Future<List<Pedido>> pegarPedidos(Usuario usuario) async {
    print("A");
    QuerySnapshot bd = await Firestore.instance
        .collection("usuarios")
        .document("${usuario.email}")
        .collection("pedidos")
        .getDocuments();
    if (bd.documents.isNotEmpty) {
      List<Pedido> pedidos = new List<Pedido>();
      QuerySnapshot produtos;
      List<Produto> itens;
      for (dynamic i in bd.documents) {
        /*produtos = await Firestore.instance
            .collection("usuarios")
            .document("${usuario.email}")
            .collection("pedidos")
            .document(i.documentID)
            .collection("produtos")
            .getDocuments();
        itens = List<Produto>();

        for (dynamic j in produtos.documents) {
          itens.add(Produto.map(j));
        }*/
        var temp = i.data;

        temp.addAll({'idPedido': i.documentID});
        print(i.data);

        Pedido p = Pedido.maps(temp);
        p.setProdutos(itens);
        pedidos.add(p);
      }

      pedidos = pedidos.reversed.toList();
      print(pedidos[0].usuario);
      return pedidos;
    } else {
      print("Nenhum pedido foi encontrado no sistema.");
      return null;
    }
  }

  Future<List<Produto>> pegarProdutosDoPedido(Pedido p, Usuario u) async {
    QuerySnapshot bd = await Firestore.instance
        .collection("usuarios")
        .document("${u.email}")
        .collection("pedidos")
        .document("${p.idPedido}")
        .collection("produtos")
        .getDocuments();
    print("produtos");
    print(bd.documents);
    if (bd.documents.isNotEmpty) {
      List<Produto> itens = List<Produto>();
      for (dynamic j in bd.documents) {
        itens.add(Produto.map(j));
      }

      return itens;
    } else {
      print("Não há produtos nesse pedido no sistema.");
      return null;
    }
  }

  Future<List<Produto>> pegarItensDoCarrinho() async {
    QuerySnapshot bd =
        await Firestore.instance.collection("carrinho").getDocuments();
    if (bd.documents.isNotEmpty) {
      List<Produto> itensCarrinho = new List<Produto>();
      var produto;
      for (dynamic i in bd.documents) {
        produto = i.data;
        produto.addAll({'idProduto': i.documentID});
        itensCarrinho.add(Produto.map(produto));
      }
      print("Produtos encontrados.");
      return itensCarrinho;
    } else {
      print("Nenhum produto foi encontrado no sistema.");
      return null;
    }
  }

  Future<List<Produto>> pegarProdutosComecandoCom(String inicio) async {
    QuerySnapshot bd =
        await Firestore.instance.collection("produtos").getDocuments();
    if (bd.documents.isNotEmpty) {
      List<Produto> produtos = new List<Produto>();
      var produto;
      for (dynamic i in bd.documents) {
        print(i.data['nome'].toString());
        if (i.data['nome']
            .toString()
            .toLowerCase()
            .startsWith(inicio.toLowerCase())) {
          produto = i.data;
          produto.addAll({'idProduto': i.documentID});
          produtos.add(Produto.map(produto));
        }
      }
      print("Produtos encontrados.");
      return produtos;
    } else {
      print("Nenhum produto foi encontrado no sistema.");
      return null;
    }
  }

  Future<List<Produto>> pegarProdutosPorCategoria(Categoria categoria) async {
    QuerySnapshot bd = await Firestore.instance
        .collection("produtos")
        .where('categoria', isEqualTo: categoria.nome)
        .getDocuments();
    if (bd.documents.isNotEmpty) {
      List<Produto> produtos = new List<Produto>();
      var produto;
      for (dynamic i in bd.documents) {
        produto = i.data;
        produto.addAll({'idProduto': i.documentID});
        produtos.add(Produto.map(produto));
      }
      print("Produtos encontrados.");
      return produtos;
    } else {
      print("Nenhum produto foi encontrado no sistema.");
      return null;
    }
  }

  Future<bool> removeItemCarrinho(Produto p, int quant) async {
    try {
      QuerySnapshot bd = await Firestore.instance
          .collection("carrinho")
          .where('nome', isEqualTo: p.nome)
          .where("quantidade", isEqualTo: quant)
          .getDocuments();
      if (bd.documents.isNotEmpty) {
        Firestore.instance
            .collection("carrinho")
            .document("${bd.documents[0].documentID}")
            .delete();
      }
      print("Item removido.");
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<int> limparCarrinho() async {
    try {
      QuerySnapshot bd =
          await Firestore.instance.collection("carrinho").getDocuments();
      if (bd.documents.isNotEmpty) {
        for (dynamic i in bd.documents) {
          Firestore.instance
              .collection("carrinho")
              .document("${i.documentID}")
              .delete();
        }
      }
      print("Item removido.");
      return 1;
    } catch (err) {
      print(err);
      return 0;
    }
  }
}
