import 'dart:io';

class UserRegisterModel {
  String nameEN;
  String nameAr;
  String email;
  String password;
  String passwordConfirmation;
  String mobile;
  String gender;
  File profilePic;

  UserRegisterModel(
      this.nameEN,
      this.nameAr,
      this.email,
      this.password,
      this.passwordConfirmation,
      this.mobile,
      this.gender,
      this.profilePic,
      this.titleId,
      this.specialize,
      this.firebaseToken);

  int titleId;

  ///TODO to be edit type of specialization
  String specialize;

  ///TODO to be edit here change firbaseToken
  String firebaseToken;

  UserRegisterModel.fromJson(Map<String, dynamic> json) {
    nameAr = json['name_en'];
    nameEN = json['name_ar'];
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    mobile = json['mobile'];
    gender = json['gender'];
    profilePic = json['profile_pic'];
    titleId = json['title_id'];
    specialize = json['specialize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameAr;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['title_id'] = this.titleId;

    ///TODO to be edit here
    data['specialize'] = this.specialize;

    return data;
  }
}
