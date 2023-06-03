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
        title: Text('Lista de Notas'),
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
            toDoList.toDoList.isEmpty
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Nenhuma nota foi criada ainda.',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Expanded(
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
                              leading: InkWell(
                                onTap: () {
                                  if (item.isFavorite) {
                                    toDoList.removeFromFavorites(item);
                                  } else {
                                    toDoList.addToFavorites(item);
                                  }
                                },
                                child: Icon(
                                  item.isFavorite
                                      ? Icons.star_sharp
                                      : Icons.star_border,
                                  color: Colors.green,
                                ),
                              ),
                              title: Text(item.date,
                                  style: TextStyle(color: Colors.white)),
                              subtitle: Text(item.text,
                                  style: TextStyle(color: Colors.white)),
                              trailing: Text(
                                "Deslize para deletar",
                                style: TextStyle(color: Colors.white),
                              ),
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
