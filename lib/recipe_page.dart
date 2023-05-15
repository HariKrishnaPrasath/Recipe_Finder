import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_app/model/recipe.dart';

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
    int val = 0;
    var pro = Provider.of<Recipes>(context);
    List<Recipe> recipe = Provider.of<Recipes>(context).finalIng;
    final height = MediaQuery.of(context).size.height;
    final Recipe ing = ModalRoute.of(context)!.settings.arguments as Recipe;
    // Recipe final_r = recipe.firstWhere((element) => element.label == ing);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.purple[100],
        title: Text('${ing.label}', style: TextStyle(color: Colors.purple)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: height * 0.3,
                width: double.infinity,
                child: Image.network(
                  ing.imgUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Health Label: "),
              Chip(
                backgroundColor: Colors.purple[50],
                label: Text(ing.healthLabel[0]),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Calories: "),
              Chip(
                backgroundColor: Colors.purple[50],
                label: Text(ing.calories.toInt().toString()),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Column(
                          children: [
                            Text(
                              "Procedure",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: ing.ingredients.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Text((index + 1).toString()),
                                    title: Text("${ing.ingredients[index]}"),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Guide"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (val == 0) {
                      pro.add(ing);
                      setState(() {
                        val += 1;
                      });
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Recipe added !!',
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Text("Bookmark"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
