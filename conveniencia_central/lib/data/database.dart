import 'dart:io';
import 'package:conveniencia_central/model/item_carrinho.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:conveniencia_central/model/usuario.dart';
import 'package:conveniencia_central/model/produto.dart';
import 'package:conveniencia_central/model/pedido.dart';
import 'package:conveniencia_central/model/categoria.dart';

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
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate,  onConfigure: _onConfigure);
    return ourDb;
  }

  void _onConfigure(Database db)async {
      await db.execute("PRAGMA foreign_keys = ON");
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Usuario(idUsuario INTEGER PRIMARY KEY, nome TEXT, senha TEXT, email TEXT UNIQUE, endereco TEXT, telefone TEXT)");
    await db.execute(
        "CREATE TABLE Produto(idProduto INTEGER PRIMARY KEY, nome TEXT UNIQUE, litragem REAL, quantidade INTEGER, preco REAL, categoria TEXT, imagem VARCHAR, descricao VARCHAR)");
    await db.execute(
        'CREATE TABLE Pedido(idPedido INTEGER PRIMARY KEY, idUsuario INTEGER, data DATATIME, precoTotal REAL, endereco TEXT)');
    await db.execute(
        'CREATE TABLE ItemPedido(idPedido INTEGER, idUsuario INTEGER, idProduto INTEGER, nome TEXT, quantidade INTEGER, preco REAL, FOREIGN KEY(idPedido) REFERENCES Pedido(idPedido), FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario), FOREIGN KEY (idProduto) REFERENCES Produto(idProduto))');
    await db.execute(
        'CREATE TABLE Categoria(idCategoria INTEGER PRIMARY KEY, nome VARCHAR UNIQUE, subtitulo VARCHAR, imagem VARCHAR)');
    await db.execute(
        'CREATE TABLE Carrinho(idProduto INTEGER, nome VARCHAR, quantidade INTEGER, preco REAL, imagem VARCHAR)');
    await db.execute('''
          INSERT INTO Categoria(nome, subtitulo, imagem) VALUES("Mercearia", "Cereais, grãos, massas e enlatados", "https://image.freepik.com/fotos-gratis/doacoes-de-alimentos-com-conservas-em-cima-da-mesa_93675-79890.jpg"),
          ("Padaria", "Pães e doces", "https://blog.souevolus.com.br/wp-content/uploads/2018/06/paes-730x487.jpg"),          
          ("Verduras e legumes", "Raízes, tubérculos e folhas", "https://3eaf214443cb92a1.cdn.gocache.net/wp-content/uploads/2019/11/shopping-bag-full-of-fresh-vegetables-and-fruits-picture-id1128687123-760x450.jpg"),          
          ("Frutas", "Cítricas, exóticas e secas", "https://avozdaserra.com.br/sites/default/files/noticias/frutas_variadas_nao_engordam_0.jpg"),          
          ("Proteínas", "Carnes, ovos e frios", "https://blog.gsuplementos.com.br/wp-content/uploads/2017/02/iStock-505592886.jpg"),          
          ("Higiene pessoal", "Limpeza bucal, íntima e dérmica", "https://image.freepik.com/fotos-gratis/espaco-de-copia-de-produtos-de-limpeza-dentaria_23-2148439111.jpg"),          
          ("Limpeza", "Limpeza e conservação doméstica", "http://www.habitec.com.br/ckfinder/userfiles/images/3%20-%20Limpeza%20casa(1).jpg");          
          ''');
  }

  Future<bool> criarUsuario(Usuario usuario) async {
    var dbClient = await db;
    try {
      await dbClient.rawInsert(
          "INSERT INTO Usuario(nome, senha, email, endereco, telefone) VALUES(?,?,?,?,?)",
          [usuario.nome, usuario.senha, usuario.email, usuario.endereco, usuario.telefone]);
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> criarProduto(Produto produto) async {
    var dbClient = await db;
    try {
      await dbClient.rawInsert(
          "INSERT INTO Produto(nome, litragem, quantidade, preco, categoria, imagem, descricao) VALUES(?,?,?,?,?,?,?)",
          [produto.nome, produto.litragem, produto.quantidade, produto.preco, produto.categoria, produto.imagem, produto.descricao]);
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> criarPedido(Pedido pedido) async {
    var dbClient = await db;
    try {
      await dbClient.rawInsert(
          "INSERT INTO Pedido(data, precoTotal, endereco) VALUES(datetime('now','localtime'),?,?)",
          [pedido.precoTotal, pedido.endereco]);
      
      dynamic idPedido = await dbClient.rawQuery(
          'SELECT idPedido From Pedido ORDER BY idPedido DESC LIMIT 1');

      List<Produto> produtos = pedido.produtos;

      for (int i = 0; i < produtos.length; i++) {
        await dbClient.rawInsert(
            'INSERT INTO ItemPedido(idPedido, idUsuario, idProduto, quantidade, preco) VALUES(?,?,?,?,?)',
            [idPedido, pedido.usuario, produtos[i].idProduto, produtos[i].quantidade, produtos[i].preco]);
      }
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
    var dbClient = await db;
    try {
      await dbClient.rawInsert(
          "INSERT INTO Carrinho(idProduto, nome, quantidade, preco, imagem) VALUES(?,?,?,?,?)",
          [produto.idProduto, produto.nome, produto.quantidade, produto.preco, produto.imagem]);
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> cadastrarPedido(Pedido pedido) async{
    var dbClient = await db;
    try {
      await dbClient.rawInsert(
          "INSERT INTO Pedido(idUsuario, data, precoTotal, endereco) VALUES(?,datetime('now','localtime'),?,?)",
          [pedido.usuario.id, pedido.precoTotal, pedido.endereco]);
      dynamic temp = await dbClient.rawQuery(
        "SELECT idPedido FROM Pedido ORDER BY idPedido DESC LIMIT 1");
      int idPedido = temp[0]['idPedido'];
      List<Produto> itens = pedido.produtos;

      for(int i = 0; i < itens.length; i++){
        await dbClient.rawInsert(          
          "INSERT INTO ItemPedido(idPedido, idUsuario, idProduto, quantidade, preco) VALUES(?,?,?,?,?)",
          [idPedido, pedido.usuario.id, itens[i].idProduto, itens[i].quantidade, itens[i].preco]);
      }
      return true;
    } catch (err) {
      print(err);
      return false;
    }  }

  Future<Usuario> pegarUsuarioPorCredenciais(String email, String senha) async {
    var dbClient = await db;
    dynamic test = await dbClient.rawQuery(
        'SELECT * FROM Usuario WHERE email=? and senha=?', [email, senha]);
    try {
      return Usuario.map(test[0]);
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<List<Usuario>> pegarUsuarios() async {
    var dbClient = await db;
    List<Map> test = await dbClient.rawQuery("SELECT * FROM Usuario");

    try {
      List<Usuario> usuarios = new List<Usuario>();
      for (dynamic i in test) {
        usuarios.add(Usuario.map(i));
      }
      return usuarios;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<List<Produto>> pegarProdutos() async {
    var dbClient = await db;
    List<Map> test = await dbClient.rawQuery("SELECT * FROM Produto");

    try {
      List<Produto> produtos = new List<Produto>();
      for (dynamic i in test) {
        produtos.add(Produto.map(i));
      }
      return produtos;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<List<Categoria>> pegarCategorias() async {
    var dbClient = await db;
    List<Map> test = await dbClient.rawQuery("SELECT * FROM Categoria");

    try {
      List<Categoria> categoria = new List<Categoria>();
      for (dynamic i in test) {
        categoria.add(Categoria.map(i));
      }
      return categoria;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<List<Pedido>> pegarPedidosDoUsuario(Usuario usuario) async {
    var dbClient = await db;
    dynamic test = await dbClient.rawQuery("SELECT * FROM Pedido WHERE idUsuario = ${usuario.id}");
    try {
      List<Pedido> pedidos = List<Pedido>();
      for (dynamic i in test) {
        dynamic itemPedido = await dbClient.rawQuery("SELECT * FROM ItemPedido WHERE idPedido = ${i['idPedido']}");
        List<Produto> produtos = List<Produto>();
        for(dynamic j in itemPedido){
          print(j);
          produtos.add(Produto.map(j));
        }
        Pedido p = Pedido.maps(i);
        p.setProdutos(produtos);
        pedidos.add(p);
      }
      return pedidos;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<List<Produto>> pegarItensDoCarrinho() async {
    var dbClient = await db;
    List<Map> test = await dbClient.rawQuery("SELECT * FROM Carrinho");

    try {
      List<Produto> itensCarrinho = new List<Produto>();
      for (dynamic i in test) {
        itensCarrinho.add(Produto.map(i));
      }
      return itensCarrinho;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<List<Produto>> pegarProdutosComecandoCom(String inicio) async {
    var dbClient = await db;
    List<Map> test = await dbClient.rawQuery("SELECT * FROM Produto WHERE nome LIKE '$inicio\%'");

    try {
      List<Produto> produtos = new List<Produto>();
      for (dynamic i in test) {
        produtos.add(Produto.map(i));
      }
      return produtos;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<List<Produto>> pegarProdutosPorCategoria(Categoria categoria) async {
    var dbClient = await db;
    List<Map> test = await dbClient.rawQuery("SELECT * FROM Produto WHERE categoria = '${categoria.nome}'");

    try {
      List<Produto> produtos = new List<Produto>();
      for (dynamic i in test) {
        produtos.add(Produto.map(i));
      }
      return produtos;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<bool> removeItemCarrinho(Produto p, int quant) async {
    var dbClient = await db;
    try {
      await dbClient.rawDelete(
          "DELETE From Carrinho WHERE idProduto=${p.idProduto} AND quant=$quant;");
      print(true);
      return true;
    } catch (err) {
      print(false);
      return false;
    }
  }

  Future<int> limparCarrinho() async {
    var dbClient = await db;
    int res = await dbClient.rawDelete("DELETE From Carrinho");
    return res;
  }
}