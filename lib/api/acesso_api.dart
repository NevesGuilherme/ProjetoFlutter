

import 'dart:convert';
import 'package:http/http.dart';
import 'package:projeto_final/entity/cidade.dart';
import 'package:projeto_final/entity/pessoa.dart';

class AcessoApi {

Future<List<Pessoa>> listarPessoas() async {
  String url = 'http://localhost:8080/cliente';
  Response resposta = await get(Uri.parse(url));
  String jsonFormatadoUft8 = (utf8.decode(resposta.bodyBytes));
  Iterable l = json.decode(jsonFormatadoUft8);
  List<Pessoa> pessoas = List<Pessoa>.from(l.map((p) => Pessoa.fromJson(p)));
  return pessoas;
}

Future<List<Pessoa>> buscarPorCidade(int id) async {
  String url = 'http://localhost:8080/cliente/buscarPorCidade/${id}';
  Response resposta = await get(Uri.parse(url));
  String jsonFormatadoUft8 = (utf8.decode(resposta.bodyBytes));
  Iterable l = json.decode(jsonFormatadoUft8);
  List<Pessoa> pessoas = List<Pessoa>.from(l.map((p) => Pessoa.fromJson(p)));
  return pessoas;
}

Future<List<Cidade>> buscarCidadePorUf(String uf) async {
  String url = 'http://localhost:8080/cidade/buscar/${uf}';
  Response resposta = await get(Uri.parse(url));
  String jsonFormatadoUft8 = (utf8.decode(resposta.bodyBytes));
  Iterable l = json.decode(jsonFormatadoUft8);
  List<Cidade> cidades = List<Cidade>.from(l.map((c) => Cidade.fromJson(c)));
  return cidades;
}

Future<List<Cidade>> listarcidade() async{
  String url = 'http://localhost:8080/cidade';
  Response resposta = await get(Uri.parse(url));
  String jsonFormatadoUft8 = (utf8.decode(resposta.bodyBytes));
  Iterable l = json.decode(jsonFormatadoUft8);
  List<Cidade> cidades = List<Cidade>.from(l.map((c) => Cidade.fromJson(c)));
  return cidades;
  }

  Future<void> inserirPessoa(Map<String, dynamic> pessoa) async{
    String url = 'http://localhost:8080/cliente';
    Map<String, String> headers = {'Content-Type': 'application/json; charset=UTF-8'};
    await post(Uri.parse(url), headers: headers, body: json.encode(pessoa));

  }

  Future<void> inserirCidade(Map<String, dynamic> cidade) async{
    String url = "http://localhost:8080/cidade";
    Map<String, String> headers = {'Content-Type':'application/json; charset=UTF-8'};
    await post(Uri.parse(url), headers: headers, body: json.encode(cidade));
  }

  Future<void> excluirPessoa(int id) async {
    String url = "http://localhost:8080/cliente/delete/$id";
    await delete(Uri.parse(url));
  }

  Future<void> excluirCidade(int id) async {
    String url = "http://localhost:8080/cidade/delete/$id";
    await delete(Uri.parse(url));
  }

  Future<void> alterarPessoa(Map<String, dynamic> pessoa) async {
    String url = "http://localhost:8080/cliente";
    Map<String, String> headers = {
      "Content-Type":"application/json; charsert=UTF-8"
    };
    await put(Uri.parse(url), headers: headers, body: jsonEncode(pessoa));
  }

  Future<void> alterarCidade(Map<String, dynamic> cidade) async {
    String url = "http://localhost:8080/cidade";
    Map<String, String> headers = { 'Content-Type': 'application/json; charset=UTF-8'};
    await put(Uri.parse(url), headers: headers, body: jsonEncode(cidade));
  }
  
 }//FIM ACESSO API