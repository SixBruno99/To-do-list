import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/repositories/to_do_list.dart';
import 'package:to_do_list/widgets/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ToDoRepository>(
          create: (_) => ToDoRepository(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    ),
  );
}
