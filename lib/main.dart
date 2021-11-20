// ignore_for_file: prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe, prefer_conditional_assignment, unnecessary_null_comparison
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'telas/lacamentos.dart';
import 'telas/telacadastro.dart';
import 'telas/telainicial.dart';

//ROTINA PRINCIPAL
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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











