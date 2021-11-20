import 'package:flutter/material.dart';


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
    var obj = ModalRoute.of(context)!.settings.arguments as String;
    // ignore: prefer_conditional_assignment, unnecessary_null_comparison
    if (obj == null) obj = "Visitante";

    return Scaffold(
      appBar: AppBar(
        title: Text('Destaques'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade500,
        actions: [Text(obj)],
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
