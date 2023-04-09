import 'dart:ffi';

class Recipe {
  String id;
  String label;
  double calories;
  String cuisineType;
  String dishType;
  String url;
  List<dynamic> dietLabels;
  List<dynamic> healthLabel;
  List<dynamic> ingredients;
  String imgUrl;

  Recipe({
    required this.id,
    required this.imgUrl,
    required this.ingredients,
    required this.label,
    required this.calories,
    required this.cuisineType,
    required this.dietLabels,
    required this.healthLabel,
    required this.dishType,
    required this.url,
  });
}
