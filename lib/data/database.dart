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
        "CREATE TABLE Usuario(idUsuario INTEGER PRIMARY KEY, nome TEXT, senha TEXT, email TEXT UNIQUE, endereco TEXT, telefone TEXT)");
    await db.execute(
        "CREATE TABLE Produto(idProduto INTEGER PRIMARY KEY, nome TEXT UNIQUE, litragem VARCHAR, quantidade INTEGER, preco REAL, categoria TEXT, imagem VARCHAR, descricao VARCHAR)");
    await db.execute(
        'CREATE TABLE Pedido(idPedido INTEGER PRIMARY KEY, idUsuario INTEGER, data DATATIME, precoTotal REAL, endereco TEXT, cpf TEXT, numeroCartao TEXT)');
    await db.execute(
        'CREATE TABLE ItemPedido(idPedido INTEGER, idUsuario INTEGER, idProduto INTEGER, nome TEXT, quantidade INTEGER, preco REAL, FOREIGN KEY(idPedido) REFERENCES Pedido(idPedido), FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario), FOREIGN KEY (idProduto) REFERENCES Produto(idProduto))');
    await db.execute(
        'CREATE TABLE Categoria(idCategoria INTEGER PRIMARY KEY, nome VARCHAR UNIQUE, subtitulo VARCHAR, imagem VARCHAR)');
    await db.execute(
        'CREATE TABLE Carrinho(idProduto INTEGER, nome VARCHAR, quantidade INTEGER, preco REAL, imagem VARCHAR)');
    await db.execute('''
          INSERT INTO Categoria(nome, subtitulo, imagem) VALUES("Mercearia", "Cereais, grãos, massas e enlatados", "https://image.freepik.com/fotos-gratis/doacoes-de-alimentos-com-conservas-em-cima-da-mesa_93675-79890.jpg"),
          ("Padaria", "Pães e doces", "https://lh3.googleusercontent.com/proxy/czsdcbGVwnqeuFM9McI3g07yPxx5COEgFPyc7oB_FSLTE7Ph7VPB9Fzx3j8_HergFj0z9LP-B32WlTC8wr1j9py1g8yogL7XRdMtfpiPYgtpoYgwTyPeezMTdcsME6_vTeg"),          
          ("Verduras e legumes", "Raízes, tubérculos e folhas", "https://3eaf214443cb92a1.cdn.gocache.net/wp-content/uploads/2019/11/shopping-bag-full-of-fresh-vegetables-and-fruits-picture-id1128687123-760x450.jpg"),          
          ("Frutas", "Cítricas, exóticas e secas", "https://avozdaserra.com.br/sites/default/files/noticias/frutas_variadas_nao_engordam_0.jpg"),          
          ("Proteínas", "Carnes, ovos e frios", "https://blog.gsuplementos.com.br/wp-content/uploads/2017/02/iStock-505592886.jpg"),          
          ("Higiene pessoal", "Limpeza bucal, íntima e dérmica", "https://image.freepik.com/fotos-gratis/espaco-de-copia-de-produtos-de-limpeza-dentaria_23-2148439111.jpg"),          
          ("Limpeza", "Limpeza e conservação doméstica", "http://www.habitec.com.br/ckfinder/userfiles/images/3%20-%20Limpeza%20casa(1).jpg");          
          ''');
    await db
        .execute('''INSERT INTO Usuario(nome, senha, email, endereco, telefone) 
          VALUES ("João Lucas", "b", "b", "Rua dos Alfeneiros", "1")''');

    await db.execute('''
          INSERT INTO Produto(nome, litragem, quantidade, preco, categoria, imagem, descricao) VALUES
          ("Arroz Camil", "5 kg", 1, 15.50, "Mercearia", "https://static.carrefour.com.br/medias/sys_master/images/images/hfb/h28/h00/h00/9476860543006.jpg", "Arroz que teve a sua casca, farelo e germe removido. Isso altera o sabor, a textura e a aparência do arroz e ajuda a evitar a deterioração, além de prolongar sua vida útil. Após a moagem, o arroz é polido, resultando em uma semente com uma aparência brilhante e branca."),
          ("Feijoada Bordon", "430 g", 1, 8, "Mercearia", "https://static.carrefour.com.br/medias/sys_master/images/images/h2d/h6f/h00/h00/9462576578590.jpg", "A feijoada é um dos pratos típicos mais conhecidos e populares da culinária brasileira. Composta basicamente por feijão preto, diversas partes do porco, linguiça, farinha e o acompanhamento de verduras e legumes."),
          ("Brioche", "Unidade", 1, 2.70, "Padaria", "https://cozinhatecnica.com/wp-content/uploads/2019/11/brioche-photo-e1574428547579.jpg", "Pão de origem francesa, feito com alto teor de manteiga e ovo. É leve e ligeiramente inchado, mais ou menos bem, de acordo com a proporção de manteiga e de ovos. Ele tem uma crosta dourada escura, e escamosa, muitas vezes, acentuada por uma lavagem do ovo aplicado após a correção."),
          ("Bolo de Cenoura", "1 kg", 1, 6, "Padaria", "https://s2.glbimg.com/h8V9UciCVF3BWHpfCj4Fb15zDGA=/0x0:4810x3479/984x0/smart/filters:strip_icc()/s.glbimg.com/po/rc/media/2014/10/31/11_48_50_529_Bolo_de_Cenoura_alta.jpg", "Bolo doce de 1 kg com raspagem de cenoura misturada dentro da massa. A cenoura é amolecida no processo de cozimento, e o bolo, usualmente, tem um amolecimento e uma textura densa e suave."),
          ("Cebola", "1 kg", 1, 6.99, "Verduras e legumes", "https://hiperideal.vteximg.com.br/arquivos/ids/170995-1000-1000/51055.jpg?v=636616549635870000", "As variedades de cores branca e amarela  são ideais para cozinhar, pois se tornam suaves e doces com o cozimento e dão sabor aos outros alimentos. Além disso, elas fazem maravilhas pela nossa saúde."),
          ("Salsa", "Maço", 1, 2.50, "Verduras e legumes", "https://nagumonew.vteximg.com.br/arquivos/ids/195530-1000-1000/SALSA-MACO-508841_1.jpg?v=636896946916870000", "Além de funcionar como tempero, a salsinha é uma erva medicinal muito benéfica: é rica em vitaminas, antioxidantes e atua como diurético e anti-inflamatório."),
          ("Morango", "250 g", 1, 4, "Frutas", "https://polpaecongelados.com.br/wp-content/uploads/2017/06/morango-599x665.png", "Além de funcionar como tempero, a salsinha é uma erva medicinal muito benéfica: é rica em vitaminas, antioxidantes e atua como diurético e anti-inflamatório."),
          ("Banana", "1 kg", 1, 3, "Frutas", "https://static.carrefour.com.br/medias/sys_master/images/images/h3c/h4c/h00/h00/14506624385054.jpg", "Por ser rica em carboidratos, um dos principais benefícios dessa fruta é dar energia, mas ela também pode ser usada para aumentar a sensação de saciedade e de bem estar, pois é rica em triptofano, um composto importante para melhorar o humor."),
          ("Frango Seara", "1 kg", 1, 14.70, "Proteínas", "https://savegnago.vteximg.com.br/arquivos/ids/280339-1000-1000/FILE-FRANGO-SEARA-1K-BANDEJA.jpg?v=636345116252370000", "O filé de frango é uma carne muito presente na mesa do brasileiro. Ele pode ser preparado de muitas formas diferentes – grelhado, empanado e frito, por exemplo -, sempre contando com um sabor e textura inconfundíveis."),
          ("Ovos Qualitá", "20 ovos", 1, 9, "Proteínas", "https://ww2.clubeextra.com.br/img/uploads/1/952/475952.jpg?type=product", "O Ovo é um alimento de origem animal, podendo ser de diversas espécies animais, incluindo aves, répteis, anfíbios e peixes. São consumidos pelos humanos ao longo de milhares de anos."),
          ("Colgate PerioGard", "90 g", 1, 4.50, "Higiene pessoal", "https://araujo.vteximg.com.br/arquivos/ids/3896776-1000-1000/07793100130243.jpg?v=636794624172900000", "Creme dental da marca colgate criado especialmente com o objetivo de tornar os seus dentes mas brancos."),
          ("Papel Higiênico Personal Vip", "16 rolos", 1, 9.30, "Higiene pessoal", "https://static.carrefour.com.br/medias/sys_master/images/images/he6/h12/h00/h00/9454953005086.jpg", "Papel Higiênico da marca Personal Vip tripla face, à base de algoodão. Pague 15 e leve 16."),
          ("Desinfetante Kalipto", "2 L", 1, 4, "Limpeza", "https://static.carrefour.com.br/medias/sys_master/images/images/h35/h2c/h00/h00/13198832599070.jpg", "Desinfetantes são substâncias que são aplicadas em superfícies não vivas para destruir os microrganismos que vivem nesses objetos."),
          ("Sabão OMO", "1,6 kg", 1, 7, "Limpeza", "https://static.carrefour.com.br/medias/sys_master/images/images/hd5/ha8/h00/h00/13544263417886.jpg", "Sabão em pó de 1,6 kg da marca OMO multiuso. Pode ser utilizado para lavar roupas e superfícies de cozinha e banheiro.");
          ''');
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
        print("Produtos do pedido");
        print(produtos);
        for (dynamic j in produtos.documents) {
          itens.add(Produto.map(j));
        }
        var temp = i.data;

        temp.addAll({'idPedido': i.documentID});
        Pedido p = Pedido.maps(temp);
        p.setProdutos(itens);
        pedidos.add(p);
      }
      for (Produto p in pedidos[0].produtos) {
        print(p.nome);
      }
      return pedidos;
    } else {
      print("Nenhum pedido foi encontrado no sistema.");
      return null;
    }
    /*
    var dbClient = await db;
    dynamic test = await dbClient.rawQuery("SELECT * FROM Pedido WHERE idUsuario = ${usuario.id}");

    try {
      List<Pedido> pedidos = List<Pedido>();
      for (dynamic i in test) {
        dynamic itemPedido = await dbClient.rawQuery("SELECT * FROM ItemPedido WHERE idPedido = ${i['idPedido']}");
        List<Produto> produtos = List<Produto>();
        for(dynamic j in itemPedido){
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
    }*/
  }

  Future<List<Pedido>> pegarPedidos(Usuario usuario) async {
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
        produtos = await Firestore.instance
            .collection("usuarios")
            .document("${usuario.email}")
            .collection("pedidos")
            .document(i.documentID)
            .collection("produtos")
            .getDocuments();
        itens = List<Produto>();
        print("Produtos do pedido");
        print(produtos);
        for (dynamic j in produtos.documents) {
          itens.add(Produto.map(j));
        }
        var temp = i.data;

        temp.addAll({'idPedido': i.documentID});
        Pedido p = Pedido.maps(temp);
        p.setProdutos(itens);
        pedidos.add(p);
      }
      for (Produto p in pedidos[0].produtos) {
        print(p.nome);
      }
      pedidos = pedidos.reversed.toList();
      return pedidos;
    } else {
      print("Nenhum pedido foi encontrado no sistema.");
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
