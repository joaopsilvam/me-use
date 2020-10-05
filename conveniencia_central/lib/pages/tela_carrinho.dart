import 'package:conveniencia_central/components/email.dart';
import 'package:conveniencia_central/components/gerenciar_telas_usuario.dart';
import 'package:conveniencia_central/model/pedido.dart';
import 'package:conveniencia_central/model/produto.dart';
import 'package:flutter/material.dart';
import 'package:conveniencia_central/control/control.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

class TelaCarrinho extends StatefulWidget {
  @override
  TelaCarrinhoState createState() => TelaCarrinhoState();
}

class TelaCarrinhoState extends State<TelaCarrinho> {
  static Control control = Control();
  List<Produto> _itens = List<Produto>();
  double precoTotal = 0;
  int quant = 0;
  double taxaEntrega = 3;
  String numeroCartao = "Escolha um cartão";
  String cpf = "Informe seu CPF";
  String endereco = control.usuario.endereco;
  String bai = control.usuario.endereco;
  String ru = control.usuario.endereco;
  String nume = control.usuario.endereco;
  final scafolldKey = GlobalKey<ScaffoldState>();
  final controller = TextEditingController();
  final rua = TextEditingController();
  final bairro = TextEditingController();
  final numero = TextEditingController();
  NumberFormat formatador = NumberFormat("0.00");
  var maskFormatter = new MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  String _text = '';
  var email = Email('meuseempresa@gmail.com', 'MeUse@2246');

  void initState() {
    super.initState();
    _ayncInitMethod();
  }

  _ayncInitMethod() async {
    await control.pegarItensDoCarrinho().then((onValue) {
      setState(() {
        this._itens = onValue;
        //print(onValue[0].imagem);
      });
    });
  }

  void calcularPreco() {
    double temp = 0;
    for (Produto i in _itens) {
      temp += i.preco * i.quantidade;
    }
    this.precoTotal = temp;
  }

  String enviarProdutos() {
    String texto = "";
    for (Produto p in _itens) {
      texto += "${p.quantidade}x ${p.nome}\n";
    }
    return texto;
  }

