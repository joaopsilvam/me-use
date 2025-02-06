class Produto {

  String _idProduto;
  String _nome;
  String _litragem;
  int _quantidade;
  double _preco;
  String _categoria;
  String _imagem;
  String _descricao;

  String get idProduto => _idProduto;
  String get nome => _nome;
  String get litragem => _litragem;
  int get quantidade => _quantidade;
  double get preco => _preco;
  String get categoria => this._categoria;
  String get imagem => _imagem;
  String get descricao => this._descricao;

  Produto(this._nome, this._litragem, this._quantidade, this._preco, this._categoria, this._imagem, this._descricao);

  Produto.map(dynamic obj) {
    this._idProduto = obj['idProduto'];
    this._nome = obj['nome'];
    this._litragem = obj['litragem'];
    this._quantidade = obj['quantidade'];
    this._preco = (obj['preco'] as num).toDouble();
    this._categoria = obj['categoria'];
    this._imagem = obj['imagem'];
    this._descricao = obj['descricao'];
  }

  Produto.mapPedido(dynamic obj) {
    this._idProduto = obj['idProduto'];
    this._nome = obj['nome'];
    this._quantidade = obj['quantidade'];
    this._preco = obj['preco'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['idProduto'] = _idProduto;
    map['nome'] = _nome;
    map['litragem'] = _litragem;
    map['quantidade'] = _quantidade;
    map['preco'] = _preco;
    map['categoria'] = _categoria;
    map['imagem'] = _imagem;
    map['descricao'] = _descricao;
    return map;
  }

  void setPreco(double preco) {
    this._preco = preco;
  }

  void setQuantidade(int quantidade) {
    this._quantidade = quantidade;
  }
}