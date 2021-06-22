
class Validator {
  static String validateEmail(String value) {
    if (value == null || value.isEmpty )
      return "Enter email address";
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return null;
  }

 static String validatePassword(String value) {
    if (value == null || value.isEmpty )
      return "Enter the password";
    else if (value.length < 6)
      return 'Password length should be greater then 5 characters';
    else
      return null;
  }
}