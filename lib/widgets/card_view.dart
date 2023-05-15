import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../model/recipes.dart';
import 'package:provider/provider.dart';

import '../recipe_page.dart';

class CardView extends StatelessWidget {
  final int idx;

  const CardView({required this.idx, super.key});

  @override
  Widget build(BuildContext context) {
    final recipe = Provider.of<Recipes>(context).popular[idx];
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(RecipePage.routeName, arguments: recipe),
      child: Card(
        color: Colors.purple[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Container(
                    height: 250,
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: recipe.imgUrl,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    width: 330,
                    color: Colors.black54,
                    child: Text(
                      recipe.label,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.label),
                      SizedBox(
                        width: 6,
                      ),
                      Text('${recipe.dishType}'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.dining_sharp),
                      SizedBox(
                        width: 6,
                      ),
                      Text('${recipe.cuisineType}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
