import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.purple[100],
      title: Text('Recipe Finder', style: TextStyle(color: Colors.purple)),
    );
  }

  @override
  Size get preferredSize => const Size(100, 50);
}
