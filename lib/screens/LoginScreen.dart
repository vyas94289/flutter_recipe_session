import 'package:flutter/material.dart';
import 'package:flutter_recipe_session/components/AppTextField.dart';
import 'package:flutter_recipe_session/components/WaveShape.dart';
import 'package:flutter_recipe_session/utils/AppTextFieldType.dart';
import 'package:flutter_recipe_session/utils/Colors.dart';
import 'package:flutter_recipe_session/utils/Validator.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  String emailError = "";
  String passwordError = "";
  bool checkValidation() {
    bool isValid = true;
    var email = this.emailController.text;
    var password = this.passwordController.text;
    emailError = Validator.validateEmail(email) ?? "";
    if (emailError.isNotEmpty) {
      isValid = false;
    }
    passwordError = Validator.validatePassword(password) ?? "";
    if (passwordError.isNotEmpty) {
      isValid = false;
    }
    setState(() {});
    return isValid;
  }

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
        body: Container(
            height: double.infinity,
            color: AppColors.background,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildClipPath(),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("Hello there,\nwelcome back",
                          style: TextStyle(fontSize: 30))),
                  buildForm(node, context)
                ],
              ),
            )));
  }

  Form buildForm(FocusScopeNode node, BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: (Column(
          children: [
            AppTextField(
              TextFieldType.email,
              this.emailError,
              () => node.nextFocus(),
              this.emailController,
            ),
            SizedBox(height: 20),
            AppTextField(
              TextFieldType.password,
              this.passwordError,
              () => node.unfocus(),
              this.passwordController,
            ),
            SizedBox(height: 30),
            loginButton(context),
            SizedBox(height: 20),
            IgnorePointer(
              ignoring: true,
              child: TextButton(
                onPressed: () {},
                child: Text('Forget Password?',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        decoration: TextDecoration.underline)),
              ),
            )
          ],
        )),
      ),
    );
  }

  ClipPath buildClipPath() => ClipPath(
      child: Container(
          height: 200,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF7300be), Color(0xFF5f00ce)]))),
      clipper: WaveShape());

  SizedBox loginButton(BuildContext context) => SizedBox(
      width: double.infinity,
      height: 50,
      child: this.isLoading
          ? Center(child: CircularProgressIndicator())
          : ElevatedButton(
              child: Text('Login', style: TextStyle(fontSize: 18)),
              onPressed: () {
                if (this.checkValidation()) {
                  doLogin();
                }
              },
            ));

  doLogin() {
    _formKey.currentState.save();
    setState(() {
      this.isLoading = true;
    });
    appAuth
        .loginRequest(
      this.emailController.text,
      this.passwordController.text,
    )
        .then((error) {
      if (error == null || error.isEmpty) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error)));
      }
    }).whenComplete(() => {
              setState(() {
                this.isLoading = false;
              })
            });
  }

  @override
  void initState() {
    emailController.text = "jm1@example.com";
    passwordController.text = "jay@123";
    super.initState();
  }
}
