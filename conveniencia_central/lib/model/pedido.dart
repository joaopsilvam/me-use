import 'produto.dart';
import 'usuario.dart';

class Pedido{

  int _idPedido;
  Usuario _usuario;
  DateTime _data;
  double _precoTotal;
  String _endereco;
  List<Produto> _produtos = new List<Produto>();

  int get idPedido => this._idPedido;
  Usuario get usuario => this._usuario;
  DateTime get data => this._data;
  double get precoTotal => this._precoTotal;
  String get endereco => this._endereco;
  List<Produto> get produtos => this._produtos;

  Pedido(this._usuario, this._data, this._precoTotal, this._endereco, this._produtos);

  void adicionarProduto(Produto produto) => this._produtos.add(produto);

  Pedido.map(dynamic obj){
    _idPedido = obj['idPedido'];
    _usuario = Usuario.map(obj);
    _data = DateTime.parse(obj['data']);
    _precoTotal = obj['precoTotal'];
    _endereco = obj['endereco'];
  }

  Pedido.maps(dynamic obj){
    _idPedido = obj['idPedido'];
    _data = DateTime.parse(obj['data']);
    _precoTotal = obj['precoTotal'];
    _endereco = obj['endereco'];
  }

  Map<String, dynamic> getMap(){
    var map = new Map<String, dynamic>();
    map['idPedido'] = this._idPedido;
    map['usuario'] = this._usuario;
    map['data'] = this._data.toString();
    map['precoTotal'] = this._precoTotal;
    map['endereco'] = this._endereco;
    return map;
  }

  void setProdutos(List<Produto> produtos){
    this._produtos = produtos;
  }
}