// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../repositories/to_do_list.dart';

class EditToDoItem extends StatefulWidget {
  final TextEditingController dateController;
  final TextEditingController textController;
  final ToDoRepository repository;
  final String itemId;

  const EditToDoItem({
    Key? key,
    required this.dateController,
    required this.textController,
    required this.repository,
    required this.itemId,
  }) : super(key: key);

  @override
  State<EditToDoItem> createState() => _EditToDoItemState();
}

class _EditToDoItemState extends State<EditToDoItem> {
  @override
  void initState() {
    super.initState();
    final formattedDate = DateFormat('dd-MM-yyyy')
        .format(DateTime.parse(widget.dateController.text));
    widget.dateController.text = formattedDate;
  }

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
            keyboardType: TextInputType.datetime,
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              ).then((selectedDate) {
                if (selectedDate != null) {
                  final formattedDate =
                      DateFormat('dd-MM-yyyy').format(selectedDate);
                  widget.dateController.text = formattedDate;
                }
              });
            },
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
                widget.repository
                    .updateItem(widget.itemId, newDate, newText);
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
