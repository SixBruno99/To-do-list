import 'dart:convert';

import 'package:flutter/material.dart';

import '../widgets/login.dart';

import 'package:collection/collection.dart';


class ToDoItem {
  String date;
  String text;
  bool isFavorite;

  var id;

  ToDoItem({
    required this.date,
    required this.text,
    this.isFavorite = false,
  });
}

class ToDoRepository extends ChangeNotifier {
  final List<ToDoItem> _toDoList = [];
  final List<ToDoItem> _toDoListFavorites = [];

  List<ToDoItem> get toDoList => _toDoList;
  List<ToDoItem> get toDoListFavourites => _toDoListFavorites;

  get http => null;

  Future<void> fetchTasks() async {
    final url = Uri.parse(
        "https://todo-api-service.onrender.com/task/user/${GlobalData.userId}");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> responseBody = json.decode(response.body);
        // Processar e atualizar a lista de tarefas conforme necessário
      } else {
        // Exibir mensagem de erro ao usuário
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      // Exibir mensagem de erro ao usuário
      print("Error: $e");
    }
  }

  void addItem(String date, String text) {
    _toDoList.add(ToDoItem(date: date, text: text));
    notifyListeners();
  }

  void removeItem(ToDoItem item) {
    _toDoList.remove(item);
    _toDoListFavorites.remove(item);
    notifyListeners();
  }

void updateItem(String itemId, String newDate, String newText) {
  final item = toDoList.firstWhereOrNull((item) => item.id == itemId);
  if (item != null) {
    item.date = newDate;
    item.text = newText;
    notifyListeners();
  }
}

  void addToFavorites(ToDoItem item) {
    if (!_toDoListFavorites.contains(item)) {
      item.isFavorite = true;
      _toDoListFavorites.add(item);
      notifyListeners();
    }
  }

  void removeFromFavorites(ToDoItem item) {
    if (_toDoListFavorites.contains(item)) {
      item.isFavorite = false;
      _toDoListFavorites.remove(item);
      notifyListeners();
    }
  }
}
