class UserInfo {
  String error;
  int id;
  String firstName;
  String lastName;
  String email;
  String password;
  String token;

  UserInfo(
      {this.error,
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.token});

  UserInfo.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['token'] = this.token;
    return data;
  }
}
