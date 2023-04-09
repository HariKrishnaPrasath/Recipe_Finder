import 'package:flutter/material.dart';

import 'model/recipes.dart';

class RecipePage extends StatefulWidget {
  static const routeName = '/recipe';

  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    final List<Data?> ing =
        ModalRoute.of(context)?.settings.arguments as List<Data?>;

    return const Scaffold();
  }
}
