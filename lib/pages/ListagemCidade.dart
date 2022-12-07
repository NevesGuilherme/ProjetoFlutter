import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_final/api/acesso_api.dart';
import 'package:projeto_final/componentes/combo_uf.dart';
import 'package:projeto_final/componentes/componentes.dart';
import 'package:projeto_final/entity/cidade.dart';

class ListagemCidade extends StatefulWidget {
  const ListagemCidade({super.key});

  @override
  State<ListagemCidade> createState() => _ListagemCidadeState();
}

class _ListagemCidadeState extends State<ListagemCidade> {

  List<Cidade> lista = [];
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtUf = TextEditingController();

  listarCidade() async {
    List<Cidade> cidades = await AcessoApi().listarcidade();
    setState(() {
      lista = cidades;
      txtUf.text = "";
    });
  }

  buscarPorUf() async {
    List<Cidade> buscar = await AcessoApi().buscarCidadePorUf(txtUf.text);
    setState(() {
      lista = buscar;
    });
  }

   inicio(){
    Navigator.of(context).pushNamed('/inicio');
  }

  cadCidade(){
    Navigator.of(context).pushNamed("/cadastrarCidade", arguments: Cidade(0, "", ""));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listarCidade();
  }

  @override
  Widget build(BuildContext context) {

    criaItemCidade(Cidade c, context){
      return ListTile(
        title: Text('${c.nome} - ${c.uf}'),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () { 
                  Navigator.pushNamed(context, "/cadastrarCidade", arguments: c);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await AcessoApi().excluirCidade(c.id);
                  setState(() {
                    listarCidade();
                  });
                },
              ),
            ],
          ),
        ),
      );
    }//FIM CRIA ITEM CIDADE

    return Scaffold(
      appBar: Componentes().criaAppBar('Cidades', Colors.white, 16, inicio),
      body: Column(
        children: [
          //Center( child: ComboUf(controller: txtUf,),),
          Center(child: Componentes().criaInputTexto(TextInputType.text, 'Informe uma UF', txtUf, 'Informe uma UF'),),
          Form(
            key: formController,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                 ElevatedButton(onPressed: buscarPorUf, child: Text('Buscar por UF')),
                ElevatedButton(onPressed: listarCidade, child: Text('Limpar Busca')),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, indice) {
                return Card(
                  elevation: 6,
                  margin: const EdgeInsets.all(8),
                  child: criaItemCidade(lista[indice], context),
                );
              },
            ),
          ),
        ],
      ),
       floatingActionButton: FloatingActionButton(
          onPressed: cadCidade,
          child: const Icon(Icons.add),
      ),
    );
  }
}