  void _sendEmail() async {
    bool result = await email.sendMessage('''
Novo pedido efetuado\n
Preço total: ${this.precoTotal}
Usuário: ${control.usuario.nome}
E-mail: ${control.usuario.email}
Endereço: ${control.usuario.endereco}
Telefone: ${control.usuario.telefone}\n\n
${enviarProdutos()}
        ''', 'meuseempresa@gmail.com', 'Novo Pedido');

    setState(() {
      _text = result ? 'Enviado.' : 'Não enviado.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => GerenciarTelas())),
        child: Material(
          key: scafolldKey,
          child: SingleChildScrollView(child: page()),
        ));
  }

  double calculatePreco() {
    double value = 0;
    if (this._itens != null) {
      for (int i = 0; i < this._itens.length; i++) {
        value += this._itens[i].preco * this._itens[i].quantidade;
      }
    }
    return value;
  }

  Widget page() {
    rua.text = this.endereco.split(", ")[1];
    bairro.text = this.endereco.split(", ")[0];
    numero.text = this.endereco.split(", ")[2];
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                //width: MediaQuery.of(context).size.width,
                child: Container(
                  width: 60,
                  height: 25,
                  child: FlatButton(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.yellow[800],
                      size: 15,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GerenciarTelas()));
                    },
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(right: 20),
                  width: MediaQuery.of(context).size.width * 0.23,
                  child: FittedBox(
                    child: Text(
                      "Carrinho",
                      style: TextStyle(
                        color: Colors.yellow[800],
                        fontFamily: "Arial",
                      ),
                    ),
                  )),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Divider(
              color: Colors.grey,
              height: 1,
            ),
          ),
          getListViewItens(),
          rodape(),
        ],
      ),
    );
  }

  Widget getListViewItens() {
    if (this._itens == null || this._itens.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.4,
        padding: EdgeInsets.only(top: 30),
        child: Center(
            child: FittedBox(
          child: Text(
            'Sem itens no carrinho.',
            style: TextStyle(
                color: Colors.grey[800],
                fontFamily: "WorkSansLight",
                fontSize: MediaQuery.of(context).size.width * 0.035),
          ),
        )),
      );
    } else {
      return Container(
          child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            child: SizedBox(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: this._itens.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(children: <Widget>[
                    Container(
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text("${this._itens[index].quantidade}x"),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text('${this._itens[index].nome}',
                                    style: TextStyle(fontSize: 15)),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  'Preço por un. R\$ ${formatador.format(num.parse(this._itens[index].preco.toStringAsPrecision(10)))}',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                                'R\$ ${formatador.format(num.parse((this._itens[index].preco * this._itens[index].quantidade).toStringAsPrecision(10)))}',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.yellow[800])),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              alignment: Alignment.center,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      control.removeItemCarrinho(
                                          this._itens[index],
                                          this._itens[index].quantidade);
                                      this._itens.remove(this._itens[index]);
                                    });
                                  }))
                        ],
                      ),
                    ),
                    Container(
                      child: Divider(
                        color: Colors.grey,
                        height: 1,
                      ),
                    ),
                  ]);
                },
              ),
            ),
          ),
        ],
      ));
    }
  }

  Widget rodape() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: FittedBox(
                      child: FlatButton(
                        child: Text("Adicionar itens",
                            style: TextStyle(color: Colors.yellow[800])),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GerenciarTelas()));
                        },
                      ),
                    )),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.only(bottom: 15),
                  child: Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                        height: MediaQuery.of(context).size.height * 0.02,
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1),
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width / 2,
                        child: FittedBox(
                          child: Text(
                            "Subtotal",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.02,
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.1),
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width / 2,
                        child: FittedBox(
                          child: Text(
                            "R\$ ${formatador.format(num.parse(calculatePreco().toStringAsPrecision(10)))}",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 5)),
                Row(
                  children: <Widget>[
                    Container(
                        height: MediaQuery.of(context).size.height * 0.02,
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1),
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width / 2,
                        child: FittedBox(
                          child: Text(
                            "Taxa de entrega",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.02,
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.1),
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width / 2,
                        child: FittedBox(
                          child: Text(
                            "R\$ ${formatador.format(num.parse(taxaEntrega.toStringAsPrecision(10)))}",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 7)),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1),
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        "Total",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: MediaQuery.of(context).size.height * 0.03,
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.1),
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        "R\$ ${formatador.format(num.parse((taxaEntrega + calculatePreco()).toStringAsPrecision(10)))}",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.only(top: 15),
            child: Divider(
              color: Colors.grey,
              height: 1,
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(children: <Widget>[
                          Icon(Icons.folder_shared),
                          Padding(padding: EdgeInsets.only(right: 10)),
                          Text(
                            this.cpf,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                            ),
                          ),
                        ]),
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: FlatButton(
                            child: Text(
                              "Adicionar",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.yellow[800]),
                            ),
                            onPressed: () => setCPF(),
                          ))
                    ],
                  )
                ],
              )),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Divider(
              color: Colors.grey,
              height: 1,
            ),
          ),
          MaterialButton(
            onPressed: () => setAdress(),
            child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(children: <Widget>[
                Container(child: Icon(Icons.location_on)),
                Padding(padding: EdgeInsets.only(right: 10)),
                Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Entregar em",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.032,
                                  color: Colors.grey)),
                          Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text("${this.endereco}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.041,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )
                        ])),
                Container(
                  child: Icon(Icons.arrow_forward_ios,
                      size: 15, color: Colors.yellow[800]),
                ),
              ]),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Divider(
              color: Colors.grey,
              height: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            child: RaisedButton(
              onPressed: () => comprar(),
              color: Colors.yellow[800],
              child: Text("Comprar",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontFamily: "Century Gothic",
                      color: Colors.white)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 7)),
          Container(
              height: MediaQuery.of(context).size.width * 0.09,
              width: MediaQuery.of(context).size.width * 0.38,
              alignment: Alignment.center,
              child: FlatButton(
                child: FittedBox(
                  child: Text("Limpar Carrinho",
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ),
                onPressed: () {
                  control.limparCarrinho();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GerenciarTelas()));
                },
              )),
          Padding(padding: EdgeInsets.only(top: 25))
        ],
      ),
    );
  }

  void comprar() async {
    calcularPreco();
    if (this.cpf == "Informe seu CPF") {
      this.cpf = "Não definido";
    }
    if (this.numeroCartao == "Escolha um cartão") {
      this.numeroCartao = "Não definido";
    }
    this.precoTotal += 3;
    print(this.precoTotal);
    Pedido pedido = Pedido(
        control.usuario,
        DateTime.now().toString(),
        this.precoTotal,
        this.endereco,
        "***.***.**${this.cpf.substring(10)}",
        this.numeroCartao,
        this._itens);
    bool response = await control.cadastrarPedido(pedido);
    print(response);
    if (response) {
      control.limparCarrinho();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.info, color: Colors.green),
                  Padding(padding: EdgeInsets.only(right: 7)),
                  Text('Compra realizada com sucesso.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: "Century Gothic",
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ));
          });
      await Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GerenciarTelas()));
        });
      });

      _sendEmail();
    } else {
      //_showSnackBar('Houve algum erro durante o pedido.');
    }
  }

  void setAdress() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            title: null,
            content: escolherEndereco(),
          );
        });
  }

  void setCPF() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            title: null,
            content: escolherCPF(),
          );
        });
  }

  Widget escolherEndereco() {
    this.controller.clear();
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              "Rua",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Century Gothic",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Container(
            height: 40,
            child: TextFormField(
              onSaved: (val) => ru = val,
              controller: this.rua,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey),
                  hintText: "${control.usuario.endereco.split(", ")[1]}",
                  fillColor: Colors.white70),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 20)),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              "Bairro",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Century Gothic",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Container(
            height: 40,
            child: TextFormField(
              onSaved: (val) => bai = val,
              controller: this.bairro,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey),
                  hintText: "${control.usuario.endereco.split(", ")[0]}",
                  fillColor: Colors.white70),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 20)),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              "Número",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Century Gothic",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Container(
            height: 40,
            child: TextFormField(
              onSaved: (val) => nume = val,
              controller: this.numero,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey),
                  hintText: "${control.usuario.endereco.split(", ")[2]}",
                  fillColor: Colors.white70),
            ),
          ),
          Container(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                height: 20,
                minWidth: 100,
                onPressed: () {
                  print(
                      "${this.bairro.text}, ${this.rua.text}, ${this.numero.text}");
                  this.endereco =
                      "${this.bairro.text}, ${this.rua.text}, ${this.numero.text}";
                  Navigator.pop(context);
                },
                child: Text(
                  'Confirmar',
                  style: TextStyle(fontSize: 14, color: Colors.yellow[800]),
                ),
              ))
        ],
      ),
    );
  }

  Widget escolherCPF() {
    this.controller.clear();
    this.cpf = "";
    return Container(
      height: 130.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              "Informe seu CPF",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Century Gothic",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 20)),
          Container(
            height: 40,
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [maskFormatter],
              controller: this.controller,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey),
                  hintText: "123.456.789-10",
                  fillColor: Colors.white70),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: MaterialButton(
              height: 20,
              minWidth: 100,
              onPressed: () {
                this.cpf = this.controller.text;
                print(this.cpf);
                Navigator.pop(context);
              },
              child: Text(
                'Confirmar',
                style: TextStyle(fontSize: 14, color: Colors.yellow[800]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showSnackBar(String text) {
    final keyState = scafolldKey.currentState;
    keyState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
