import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_final/api/acesso_api.dart';
import 'package:projeto_final/componentes/componentes.dart';
import 'package:projeto_final/entity/cidade.dart';

class CadCidade extends StatefulWidget {
  const CadCidade({super.key});

  @override
  State<CadCidade> createState() => _CadCidadeState();
}

class _CadCidadeState extends State<CadCidade> {

  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtUf = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments as Cidade;
    txtNome.text = args.nome;
    txtUf.text = args.uf;

    salvar() async {
      Cidade c = Cidade(args.id, txtNome.text, txtUf.text);
      if(c.id ==0) {
        await AcessoApi().inserirCidade(c.toJson());
      } else {
        await AcessoApi().alterarCidade(c.toJson());
      }
      Navigator.of(context).pushNamed("/listarCidade");
    }


    return Scaffold(
      appBar: Componentes().criaAppBar('Cidades', Colors.white, 16, null),
      body: Form(
        key: formController,
        child: Column(
          children: [
            Componentes().criaInputTexto(TextInputType.text, "Nome da Cidade", txtNome, "INforme o nome da cidade"),
            Componentes().criaInputTexto(TextInputType.text, "UF", txtUf, "INforme o UF da cidade"),
            Componentes().criaBotao(formController, salvar, "Salvar"),
          ],
        ),
      ),
    );
  }
}