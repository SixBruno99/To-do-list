// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:to_do_list/widgets/favorites_list.dart';
import 'package:to_do_list/widgets/show_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentScreen = 0;

  List<Widget> screens = [
    ToDoListScreen(),
    FavoritesList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentScreen],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentScreen,
        onTap: (indice) {
          setState(() {
            _currentScreen = indice;
          });
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white,
        backgroundColor: Color(0xFF181818),
        items: [
          BottomNavigationBarItem(
            label: "Início",
            icon: Icon(Icons.list_alt),
          ),
          BottomNavigationBarItem(
            label: "Favoritas",
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}
