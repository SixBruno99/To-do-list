// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../repositories/to_do_list.dart';
import 'create_item.dart';
import 'edit_item.dart';
import 'login.dart';

class ToDoListScreen extends StatelessWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> tasksRequest(String userId) async {
    final url =
        Uri.parse("https://todo-api-service.onrender.com/task/user/$userId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      List<Map<String, dynamic>> showList = [];
      for (final task in responseBody) {
        showList.add(Map<String, dynamic>.from(task));
      }
      return showList;
    } else {
      throw Exception('Failed to fetch tasks: ${response.statusCode}');
    }
  }

  Future<void> deleteTask(String taskId) async {
    final url = Uri.parse('https://todo-api-service.onrender.com/task/$taskId');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print('Tarefa excluída');
    } else {
      print('Erro ao excluir a tarefa: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final toDoList = Provider.of<ToDoRepository>(context);

    Future<List<Map<String, dynamic>>> showList =
        tasksRequest(GlobalData.userId);

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
            FutureBuilder<List<Map<String, dynamic>>>(
              future: showList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.white),
                  );
                } else {
                  final tasks = snapshot.data!;
                  if (tasks.isEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Nenhuma nota foi criada ainda.',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final item = tasks[index];
                          return Dismissible(
                            key: Key(item['_id']),
                            onDismissed: (direction) {
                              deleteTask(item['_id']);
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
                                    TextEditingController(text: item['date']);
                                final textController = TextEditingController(
                                    text: item['description']);

                                showDialog(
                                  context: context,
                                  builder: (context) => EditToDoItem(
                                    dateController: dateController,
                                    textController: textController,
                                    repository: toDoList,
                                    itemId:
                                        item['_id'], // Passe o ID corretamente
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: InkWell(
                                  onTap: () {
                                    if (item['isFavorite'] != null) {
                                      // Adicionar ou remover dos favoritos
                                    }
                                  },
                                  child: Icon(
                                    item['isFavorite'] == true
                                        ? Icons.star_sharp
                                        : Icons.star_border,
                                    color: Colors.green,
                                  ),
                                ),
                                title: Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(DateTime.parse(item['date']))
                                      .toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(item['description'],
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
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
