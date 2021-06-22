import 'package:flutter/material.dart';
import 'package:flutter_recipe_session/screens/FilterScreen.dart';
import 'package:flutter_recipe_session/screens/HomeScreen.dart';
import 'package:flutter_recipe_session/screens/LoginScreen.dart';
import 'package:flutter_recipe_session/screens/RecipeDetails.dart';
import 'package:flutter_recipe_session/services/AuthService.dart';
import 'package:flutter_recipe_session/utils/Colors.dart';

AuthService appAuth = new AuthService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget _defaultHome = new LoginScreen();
  // Get result of the login function.
  bool _result = await appAuth.isLoggedIn();
  if (_result) {
    _defaultHome = new HomeScreen();
  }
  runApp(MyApp(defaultHome: _defaultHome));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
    @required Widget defaultHome,
  })  : _defaultHome = defaultHome,
        super(key: key);

  final Widget _defaultHome;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe',
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.blue,
        ),
        primarySwatch: AppColors.primary,
        inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white)),
      ),
      home: _defaultHome,
      routes: <String, WidgetBuilder>{
        // Set routes for using the Navigator.
        '/home': (BuildContext context) => new HomeScreen(),
        '/login': (BuildContext context) => new LoginScreen()
      },
    );
  }
}
