import 'package:flutter/material.dart';
import 'package:flutter_recipe_session/utils/Validator.dart';

enum TextFieldType { email, password }

extension TextFieldTypeExtension on TextFieldType {
  String get title {
    switch (this) {
      case TextFieldType.email:
        return 'Email Address';
      case TextFieldType.password:
        return 'Password';
      default:
        return null;
    }
  }

  IconData get icon {
    switch (this) {
      case TextFieldType.email:
        return Icons.email_outlined;
      case TextFieldType.password:
        return Icons.lock_outlined;
      default:
        return null;
    }
  }

  bool get isSecure {
    return this == TextFieldType.password;
  }

  String validate(String value) {
    switch (this) {
      case TextFieldType.email:
        return Validator.validateEmail(value);
      case TextFieldType.password:
        return Validator.validatePassword(value);
    }
    return null;
  }
}
