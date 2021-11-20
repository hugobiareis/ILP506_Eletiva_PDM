import 'package:flutter/material.dart';

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
        actions: const [
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