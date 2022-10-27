import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _lista = ['teste 1', 'teste 2', 'teste 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""
            "Lista de tarefas"
        ),
        backgroundColor: Colors.purple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  title: Text('Adicionar tarefas'),
                  content: TextField(
                    decoration: InputDecoration(
                      labelText: 'Digite sua tarefa'
                    ),
                    onChanged: (text){

                    },
                  ),
                  actions: [
                    FlatButton(
                      child: Text('Cancelar'),
                        onPressed: () => Navigator.pop(context)
                    ),
                    FlatButton(
                        child: Text('Salvar'),
                        onPressed: (){
                          //Depois vamos criar os passos para salvar o que foi digitado
                          Navigator.pop(context);
                        }
                    )
                  ],
                );
              }
          );

        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: _lista.length,
                    itemBuilder: (context , index){
                      return ListTile(
                        title: Text(_lista[index]),
                      );
                    }
                )
            )
          ],
        )
      ),

    );
  }
}
