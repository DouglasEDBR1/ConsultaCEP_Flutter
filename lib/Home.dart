import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // nomeando a biblioteca
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var resultado = "Resultado";
  var valor = "";
  _recuperarCep() async {

    var url = Uri.parse("https://viacep.com.br/ws/$valor/json/"); //recebe o link da api
    http.Response response; //variável response que é do tipo Response, uma classe do HTTP. Para recuperar dados da web.
              //await - espera a execução
    response = await http.get(url) ; //variável recebe método get(pega os dados da url), permite que passe uma URL

    // MAP ->   um objeto que conseguimos armazenar no padrão chave-valor
    // <Chave String - Valor Dinâmico> - Decoficar de uma String para objeto Json através do método json
    Map<String, dynamic> retorno = json.decode( response.body ); //converter string para um objeto json.
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];

    setState(() {
      resultado = "${logradouro} | ${bairro} | ${localidade} - ${uf}";
    });

    print(
      "Resposta logradouro: ${logradouro} | complemento: ${complemento} | bairro: ${bairro} | localidade: ${localidade}"
    );

    //print("resposta: " + response.statusCode.toString() ); // recuperar o status da requisição(se teve erro ou não)
    //print("resposta: " + response.body);  // recuperar o json. Por padrão o body já é uma string


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Endereço'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
                'assets/images/lupa.png',
              width: 50,
            ),
            Text(resultado),
            new Container(
              width: 150.0,
              child: TextField(
                onChanged: (text){
                  valor = text;
                },
                maxLength: 8,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                  labelText: 'CEP',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: _recuperarCep,
                child: Text('Consultar')
            ),
          ],
        ),
      ),
    );
  }
}
