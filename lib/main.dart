import 'package:flutter/material.dart';
import 'package:receipe_app/home_page.dart';
import 'package:receipe_app/model/recipes.dart';
import 'package:receipe_app/recipe_page.dart';
import 'package:receipe_app/search.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return Recipes();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
          useMaterial3: true,
        ),
        routes: {
          SearchPage.routeName: (context) => SearchPage(),
          RecipePage.routeName: (context) => RecipePage(),
        },
        home: HomePage(),
      ),
    );
  }
}
