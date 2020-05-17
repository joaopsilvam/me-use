class Categoria{

  int _idCategoria;
  String _nome;
  String _imagem;
  String _subtitulo;

  int get idCategoria => this._idCategoria;
  String get nome => this._nome;
  String get imagem => this._imagem;
  String get subtitulo => this._subtitulo;

  Categoria(this._nome, this._imagem, this._subtitulo);

  Categoria.map(dynamic obj){
    this._idCategoria = obj['idCategoria'];
    this._nome = obj['nome'];
    this._imagem = obj['imagem'];
    this._subtitulo = obj['subtitulo'];
  }
}