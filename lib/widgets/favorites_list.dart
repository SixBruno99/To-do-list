// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositories/to_do_list.dart';
import 'edit_item.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesList = Provider.of<ToDoRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Favoritos'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: const Color(0xFF181818),
        child: Column(
          children: [
            favoritesList.toDoListFavourites.isEmpty
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Nenhuma nota favoritada ainda.',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: favoritesList.toDoListFavourites.length,
                      itemBuilder: (context, index) {
                        final item = favoritesList.toDoListFavourites[index];
                        return Dismissible(
                          key: Key(item.date + item.text),
                          onDismissed: (direction) {
                            favoritesList.removeItem(item);
                          },
                          background: Container(
                            color: Colors.green,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              final dateController =
                                  TextEditingController(text: item.date);
                              final textController =
                                  TextEditingController(text: item.text);

                              showDialog(
                                context: context,
                                builder: (context) => EditToDoItem(
                                  dateController: dateController,
                                  textController: textController,
                                  repository: favoritesList,
                                  item: item,
                                ),
                              );
                            },
                            child: ListTile(
                              leading: InkWell(
                                onTap: () {
                                  if (item.isFavorite) {
                                    favoritesList.removeFromFavorites(item);
                                  } else {
                                    favoritesList.addToFavorites(item);
                                  }
                                },
                                child: Icon(
                                  Icons.star_sharp,
                                  color: Colors.green,
                                ),
                              ),
                              title: Text(item.date,
                                  style: TextStyle(color: Colors.white)),
                              subtitle: Text(item.text,
                                  style: TextStyle(color: Colors.white)),
                              trailing: Text(
                                "Deslize para deletar",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
