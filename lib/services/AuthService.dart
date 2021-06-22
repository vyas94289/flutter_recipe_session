import 'dart:async';
import 'dart:math';

import 'package:flutter_recipe_session/models/UserInfo.dart';
import 'package:flutter_recipe_session/network/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String keyToken = "token";

  Future<String> loginRequest(String email, String password) async {
    String errorMsg;
    await ApiRequest.shared.login(email, password).then((value) {
      if (value.token != null) {
        login(value.token);
        errorMsg = null;
      } else {
        errorMsg = value.error;
      }
    }).catchError((error) {
      errorMsg = error.toString();
    });
    return errorMsg;
  }

  // Login
  login(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyToken, token);
  }

  // Logout
  Future<void> logout() async {
    // Simulate a future for response after 1 second.
    return await new Future<void>.delayed(new Duration(seconds: 1));
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString(keyToken) ?? "");
  }

  Future<bool> isLoggedIn() async {
    var isLoggedIn = false;
    await getToken().then((value) => isLoggedIn = value.isNotEmpty);
    return isLoggedIn;
  }
}
