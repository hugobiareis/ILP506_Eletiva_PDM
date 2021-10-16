// ignore_for_file: prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe, prefer_conditional_assignment, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

//ROTINA PRINCIPAL
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Catálogo FARB",
    //ROTAS A SEREM UTILIZADAS PELO NAVIGATOR
    initialRoute: 't1',
    routes: {
      't1': (context) => TelaInicial(),
      't2': (context) => Lancamentos(),
      't3': (context) => TelaCadastro()
    },
  ));
}

//
//CLASSE PARA ENVIAR DADOS DE UMA TELA PARA OUTRA
//

class Login {
  String usuario;
  String senha;
  Login(this.usuario, this.senha);
}

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
//
//SPLASHSCREEN PARA SIMULAR UM LOADING INICIAL
//
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: Lancamentos(),
      title: Text('Seja Bem Vindo',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      image: Image.asset('imagens/logo_farb.png'),
      gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.grey.shade300, Colors.grey.shade700]),
      photoSize: 200,
      loaderColor: Colors.black,
    );
  }
}

class Lancamentos extends StatefulWidget {
  const Lancamentos({Key? key}) : super(key: key);

  @override
  _LancamentosState createState() => _LancamentosState();
}

class _LancamentosState extends State<Lancamentos> {
//
//CONFIGURAÇÕES DO BOTTOM NAVIGATOR BAR
//
  var telaAtual = 0;
  var pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          TelaHome(),
          TelaPesquisar(),
          TelaCarrinho(),
          TelaConfiguracoes()
        ],
        onPageChanged: (index) {
          setState(() {
            telaAtual = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey.shade700,
        iconSize: 40,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.4),
        selectedFontSize: 16,
        unselectedFontSize: 16,
        currentIndex: telaAtual,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined), label: 'Pesquisar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'Carrinho'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: 'Configurações'),
        ],
        onTap: (index) {
          setState(() {
            telaAtual = index;
          });
          pageController.animateToPage(index,
              duration: Duration(microseconds: 300), curve: Curves.easeIn);
        },
      ),
    );
  }
}

class TelaHome extends StatefulWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  var lista = [];
  var descr = [];

  @override
  void initState() {
    lista.add("Produto 1");
    lista.add("Produto 2");
    lista.add("Produto 3");
    lista.add("Produto 4");
    lista.add("Produto 5");
    lista.add("Produto 6");
    lista.add("Produto 7");
    descr.add("Detalhes do produto 1");
    descr.add("Detalhes do produto 2");
    descr.add("Detalhes do produto 3");
    descr.add("Detalhes do produto 4");
    descr.add("Detalhes do produto 5");
    descr.add("Detalhes do produto 6");
    descr.add("Detalhes do produto 7");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//
//RECEBER DADOS DE OUTRA TELA
//
    var obj = ModalRoute.of(context)!.settings.arguments as Login;
    if (obj == null) {
      obj = Login("Visitante", "senha");
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Destaques'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade500,
        actions: [Text(obj.usuario)],
      ),
//
//CRIAÇÃO DO GRIDVIEW
//
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        scrollDirection: Axis.vertical,
        itemCount: lista.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              child: Card(
                elevation: 30,
                shadowColor: Colors.grey.shade500,
                child: GridTile(
                  header: Text(
                    lista[index],
                    textAlign: TextAlign.center,
                  ),
                  child: Icon(Icons.card_giftcard_outlined, size: 100),
                  footer: Text(
                    descr[index],
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('DETALHES DO PRODUTO'),
                        content: SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Column(
                            children: [
                              //
                              //CAMPO DE TEXTO E BOTAO DE ESQUECI SENHA
                              //
                              Icon(Icons.card_giftcard_outlined, size: 150),
                              Text(
                                descr[index],
                                textAlign: TextAlign.center,
                              ),
                              //BOTÃO ADICIONAR AO CARRINHO
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey.shade500),
                                onPressed: () {
                                  setState(() {
                                    //
                                    //ENVIAR DADOS PARA CARRINHO E FECHAR
                                    //
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        'ADICIONADO AO CARRINHO',
                                        textAlign: TextAlign.center,
                                      ),
                                      duration: Duration(seconds: 4),
                                    ));
                                  });
                                },
                                child: Text('ADICIONAR AO CARRINHO',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'FECHAR',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      );
                    });
              });
        },
      ),
    );
  }
}

