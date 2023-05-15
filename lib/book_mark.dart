import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_app/model/recipe.dart';
import 'package:receipe_app/widgets/book_card.dart';

import 'model/recipes.dart';

class BookMark extends StatefulWidget {
  static const routeName = '/-bookmark';
  const BookMark({super.key});

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  @override
  Widget build(BuildContext context) {
    List<Recipe> pro = Provider.of<Recipes>(context).bookmark;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.purple[100],
        title: const Text(
          'Book Mark',
          style: TextStyle(color: Colors.purple),
        ),
      ),
      body: pro.length == 0
          ? Center(
              child: Text("No Bookmark yet !!"),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return BookCard(
                  idx: index,
                );
              },
              itemCount: pro.length,
            ),
    );
  }
}
