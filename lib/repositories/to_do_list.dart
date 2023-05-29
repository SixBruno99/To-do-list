import 'package:flutter/material.dart';

class ToDoItem {
  String date;
  String text;

  ToDoItem({
    required this.date,
    required this.text,
  });
}

class ToDoRepository extends ChangeNotifier {
  final List<ToDoItem> _toDoList = [];

  List<ToDoItem> get toDoList => _toDoList;

  void addItem(String date, String text) {
    _toDoList.add(ToDoItem(date: date, text: text));
    notifyListeners();
  }

  void removeItem(ToDoItem item) {
    _toDoList.remove(item);
    notifyListeners();
  }

  void updateItem(ToDoItem item, String newDate, String newText) {
    item.date = newDate;
    item.text = newText;
    notifyListeners();
  }
}
