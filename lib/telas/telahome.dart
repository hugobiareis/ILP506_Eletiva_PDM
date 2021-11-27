import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  late CollectionReference products;

  @override
  void initState() {
    super.initState();
    products = FirebaseFirestore.instance.collection('products');
  }

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image image = Image.asset('imagens/icon.png');
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(value.toString(), fit: BoxFit.scaleDown);
    });
    return image;
  }

  Widget itemLista(item) {
    String cod = item.data()['cod'];
    String descr = item.data()['descr'];
    String det = item.data()['det'];
    String img = item.data()['img'];
    return GestureDetector(
      child: Card(
        elevation: 30,
        shadowColor: Colors.grey.shade500,
        child: GridTile(
          header: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height / 100),
            child: Text(
              cod,
              textAlign: TextAlign.center,
            ),
          ),
          child: SizedBox(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 20),
              child: FutureBuilder<Widget>(
                future: _getImage(context, img),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return SizedBox(
                      child: snapshot.data,
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return Center(
                    child: Text("Erro"),
                  );
                },
              ),
            ),
          ),
          footer: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height / 100),
            child: Text(
              descr,
              textAlign: TextAlign.center,
            ),
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
                  width: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    children: [
                      Expanded(
                        child: FutureBuilder<Widget>(
                          future: _getImage(context, img),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return SizedBox(
                                //width: MediaQuery.of(context).size.width / 4,
                                //height: MediaQuery.of(context).size.width / 4,
                                child: snapshot.data,
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            return Center(
                              child: Text("Erro"),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 50),
                      Text(
                        det,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 50),
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
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'ADICIONADO AO ORÇAMENTO',
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                              duration: Duration(seconds: 4),
                            ));
                          });
                        },
                        child: Text('ADICIONAR AO ORÇAMENTO',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 50),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade500),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        },
                        child: Text('FECHAR',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
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
      body: StreamBuilder<QuerySnapshot>(
        stream: products.snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text('Sem Conexão'),
              );
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              final dados = snapshot.requireData;
              return GridView.builder(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height / 50),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (MediaQuery.of(context).size.width ~/ 180)),
                scrollDirection: Axis.vertical,
                itemCount: dados.size,
                itemBuilder: (context, index) {
                  return itemLista(dados.docs[index]);
                },
              );
          }
        },
      ),
    );
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}