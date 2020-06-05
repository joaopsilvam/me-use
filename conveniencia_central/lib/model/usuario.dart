class Usuario{

  int _id;
  String _nome;
  String _senha;
  String _email;
  String _endereco;
  String _telefone;
  
  int get id => _id;
  String get nome => _nome;
  String get senha => _senha;
  String get email => _email;
  String get endereco => _endereco;
  String get telefone => _telefone;

  Usuario(this._nome, this._senha, this._email, this._endereco, this._telefone);
  
  Usuario.map(dynamic obj) {
    this._id = obj['idUsuario'];
    this._nome = obj['nome'];
    this._senha = obj['senha'];
    this._email = obj['email'];
    this._endereco = obj['endereco'];
    this._telefone = obj['telefone'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['idUsuario'] = _id;
    map["nome"] = _nome;
    map["senha"] = _senha;
    map['email'] = _email;
    map['endereco'] = _endereco;
    map['telefone'] = _telefone;
    return map;
  }
}