//
//TELA QUE PERMITIRÁ REALIZAR PESQUISAS
//

class TelaPesquisar extends StatefulWidget {
  const TelaPesquisar({Key? key}) : super(key: key);

  @override
  _TelaPesquisarState createState() => _TelaPesquisarState();
}

class _TelaPesquisarState extends State<TelaPesquisar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade500,
        actions: [
          Icon(
            Icons.search_outlined,
            size: 50,
          )
        ],
        title: TextField(
          decoration: InputDecoration(hintText: 'PESQUISAR'),
        ),
      ),
    );
  }
}

//
//TELA DO TIPO CARRINHO
//

class TelaCarrinho extends StatefulWidget {
  const TelaCarrinho({Key? key}) : super(key: key);

  @override
  _TelaCarrinhoState createState() => _TelaCarrinhoState();
}

class _TelaCarrinhoState extends State<TelaCarrinho> {
  var lista = [];
  var descr = [];
  int tamanho = 3;

  @override
  void initState() {
    lista.add("Produto 1");
    lista.add("Produto 2");
    lista.add("Produto 3");
    lista.add("Produto 4");
    lista.add("Produto 5");
    lista.add("Produto 6");
    lista.add("Produto 7");
    descr.add("Detalhes do produto 1");
    descr.add("Detalhes do produto 2");
    descr.add("Detalhes do produto 3");
    descr.add("Detalhes do produto 4");
    descr.add("Detalhes do produto 5");
    descr.add("Detalhes do produto 6");
    descr.add("Detalhes do produto 7");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//
//ROTINA PARA RECEBER DADOS DE OUTRA TELA
//
    var obj = ModalRoute.of(context)!.settings.arguments as Login;
    if (obj == null) {
      obj = Login("Visitante", "senha");
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade500,
        actions: [Text(obj.usuario)],
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        color: Colors.grey.shade200,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: tamanho,
          itemBuilder: (context, index) {
            return Card(
              elevation: 10,
              shadowColor: Colors.grey.shade200,
              child: ListTile(
                title: Text(lista[index]),
                subtitle: Text(descr[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () {
                    setState(() {
                      lista.removeAt(index);
                      tamanho--;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'REMOVIDO',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 4),
                      ));
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({Key? key}) : super(key: key);

  @override
  _TelaConfiguracoesState createState() => _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {
//
//VARIAVEIS PARA O TEXTBOX DE USUSARIO E SENHA E DOS SWITCHS
//
  var usuario = TextEditingController();
  var senha = TextEditingController();
  var email = TextEditingController();
  bool swnotif = false;
  bool swsound = false;

  @override
  Widget build(BuildContext context) {
    var obj = ModalRoute.of(context)!.settings.arguments as Login;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade500,
        centerTitle: true,
        title: Text(
          'Configurações',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            //
            //IMAGEM E TEXTBOX DE LOGIN
            //
            Image.asset('imagens/logo_farb.png'),
            //
            //CONDICIONAL PARA SABER SE ESTÁ LOGADO OU COMO VISITANTE
            //
            (obj == null)
                ? Expanded(
                    //
                    //SE SIM EXECUTA ESSE CONTAINER
                    //
                    child: Container(
                      padding: EdgeInsets.all(30),
                      //
                      //ORGANIZA OS ITEMS EMPILHADOS
                      //
                      child: Column(
                        children: [
                          //CAMPO USUARIO
                          TextField(
                            controller: usuario,
                            decoration: InputDecoration(
                              labelText: 'Usuário',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //CAMPO SENHA
                          TextField(
                            controller: senha,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //BOTÃO DE LOGIN
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey.shade500),
                            onPressed: () {
                              setState(() {
                                //
                                //ENVIAR DADOS PARA OUTRA TELA
                                //
                                obj = Login(usuario.text, senha.text);
                                Navigator.pushNamed(context, 't2',
                                    arguments: obj);
                              });
                            },
                            child: Text('LOGIN',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //BOTAO ESQUECI MINHA SENHA
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey.shade500),
                            onPressed: () {
                              setState(() {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('ESQUECI MINHA SENHA'),
                                        content: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          child: Column(
                                            children: [
                                              //
                                              //CAMPO DE TEXTO E BOTAO DE ESQUECI SENHA
                                              //
                                              TextField(
                                                controller: email,
                                                decoration: InputDecoration(
                                                  labelText: 'email',
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              //BOTÃO DE LOGIN
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        Colors.grey.shade500),
                                                onPressed: () {
                                                  setState(() {
                                                    //
                                                    //ENVIAR DADOS PARA RECUPERAR SENHA E FECHAR
                                                    //
                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                        'VERIFIQUE SUA CAIXA DE ENTRADA',
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      duration:
                                                          Duration(seconds: 4),
                                                    ));
                                                  });
                                                },
                                                child: Text('RECUPERAR SENHA',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'FECHAR',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              });
                            },
                            child: Text('ESQUECI MINHA SENHA',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //
                          //BOTÃO CADASTRAR
                          //
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey.shade500),
                            onPressed: () {
                              setState(() {
                                //
                                //CHAMAR OUTRA TELA
                                //
                                Navigator.pushNamed(context, 't3',
                                    arguments: null);
                              });
                            },
                            child: Text('CADASTRAR',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  )
                //
                //SE NAO EXECUTA ESSE EXPANDED
                //
                : Expanded(
                    child: Text(
                      "Você está logado como " + obj.usuario,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
            //
            //SWITCHS DE CONFIGURAÇAO
            //
            Row(
              children: [
                Switch(
                    value: swnotif,
                    onChanged: (value) {
                      setState(() {
                        swnotif = value;
                      });
                    }),
                Text('Notificações'),
              ],
            ),
            Row(
              children: [
                Switch(
                    value: swsound,
                    onChanged: (value) {
                      setState(() {
                        swsound = value;
                      });
                    }),
                Text('Sons')
              ],
            ),
            //
            //BOTAO DAS INFORMAÇOES SOBRE
            //
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.grey.shade500),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('SOBRE'),
                        content: SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Column(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset('imagens/hugo.png')),
                              Text(
                                  'O tema escolhido foi um catálogo virtual, podendo furamente se tornar uma loja virtual'),
                              Text(
                                  'O objetivo é fornecer para os clientes uma forma de localizar os itens vendidos pela empresa através de pesquisa'),
                              Text(
                                  'Aplicatico desenvolvido por Hugo Biazibetti Reis R.A. 2840482013050.'),
                              Text(
                                  'Trabalho avaliativo da matéria de Programação de Dispositivos Móveis professor Rodrigo Plotz.'),
                              Text('Contato hugo.reis3@fatec.sp.gov.br')
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'FECHAR',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      );
                    });
              },
              child: Text('SOBRE',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({Key? key}) : super(key: key);

  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  var nomecompleto = TextEditingController();
  var email = TextEditingController();
  var senha = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade500,
          title: Text('Cadastrar'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: nomecompleto,
                decoration: InputDecoration(
                    labelText: 'Nome Completo', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: email,
                decoration: InputDecoration(
                    labelText: 'E-mail', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: senha,
                decoration: InputDecoration(
                    labelText: 'Senha', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.grey.shade500),
                onPressed: () {
                  setState(() {
                    //
                    //CHAMAR OUTRA TELA
                    //
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'VERIFIQUE SUA CAIXA DE ENTRADA',
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(seconds: 4),
                    ));
                  });
                },
                child: Text('CADASTRAR',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ));
  }
}
