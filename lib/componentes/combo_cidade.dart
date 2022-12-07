
import 'package:flutter/material.dart';
import 'package:projeto_final/api/acesso_api.dart';
import 'package:projeto_final/entity/cidade.dart';

class ComboCidade extends StatefulWidget {

  TextEditingController? controller;
  ComboCidade({Key? key, this.controller}) : super(key: key);

  @override
  State<ComboCidade> createState() => _ComboCidadeState();
}

class _ComboCidadeState extends State<ComboCidade> {

  int? cidadesel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1)).then((value) => AcessoApi().listarcidade()),
      builder: (context, AsyncSnapshot snapshot) {
        if ( snapshot.hasData && snapshot.data !=null) {
          List<Cidade> cidades = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButton(
              isExpanded: true,
              value: cidadesel,
              icon: const Icon(Icons.arrow_drop_down_sharp),
              hint: const Text('Selecione uma cidade...'),
              elevation: 16,
              onChanged: (int? value) {
                setState(() {
                  cidadesel = value;
                  widget.controller?.text = "$value";
                });
              },
              items: cidades.map<DropdownMenuItem<int>>((Cidade cid){
                return DropdownMenuItem<int>(value: cid.id, child: Text(cid.nome));
              }).toList(),
            ),
            );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text('Carregando Cidades'),
            ],
          );
        }
      },
    );
  }
}