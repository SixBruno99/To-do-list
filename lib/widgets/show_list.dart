// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositories/to_do_list.dart';
import 'create_item.dart';
import 'edit_item.dart';

class ToDoListScreen extends StatelessWidget {
  const ToDoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final toDoList = Provider.of<ToDoRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de To-Do'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: const Color(0xFF181818),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
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
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  backgroundColor: Colors.green,
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Criar Nova Anotação',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
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
                      color: Colors.green,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16.0),
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
                        title: Text(item.date,
                            style: TextStyle(
                                color: Colors.white)), // Cor da fonte branca
                        subtitle: Text(item.text,
                            style: TextStyle(
                                color: Colors.white)), // Cor da fonte branca
                        trailing: Text("Deslize para deletar",
                            style: TextStyle(
                                color: Colors.white)), // Cor da fonte branca
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
