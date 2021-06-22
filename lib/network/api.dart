import 'package:flutter_recipe_session/models/RecipeInfo.dart';
import 'package:flutter_recipe_session/models/UserInfo.dart';
import 'package:flutter_recipe_session/network/ApiConst.dart';
import 'package:flutter_recipe_session/utils/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'dart:async';

import 'dart:convert';

class ApiRequest {
  static final ApiRequest shared = ApiRequest._internal();

  factory ApiRequest() {
    return shared;
  }

  ApiRequest._internal();

  void validateResponseStatus(int status, int validStatus) {
    if (status == 401) {
      throw new AuthException("401", "Unauthorized");
    }

    if (status != validStatus) {
      throw new ApiException(status.toString(), "API Error");
    }
  }

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Future<UserInfo> login(String email, String password) async {
    Map data = {'email': email, 'password': password};
    String body = json.encode(data);

    http.Response response = await http.post(
      ApiUrls.login,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    Map<String, dynamic> apiResponse = json.decode(response.body);
    UserInfo userInfo = UserInfo.fromJson(apiResponse);
    return userInfo;
  }

  Future<List<RecipeList>> fetchFeeds() async {
    var headers = await ApiHeaders.common();
    http.Response response = await http.get(
      ApiUrls.feeds,
      headers: headers,
    );
    List<dynamic> list = json.decode(response.body) ?? [];
    List<RecipeList> feeds = [];
    for (var item in list) {
      Map<String, dynamic> map = item;
      var info = RecipeList.fromJson(map);
      if (info.photo != null) {
        feeds.add(info);
      }
    }
    return feeds;
  }
}
