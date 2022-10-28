import 'package:flutter/material.dart';
//Usamos essa biblioteca para encontrar o caminho para armazenar arquivos no ios e android
import 'package:path_provider/path_provider.dart';
//Essa biblioteca io permite que vc faça processamento de arquivos dentro do dispositivo do usuario
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _listaTarefas = [];
  //Método para para armazenar os arquivos no dispositivo do usuario

  //Método que retorna um file. Colocamos o Future pois, o File vai ser retornado no futuro
  Future<File>_getFile() async{
    final diretorio = await getApplicationDocumentsDirectory();
    return File( "${diretorio.path}/dados.json" );
  }

  _salvarArquivo() async {

    var arquivo = await _getFile();
    //Criar dados
    Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = "Ir ao mercado";
    tarefa["realizada"] = false;
    _listaTarefas.add( tarefa );
    /*
    No caso do Map acima, criaria bjetos assim:
    {
    titulo: Ir ao mercado
    realizada: false
    }
    {
    titulo: estudar
    realizada: true
    }
    ...
    */

    //Convertendo dados para json
    String dados = json.encode( _listaTarefas );
    arquivo.writeAsString( dados );

    //print("Caminho: " + diretorio.path );
  }

  //Lendo o arquivo que foi salvo
  _lerArquivo() async {
    //Otrry Catch usamos geralmente para fazer leitura e escrita de arquivos
    //O try catch tenta executar um códogo, caso não conseguir, podemos mostrar uma msg de erro
    try{

      final arquivo = await _getFile();
      return arquivo.readAsString();

    }catch(e){
      return ArgumentError.notNull();
    }
  }

  //Usamos o initState quando precisamos fazer alguma alteração antes de chamar o método build
  @override
  void initState() {
    super.initState();
    //Usamos o .then para recupperar os dados
    _lerArquivo().then( (dados){
      setState(() {
        _listaTarefas = jsonDecode(dados);
      });
    } );

  }

  @override
  Widget build(BuildContext context) {

    //_salvarArquivo();
    print("itens: "+ _listaTarefas.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.purple,
          onPressed: (){

            showDialog(
                context: context,
                builder: (context){

                  return AlertDialog(
                    title: Text("Adicionar Tarefa"),
                    content: TextField(
                      decoration: InputDecoration(
                          labelText: "Digite sua tarefa"
                      ),
                      onChanged: (text){

                      },
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Cancelar"),
                        onPressed: () => Navigator.pop(context) ,
                      ),
                      FlatButton(
                        child: Text("Salvar"),
                        onPressed: (){
                          //salvar

                          Navigator.pop(context);
                        },
                      )
                    ],
                  );

                }
            );

          }
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: _listaTarefas.length,
                itemBuilder: (context, index){

                  return ListTile(
                    title: Text( _listaTarefas[index]["titulo"] ),
                  );

                }
            ),
          )
        ],
      ),
    );
  }
}