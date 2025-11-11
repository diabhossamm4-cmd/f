class UserLoginModel {
  String email;
  String password;
  bool rememberMe;
  String firebaseToken;

  UserLoginModel(
      {this.email, this.password, this.firebaseToken, this.rememberMe});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['fcm_token'] = this.firebaseToken;
    return data;
  }
}
