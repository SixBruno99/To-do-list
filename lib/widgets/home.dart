// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoItem> todoItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: todoItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todoItems[index].text),
            subtitle: Text(todoItems[index].date),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  todoItems.removeAt(index);
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTodoScreen(
                    todoItem: todoItems[index],
                    onSave: (updatedItem) {
                      setState(() {
                        todoItems[index] = updatedItem;
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodoScreen(
                onSave: (newItem) {
                  setState(() {
                    todoItems.add(newItem);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class TodoItem {
  final String date;
  final String text;

  TodoItem({required this.date, required this.text});
}

class AddTodoScreen extends StatefulWidget {
  final Function(TodoItem) onSave;

  const AddTodoScreen({super.key, required this.onSave});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  late String date;
  late String text;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    date = "${now.day}/${now.month}/${now.year}";
    text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              date,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: 'Todo',
              ),
              onChanged: (value) {
                setState(() {
                  text = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                TodoItem newItem = TodoItem(date: date, text: text);
                widget.onSave(newItem);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditTodoScreen extends StatefulWidget {
  final TodoItem todoItem;
  final Function(TodoItem) onSave;

  const EditTodoScreen({super.key, required this.todoItem, required this.onSave});

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  late String date;
  late String text;

  @override
  void initState() {
    super.initState();
    date = widget.todoItem.date;
    text = widget.todoItem.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              date,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                labelText: 'Todo',
              ),
              onChanged: (value) {
                setState(() {
                  text = value;
                });
              },
              controller: TextEditingController(text: text),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                TodoItem updatedItem = TodoItem(date: date, text: text);
                widget.onSave(updatedItem);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
