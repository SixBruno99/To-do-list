// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../repositories/to_do_list.dart';

class CreateToDoItem extends StatefulWidget {
  final TextEditingController dateController;
  final TextEditingController textController;
  final ToDoRepository repository;

  const CreateToDoItem({
    Key? key,
    required this.dateController,
    required this.textController,
    required this.repository,
  }) : super(key: key);

  @override
  State<CreateToDoItem> createState() => _CreateToDoItemState();
}

class _CreateToDoItemState extends State<CreateToDoItem> {
  String selectedDate = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar To-Do'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: widget.dateController,
            decoration: InputDecoration(labelText: 'Selecione a Data'),
            onTap: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                onConfirm: (date) {
                  final formattedDate = DateFormat('dd/MM/yyyy').format(date);
                  widget.dateController.text = formattedDate;
                  setState(() {
                    selectedDate = formattedDate;
                  });
                },
                currentTime: DateTime.now(),
              );
            },
          ),
          TextField(
            controller: widget.textController,
            decoration: InputDecoration(labelText: 'Anotação'),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final String formattedDate = selectedDate;
                final String text = widget.textController.text;
                if (formattedDate.isNotEmpty && text.isNotEmpty) {
                  widget.repository.addItem(formattedDate, text);
                  Navigator.pop(context);
                }
              },
              child: Text('Adicionar'),
            ),
          ],
        )
      ],
    );
  }
}
