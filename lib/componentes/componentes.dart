import 'package:flutter/material.dart';

class Componentes {

  criaAppBar(texto, cor, tam, acao){
  return AppBar(
    title: criaTexto(texto, cor, tam),
    centerTitle: true,
    actions: <Widget>[
      IconButton(
        onPressed: acao, 
        icon: const Icon(Icons.home, color: Colors.white,))
    ],
  );
}

criaTexto(texto, cor, tam){
    return Text(
      texto, style: TextStyle(color: cor, fontSize: tam),
    );
  }
    

criaBotao(controladorFormulario, funcao, titulo){
  return Row(
    children: [
      Expanded(
        flex: 1, 
        child: Container(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
          height: 72,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
            ),
            onPressed: () {
              if (controladorFormulario.currentState!.validate()){
                funcao();
              }
            },
            child: Text(
              titulo,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        )
        ),
    ],
  );
}

criaBotaoNav(funcao, titulo){
  return Row(
    children: [
      Expanded(
        flex: 1, 
        child: Container(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
          height: 72,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
            ),
            onPressed: () {
                funcao();
            },
            child: Text(
              titulo,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        )
        ),
    ],
  );
}

criaInputTexto(tipoTeclado, textoEtiqueta, controlador, msgValidacao){
  return Padding(padding: const EdgeInsets.all(16.0), 
  child: TextFormField(
    keyboardType: tipoTeclado,
    decoration: InputDecoration(
      labelText: textoEtiqueta,
      labelStyle: const TextStyle(
        fontSize: 20,
      )
    ),
    textAlign: TextAlign.left,
    style: const TextStyle(fontSize: 30),
    controller: controlador,
    validator: (value) {
      if (value!.isEmpty){
        return msgValidacao;
      }
    },
  ) ,
  );
}

}
