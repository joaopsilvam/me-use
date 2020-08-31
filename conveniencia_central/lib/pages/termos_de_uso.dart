import 'package:flutter/material.dart';

class TermosDeUso extends StatefulWidget {
  State<StatefulWidget> createState() => _TermosDeUsoState();
}

class _TermosDeUsoState extends State<TermosDeUso> {
  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
            child: Form(
                child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Container(
            alignment: Alignment.centerLeft,
            width: 60,
            height: 25,
            child: FlatButton(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 15,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 40),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 30,
          child: Text(
            'Termos de uso e ',
            style: TextStyle(
              fontSize: 25,
              fontFamily: "Century Gothic",
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 35,
          child: Text('Política de privacidade',
              style: TextStyle(
                fontSize: 25,
                fontFamily: "Aharoni",
              )),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
        Container(
          padding: EdgeInsets.only(right: 25, left: 25),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "Este documento foi elaborado com o intuito de estabelecer as regras de uso, armazenamento e proteção das informações obtidas dos usuários através do Aplicativo MeUse.com  “Institucional”.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "1. Para os fins deste documento, serão aplicadas as seguintes definições: Denomina-se  “MeUse.com” o Aplicativo desenvolvido para aparelhos iPhone ou Android, cuja finalidade é, a elaboração de listas de compras, a consulta de ofertas em destaques, relacionados aos produtos ofertados pelo aplicativo.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "Cookies:  Arquivos enviados pelo servidor do aplicativo para o iPhone ou Android do usuário, com a finalidade de identificar o aparelho e obter dados de acesso, permitindo, desta forma personalizar a utilização do Aplicativo de acordo com o perfil criado pelo Usuário;",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "Logs: Registros de atividades do Usuário efetuada no aplicativo;",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "Session ID: identificação da sessão do usuário no processo de inscrição ou quando utilizado de alguma forma o site.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "2. Obtenção dos dados e informações: Os dados e informações serão obtidos quando o Usuário passar a utilizar o Aplicativo; Interagir com as ferramentas existentes no aplicativo fornecendo as informações voluntariamente.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "3. Armazenamento dos Dados e informações:  Todos os dados e informações coletadas dos usuários serão incorporados ao banco de dados do Aplicativo, sendo seu responsável e proprietário a MeUse.com.  Os dados e informações coletadas estarão armazenados em ambiente seguro, e somente poderão ser acessadas por pessoas qualificadas e autorizadas pela MeUse.com. O usuário é o proprietário dos dados e está apto a adicionar, excluir ou modificar quaisquer informações que estiverem ligadas a seu perfil de usuário.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "4. Uso dos Dados e informações:  Os dados e informações coletadas dos usuários poderão ser utilizados para as seguintes finalidades: Efetuar qualquer comunicação resultante da atividade do próprio aplicativo ou a identificação do respectivo destinatário. Responder a eventuais dúvidas e solicitações do Usuário; Fornecer acesso a área restrita do aplicativo para cumprimento de ordem legal ou judicial; Constituir defender ou exercer regularmente direitos em âmbitos judicial ou administrativo; Garantir a segurança dos Usuários;  Manter atualizado os cadastros dos Usuários para fins de contato por telefone, SMS, E-MAIL ou por outro meio de comunicação. Informar a respeito de novidades, promoções e eventos da MeUse.com.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "5. Do Registro de atividades:  A MeUse.com poderá registrar as atividades efetuadas pelo Usuário no aplicativo, por meio de logs, incluindo: Endereço IP do usuário, ações efetuadas pelo usuário, data e horários de cada ação e de acesso a cada funcionalidade do aplicativo. Os registros mencionados poderão ser utilizados pela MeUse.com em casos de investigação de fraudes ou de alteração indevida em seus sistemas e cadastros.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "Cookies: O Aplicativo poderá fazer o uso de cookies, cabendo ao usuário configurar o seu navegador de internet, caso deseje bloqueá-lo. Nesta hipótese, algumas funcionalidade do aplicativo poderão ser limitadas.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "7. Exclusão de Garantias e Responsabilidade:  A MeUse.com não se responsabilizara em hipótese alguma por quaisquer danos decorrentes da interrupção dos serviços do aplicativo (Ex.: interrupção do serviço de internet e etc), quer ocorra por culpa de terceiros. A MeUse.com não se responsabiliza por qualquer dano e prejuízo que possam decorrer da presença de vírus ou de outros elementos nocivos no aplicativo salvo nos casos de dolo ou de culpa grave do mesmo, desde que devidamente comprovados.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "8. A MeUse.com não se responsabiliza por atos de terceiros que logrem êxito em coletar ou  utilizar, por quaisquer  meios, dados cadastrais e informações disponibilizadas no aplicativo pelo Usuário. ",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "9. Cadastro: Para participar e usufruir do aplicativo o usuário deverá fornecer na ocasião do cadastro as seguintes informações: Nome completo, CPF, endereço completo, celular, data de nascimento , sexo, e-mail sendo o usuário o único responsável pela veracidade das informações apresentadas.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "10. Cancelamento:  O Cancelamento do cadastro no aplicativo poderá ser feito a qualquer momento pelo usuário diretamente no aplicativo ou pelos canais de atendimento.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "11. Propriedade intelectual: O usuário declara se ciente de que o conteúdo a que terá acesso estará protegido por direitos de propriedade intelectual, que são de propriedade da MeUse.com ,  sem que o uso ou acesso ao aplicativo possam ser entendidos como atribuição de direitos ou autorização para que o usuário possa citar, ou usar o conteúdo para outro fim que não seja aquele expressamente indicado neste documento.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "12. Finalização: A MeUse.com se reserva o direito de recursar ou de retirar o acesso ao aplicativo, a qualquer momento, por iniciativa própria ou por exigência de um terceiro sem a necessidade de prévio aviso e sem direito a qualquer indenização",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "13. Disposições Gerais: As disposições constantes neste documento poderão ser atualizadas ou modificadas a qualquer momento, cabendo ao usuário verificá-la sempre que efetuar o acesso ao aplicativo. O Usuário deverá entrar em contato em caso de qualquer duvida em relação as disposições constantes neste documento, elegendo um dos e-mail de contato abaixo:",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "14. Aceitação: A utilização do aplicativo caracteriza, por si só a aceitação total e irrestrita dos termos de uso e da politica de privacidade, na versão publicada no momento da utilização do aplicativo. O usuário deve ler atentamente este documento em cada ocasião em que utilizar o aplicativo, pois ele pode sofrer modificações a qualquer tempo.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "15. Lei Aplicável e Jurisdição: O presente instrumento será interpretado segundo a legislação brasileira. Para drimir qualquer tipo de litigio, questão ou duvida superveniente, com expressa renúncia de qualquer outro por mais privilegiado que seja, sendo eleito o Foro da Comarca da Cidade de Guarabira-PB.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Century Gothic",
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
              ),
            ],
          ),
        ),
      ],
    ))));
  }
}
