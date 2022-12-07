import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_final/api/acesso_api.dart';
import 'package:projeto_final/componentes/combo_cidade.dart';
import 'package:projeto_final/componentes/componentes.dart';
import 'package:projeto_final/componentes/radio_sexo.dart';
import 'package:projeto_final/entity/cidade.dart';
import 'package:projeto_final/entity/pessoa.dart';

class CadPessoa extends StatefulWidget {
  const CadPessoa({super.key});

  @override
  State<CadPessoa> createState() => _CadPessoaState();
}

class _CadPessoaState extends State<CadPessoa> {

  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtSexo = TextEditingController();
  TextEditingController txtIdade = TextEditingController();
  TextEditingController txtCidade = TextEditingController();

  @override
  Widget build(BuildContext context) {
   
    final args = ModalRoute.of(context)?.settings.arguments as Pessoa;
    txtNome.text = args.nome;
    txtSexo.text = args.sexo;
    txtIdade.text = args.idade == 0 ? '' : args.idade.toString();
    txtCidade.text = args.cidade.id.toString();
    



    cadastrar() async{
      Pessoa p = Pessoa(args.id, txtNome.text, txtSexo.text,
          int.parse(txtIdade.text), Cidade(int.parse(txtCidade.text), "", ""));
      if(p.id == 0) {
        await AcessoApi().inserirPessoa(p.toJson());
      } else {
        await AcessoApi().alterarPessoa(p.toJson());
      }
      Navigator.of(context).pushReplacementNamed('/listarPessoa');
    }
    return Scaffold(
      appBar: Componentes().criaAppBar('Cadastrar Pessoas', Colors.black, 16, null),
      body: Form(key: formController,
        child: Column(
          children: [
            Componentes().criaInputTexto(TextInputType.text, 'Nome', txtNome, 'Informe o nome'),
            Componentes().criaInputTexto(TextInputType.number, 'Idade', txtIdade, 'Informe a idade'),
            Center(child: RadioSexo(controller: txtSexo,)),
            Center(child: ComboCidade(controller: txtCidade,)),
            Componentes().criaBotao(formController, cadastrar, 'Salvar')
          ],
        )),
    );
  }
}