import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:receipe_app/model/recipe.dart';

class Data {
  String? id;
  String? val;

  Data({required this.id, required this.val});
}

class Recipes with ChangeNotifier {
  final List<Data> _dietLabelList = [];
  final List<Data> _healthLabelList = [];
  final List<Data> _cuisineTypeList = [];
  final List<Data> _dishTypeList = [];
  final List<Data> _ingredientsList = [];
  final List<Recipe> _popularRecipe = [];
  List<Recipe> _finalSearchRecipe = [];
  List<String?> ingredient = [];

  Future<void> initialFetch() async {
    var url = Uri.parse('https://recipiefilter.pythonanywhere.com/index');
    final response = await http.get(url);
    final original = json.decode(response.body) as Map<String, dynamic>;

    final ing = original['ingredients'] as Map<String, dynamic>;

    ing.forEach((key, value) {
      _ingredientsList.add(
        Data(id: key, val: value),
      );
    });

    (original["dietLabels"] as Map<String, dynamic>).forEach((key, value) {
      _dietLabelList.add(Data(id: key, val: value));
    });
    (original["hl"] as Map<String, dynamic>).forEach((key, value) {
      _healthLabelList.add(Data(id: key, val: value));
    });
    (original["ctype"] as Map<String, dynamic>).forEach((key, value) {
      _cuisineTypeList.add(Data(id: key, val: value));
    });
    (original["dishType"] as Map<String, dynamic>).forEach((key, value) {
      _dishTypeList.add(Data(id: key, val: value));
    });
  }

  void getList(List<Data?> ing) {
    ingredient = [];
    ing.forEach((element) {
      ingredient.add(element?.id);
    });
    notifyListeners();
  }

  Future<List<Recipe>> getReq() async {
    // List<String> ingredients = ['milk', 'butter'];
    List<String> healthLabels = [];
    String dishType = '';
    List<String> dietLabels = [];
    String cuisineType = '';
    Map<String, dynamic> queryParams = {
      'ingredients': ingredient.join(','),
      'cuisineType': cuisineType,
      'dishType': dishType,
      'healthLabels': healthLabels.join(','),
      'dietLabels': dietLabels,
    };
    var url = Uri.https(
      'recipiefilter.pythonanywhere.com',
      '/result',
      queryParams,
    );
    print(url);
    final res = await http.post(
      url,
    );
    if (res.statusCode == 200) {
      print(json.decode(res.body));
    } else {
      print(res.body);
    }

    final recipeList = json.decode(res.body) as Map<String, dynamic>;
    _finalSearchRecipe = [];
    for (var element in (recipeList['recipes_list'] as List<dynamic>)) {
      _finalSearchRecipe.add(
        Recipe(
          id: element['label'],
          imgUrl: element['image'],
          ingredients: element['ingredientLines'],
          label: element['label'],
          calories: element['calories'],
          cuisineType: element['cuisineType'][0],
          dietLabels: element['dietLabels'],
          healthLabel: element['healthLabels'],
          dishType: element['dishType'][0],
          url: element['url'],
        ),
      );
    }
    return _finalSearchRecipe;
  }

  Future<List<Recipe>> popularRecipe() async {
    var url = Uri.parse('https://recipiefilter.pythonanywhere.com/popular');
    final res1 = await http.get(url);
    final extractedData = json.decode(res1.body) as Map<String, dynamic>;

    for (var element in (extractedData['recipes'] as List<dynamic>)) {
      _popularRecipe.add(
        Recipe(
          id: element['label'],
          imgUrl: element['image'],
          ingredients: element['ingredientLines'],
          label: element['label'],
          calories: element['calories'],
          cuisineType: element['cuisineType'][0],
          dietLabels: element['dietLabels'],
          healthLabel: element['healthLabels'],
          dishType: element['dishType'][0],
          url: element['url'],
        ),
      );
    }

    return _popularRecipe;
  }

  int getLength() {
    return _popularRecipe.length;
  }

  List<Data> get ingredients {
    return _ingredientsList;
  }

  List<Recipe> get popular {
    return _popularRecipe;
  }

  List<Recipe> finalIng() {
    _finalSearchRecipe = _finalSearchRecipe;
    return _finalSearchRecipe;
  }
}
