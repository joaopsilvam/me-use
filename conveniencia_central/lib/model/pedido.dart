import 'produto.dart';
import 'usuario.dart';

class Pedido{

  String _idPedido;
  Usuario _usuario;
  String _data;
  double _precoTotal;
  String _endereco;
  String _cpf;
  String _numeroCartao;
  List<Produto> _produtos = new List<Produto>();

  String get idPedido => this._idPedido;
  Usuario get usuario => this._usuario;
  String get data => this._data;
  double get precoTotal => this._precoTotal;
  String get endereco => this._endereco;
  String get cpf => this._cpf;
  String get numeroCartao => this._numeroCartao;
  List<Produto> get produtos => this._produtos;

  Pedido(this._usuario, this._data, this._precoTotal, this._endereco, this._cpf, this._numeroCartao, this._produtos);

  void adicionarProduto(Produto produto) => this._produtos.add(produto);

  Pedido.map(dynamic obj){
    _idPedido = obj['idPedido'];
    _usuario = Usuario.map(obj);
    _data = obj['data'];
    _precoTotal = obj['precoTotal'];
    _endereco = obj['endereco'];
    _cpf = obj['cpf'];
    _numeroCartao = obj['numeroCartao'];
  }

  Pedido.maps(dynamic obj){
    _idPedido = obj['idPedido'];
    _data = obj['data'];
    _precoTotal = obj['precoTotal'];
    _endereco = obj['endereco'];
    _cpf = obj['cpf'];
    _numeroCartao = obj['numeroCartao'];
  }

  Map<String, dynamic> getMap(){
    var map = new Map<String, dynamic>();
    map['idPedido'] = this._idPedido;
    map['usuario'] = this._usuario;
    map['data'] = this._data.toString();
    map['precoTotal'] = this._precoTotal;
    map['endereco'] = this._endereco;
    map['cpf'] = this._cpf;
    map['numeroCartao'] = this._numeroCartao;
    return map;
  }

  void setProdutos(List<Produto> produtos){
    this._produtos = produtos;
  }
}