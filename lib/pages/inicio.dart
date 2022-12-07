import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_final/componentes/componentes.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Inicio> {

  listaPessoa(){
    Navigator.of(context).pushNamed('/listarPessoa');
  }

  listarCidade(){
    Navigator.of(context).pushNamed('/listarCidade');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      appBar: Componentes().criaAppBar('Inicio', Colors.white, 16, null),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Componentes().criaBotaoNav(listaPessoa, 'Ver Pessoas'),
          Componentes().criaBotaoNav(listarCidade, 'Ver Cidades'),
        ],
      ),
      ),
    );
  }
}                           