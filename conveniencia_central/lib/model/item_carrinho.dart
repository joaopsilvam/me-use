class ItemCarrinhos {

  String _idProduto;
  String _nome;
  int _quantidade;
  double _preco;

  String get idProduto => _idProduto;
  String get nome => _nome;
  int get quantidade => _quantidade;
  double get preco => _preco;

  ItemCarrinhos(this._nome, this._quantidade, this._preco);

  ItemCarrinhos.map(dynamic obj) {
    this._idProduto = obj['idProduto'];
    this._nome = obj['nome'];
    this._quantidade = obj['quantidade'];
    this._preco = obj['preco'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['idProduto'] = _idProduto;
    map['nome'] = _nome;
    map['quantidade'] = _quantidade;
    map['preco'] = _preco;
    return map;
  }
}