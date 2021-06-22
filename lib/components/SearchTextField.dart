import 'package:flutter/material.dart';
import 'package:flutter_recipe_session/utils/Colors.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final IconData iconData;
  final TextEditingController controller;
  const SearchTextField({
    Key key,
    this.hintText,
    this.controller, this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.grey,
      style: TextStyle(
        color: Colors.white,
      ),
      controller: this.controller,
      decoration: InputDecoration(
          prefixIcon: Icon(
            this.iconData,
            color: Colors.white,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.all(4),
          hintStyle: TextStyle(color: Colors.white54),
          filled: true,
          fillColor: AppColors.fillColor,
          hintText: this.hintText),
    );
  }
}
