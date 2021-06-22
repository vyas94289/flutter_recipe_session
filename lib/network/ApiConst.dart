import 'package:flutter_recipe_session/main.dart';
import 'package:flutter_recipe_session/services/AuthService.dart';

class ApiUrls {
  static final String baseUrl = "http://35.160.197.175:3006/api/v1/";
  static final String login = ApiUrls.baseUrl + "user/login";
  static final String addRecipe = ApiUrls.baseUrl + "recipe/add";
  static final String addRecipePhoto =
      ApiUrls.baseUrl + "recipe/add-update-recipe-photo";
  static final String feeds = ApiUrls.baseUrl + "recipe/feeds";
  static final String addIngredient = ApiUrls.baseUrl + "recipe/add-ingredient";
  static final String removeIngredient =
      ApiUrls.baseUrl + "recipe/rm-ingredient";

  static String recipeDetails(String id) {
    return "$ApiUrls.baseUrl/recipe/$id/details";
  }

  static String getIngredients(String id) {
    return "$ApiUrls.baseUrl/recipe/$id/ingredients";
  }
}

class ApiHeaders {
  static Future<Map<String,String>> common() async {
    String token = await appAuth.getToken();
    var header = {"Content-Type": "application/json", "Authorization": "Bearer $token"};
    return header;
  }
}
