import 'package:flutter/material.dart';

class ToDoItem {
  String date;
  String text;
  bool isFavorite;

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

  void addItem(String date, String text) {
    _toDoList.add(ToDoItem(date: date, text: text));
    notifyListeners();
  }

  void removeItem(ToDoItem item) {
    _toDoList.remove(item);
    _toDoListFavorites.remove(item);
    notifyListeners();
  }

  void updateItem(ToDoItem item, String newDate, String newText) {
    item.date = newDate;
    item.text = newText;
    notifyListeners();
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
