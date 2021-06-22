import 'package:flutter_recipe_session/utils/Const.dart';

class RecipeList {
  int recipeId;
  String name;
  String photo;
  String ytUrl;
  String preparationTime;
  String serves;
  Complexity complexity;
  String firstName;
  String lastName;
  List<Ingredients> ingredients;
  List<Instructions> instructions;

  String get fullName => firstName + " " + lastName;

  RecipeList(
      {this.recipeId,
      this.name,
      this.photo,
      this.ytUrl,
      this.preparationTime,
      this.serves,
      this.complexity,
      this.firstName,
      this.lastName,
      this.ingredients,
      this.instructions});

  RecipeList.fromJson(Map<String, dynamic> json) {
    recipeId = json['recipeId'];
    name = json['name'];
    photo = json['photo'];
    ytUrl = json['ytUrl'];
    preparationTime = json['preparationTime'];
    serves = json['serves'];
    String string = json['complexity'] ?? "";
    complexity = ComplexityExtension.getFromString(string);
    firstName = json['firstName'];
    lastName = json['lastName'];
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients.add(new Ingredients.fromJson(v));
      });
    }
    if (json['instructions'] != null) {
      instructions = <Instructions>[];
      json['instructions'].forEach((v) {
        instructions.add(new Instructions.fromJson(v));
      });
    }
  }
}

class Ingredients {
  int id;
  String ingredient;

  Ingredients({this.id, this.ingredient});

  Ingredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ingredient = json['ingredient'];
  }
}

class Instructions {
  int id;
  String instruction;

  Instructions({this.id, this.instruction});

  Instructions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instruction = json['instruction'];
  }
}
