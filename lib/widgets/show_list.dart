// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositories/to_do_list.dart';
import 'create_item.dart';
import 'edit_item.dart';

class ToDoListScreen extends StatelessWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toDoList = Provider.of<ToDoRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de To-Do'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                final dateController = TextEditingController();
                final textController = TextEditingController();

                showDialog(
                  context: context,
                  builder: (context) => CreateToDoItem(
                    dateController: dateController,
                    textController: textController,
                    repository: toDoList,
                  ),
                );
              },
              child: Text('Criar Nova Anotação'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: toDoList.toDoList.length,
              itemBuilder: (context, index) {
                final item = toDoList.toDoList[index];
                return Dismissible(
                    key: Key(item.date + item.text),
                    onDismissed: (direction) {
                      toDoList.removeItem(item);
                    },
                    background: Container(
                      color: Colors.blue,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 16.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        final dateController =
                            TextEditingController(text: item.date);
                        final textController =
                            TextEditingController(text: item.text);

                        showDialog(
                          context: context,
                          builder: (context) => EditToDoItem(
                            dateController: dateController,
                            textController: textController,
                            repository: toDoList,
                            item: item,
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(item.date),
                        subtitle: Text(item.text),
                        trailing: Text("Deslize para deletar"),
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
