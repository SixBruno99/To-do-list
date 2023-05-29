// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../repositories/to_do_list.dart';

class EditToDoItem extends StatefulWidget {
  final TextEditingController dateController;
  final TextEditingController textController;
  final ToDoRepository repository;
  final ToDoItem item;

  const EditToDoItem({
    super.key,
    required this.dateController,
    required this.textController,
    required this.repository,
    required this.item,
  });

  @override
  State<EditToDoItem> createState() => _EditToDoItemState();
}

class _EditToDoItemState extends State<EditToDoItem> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Anotação'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: widget.dateController,
            decoration: InputDecoration(labelText: 'Data'),
          ),
          TextField(
            controller: widget.textController,
            decoration: InputDecoration(labelText: 'Texto'),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final newDate = widget.dateController.text;
                final newText = widget.textController.text;
                widget.repository.updateItem(widget.item, newDate, newText);
                Navigator.of(context).pop();
              },
              child: Text('Salvar'),
            ),
          ],
        )
      ],
    );
  }
}
