import 'package:flutter/material.dart';


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
    var obj = ModalRoute.of(context)!.settings.arguments as String;
    // ignore: prefer_conditional_assignment, unnecessary_null_comparison
    if (obj == null) obj = "Visitante";

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade500,
        actions: [Text(obj)],
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