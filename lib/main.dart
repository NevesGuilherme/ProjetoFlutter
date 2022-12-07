import 'package:flutter/material.dart';
import 'package:projeto_final/pages/ListagemCidade.dart';
import 'package:projeto_final/pages/cadCidade.dart';
import 'package:projeto_final/pages/cadPessoa.dart';
import 'package:projeto_final/pages/inicio.dart';
import 'package:projeto_final/pages/listagemPessoa.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/inicio",
      routes: {
        "/inicio" :(context) => Inicio(),
        "/cadastrarPessoa" :(context) => CadPessoa(),
        "/cadastrarCidade":(context) => CadCidade(),
        "/listarCidade":(context) => ListagemCidade(),
        "/listarPessoa":(context) => ListagemPessoa(),
      },
    );
  }
}