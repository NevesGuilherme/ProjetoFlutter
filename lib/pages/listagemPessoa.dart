import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_final/api/acesso_api.dart';
import 'package:projeto_final/componentes/combo_cidade.dart';
import 'package:projeto_final/componentes/componentes.dart';
import 'package:projeto_final/entity/cidade.dart';
import 'package:projeto_final/entity/pessoa.dart';

class ListagemPessoa extends StatefulWidget {
  const ListagemPessoa({super.key});

  @override
  State<ListagemPessoa> createState() => _ListagemPessoaState();
}

class _ListagemPessoaState extends State<ListagemPessoa> {

  List<Pessoa> lista = [];
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtCidade = TextEditingController();

  listarPessoa() async {
    List<Pessoa> pessoas = await AcessoApi().listarPessoas();
    setState(() {
      lista = pessoas;
    });
  }

  buscarPorCidade() async {
    List<Pessoa> buscar = await  AcessoApi().buscarPorCidade(int.parse(txtCidade.text));
    setState(() {
      lista = buscar;
    });
  }

  inicio(){
    Navigator.of(context).pushNamed('/inicio');
  }

  cadPessoa(){
     Navigator.of(context).pushNamed("/cadastrarPessoa", arguments: Pessoa(0, "", "M", 0, Cidade(0, "","")));
  }


  @override
  void initState() {
    super.initState();
    listarPessoa();
  }

     criarItemPessoa(Pessoa p, context){
      return ListTile(
        title: Text('${p.nome} - ${p.idade} anos'),
        subtitle: Text('${p.sexo} - ${p.cidade.nome}/${p.cidade.uf}'),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                 Navigator.of(context).pushNamed("/cadastrarPessoa", arguments: p);

                }),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                 await AcessoApi().excluirPessoa(p.id);
                 setState(() {
                 listarPessoa();
                 });
                  
                },
              ),
            ],
          ),
        ),
      );
    }//FIM CRIA ITEM PESSOA

  @override
  Widget build(BuildContext context) {

 

    return Scaffold(
      appBar: Componentes().criaAppBar('Pessoas', Colors.white, 16, inicio),
      body: Column(
        children: [
          Center(child: ComboCidade(controller: txtCidade,),),
          Form(
            key: formController,
            child: Row( 
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              ElevatedButton(onPressed: buscarPorCidade, child: Text('Buscar Cidade')),
              ElevatedButton(onPressed: listarPessoa, child: Text('Limpar Busca')),
            ],),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, indice) {
                return Card(
                  elevation: 6,
                  margin: const EdgeInsets.all(8),
                  child: criarItemPessoa(lista[indice], context),
                );
              },
            ),
          ),
        ],
      ),
       floatingActionButton: FloatingActionButton(
          onPressed: cadPessoa,
          child: const Icon(Icons.add),
      ),
    );
  }
}