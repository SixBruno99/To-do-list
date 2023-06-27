// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  Future<void> updateTask() async {
    final newDate = convertToDate(widget.dateController.text);
    final newText = widget.textController.text;

    if (newDate == null) {
      print('Data inválida');
      return;
    }

    final url = Uri.parse(
        'https://todo-api-service.onrender.com/task/${widget.itemId}');
    final response = await http.patch(
      url,
      body: {
        'date': newDate.toIso8601String(),
        'description': newText,
      },
    );

    if (response.statusCode == 200) {
      print('Tarefa atualizada');
      setState(() {
        widget.dateController.text = newDate.toString();
        widget.textController.text = newText;
      });
    } else {
      print(widget.itemId);
      print('Erro ao atualizar a tarefa: ${response.statusCode}');
    }
  }

  DateTime? convertToDate(String input) {
    try {
      return DateFormat('dd-MM-yyyy').parseStrict(input);
    } catch (e) {
      print("$e");
    }
  }

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
                updateTask().then((_) {
                  Navigator.of(context).pop();
                });
              },
              child: Text('Salvar'),
            ),
          ],
        )
      ],
    );
  }
}
