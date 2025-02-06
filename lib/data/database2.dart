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
    await db.execute('''INSERT INTO Usuario(nome, senha, email, endereco, telefone) 
          VALUES ("João Lucas", "b", "b", "Rua dos Alfeneiros", "1")''');
    await db.execute('''
          INSERT INTO Produto(nome, litragem, quantidade, preco, categoria, imagem, descricao)
          VALUES("Arroz Camil", "5 kg", 1, 15.50, "Mercearia", "https://static.carrefour.com.br/medias/sys_master/images/images/hfb/h28/h00/h00/9476860543006.jpg", "Arroz que teve a sua casca, farelo e germe removido. Isso altera o sabor, a textura e a aparência do arroz e ajuda a evitar a deterioração, além de prolongar sua vida útil. Após a moagem, o arroz é polido, resultando em uma semente com uma aparência brilhante e branca."),
          ("Feijoada Bordon", "430 g", 1, 8, "Mercearia", "https://static.carrefour.com.br/medias/sys_master/images/images/h2d/h6f/h00/h00/9462576578590.jpg", "A feijoada é um dos pratos típicos mais conhecidos e populares da culinária brasileira. Composta basicamente por feijão preto, diversas partes do porco, linguiça, farinha e o acompanhamento de verduras e legumes."),
          ("Brioche", "Unidade", 1, 2.70, "Padaria", "https://cozinhatecnica.com/wp-content/uploads/2019/11/brioche-photo-e1574428547579.jpg", "Pão de origem francesa, feito com alto teor de manteiga e ovo. É leve e ligeiramente inchado, mais ou menos bem, de acordo com a proporção de manteiga e de ovos. Ele tem uma crosta dourada escura, e escamosa, muitas vezes, acentuada por uma lavagem do ovo aplicado após a correção."),
          ("Bolo de Cenoura", "1 kg", 1, 6, "Padaria", "https://s2.glbimg.com/h8V9UciCVF3BWHpfCj4Fb15zDGA=/0x0:4810x3479/984x0/smart/filters:strip_icc()/s.glbimg.com/po/rc/media/2014/10/31/11_48_50_529_Bolo_de_Cenoura_alta.jpg", " Bolo doce de 1 kg com raspagem de cenoura misturada dentro da massa. A cenoura é amolecida no processo de cozimento, e o bolo, usualmente, tem um amolecimento e uma textura densa e suave."),
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
          "INSERT INTO Pedido(data, precoTotal, endereco, cpf, numeroCartao) VALUES(datetime('now','localtime'),?,?,?,?)",
          [pedido.precoTotal, pedido.endereco, pedido.cpf, pedido.numeroCartao]);
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
          "INSERT INTO Pedido(data, precoTotal, endereco, cpf, numeroCartao) VALUES(datetime('now','localtime'),?,?,?,?)",
          [pedido.precoTotal, pedido.endereco, pedido.cpf, pedido.numeroCartao]);
      dynamic temp = await dbClient.rawQuery(
        "SELECT idPedido FROM Pedido ORDER BY idPedido DESC LIMIT 1");
      int idPedido = temp[0]['idPedido'];
      List<Produto> itens = pedido.produtos;

      for(int i = 0; i < itens.length; i++){
        await dbClient.rawInsert(          
          "INSERT INTO ItemPedido(idPedido, idUsuario, idProduto, nome, quantidade, preco) VALUES(?,?,?,?,?,?)",
          [idPedido, pedido.usuario.id, itens[i].idProduto, itens[i].nome, itens[i].quantidade, itens[i].preco]);
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
          "DELETE From Carrinho WHERE idProduto=${p.idProduto} AND quantidade=$quant;");
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