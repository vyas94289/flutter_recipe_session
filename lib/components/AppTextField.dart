import 'package:flutter/material.dart';
import 'package:flutter_recipe_session/utils/AppTextFieldType.dart';

// ignore: must_be_immutable
class AppTextField extends StatefulWidget {
  final TextFieldType type;
  String errorMessage;
  final Function onEditingComplete;
  final TextEditingController controller;

  AppTextField(
      this.type, this.errorMessage, this.onEditingComplete, this.controller);

  @override
  _AppTextField createState() => _AppTextField();
}

class _AppTextField extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      obscureText: widget.type.isSecure,
      controller: widget.controller,
      onEditingComplete: () => widget.onEditingComplete(),
      onChanged: textchanged,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          labelText: widget.type.title,
          errorText: widget.errorMessage,
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          suffixIcon: Icon(
            widget.type.icon,
            color: Colors.white,
          )),
    );
  }

  textchanged(String text) {
    setState(() {
      widget.errorMessage = widget.type.validate(text);
    });
  } 
}
