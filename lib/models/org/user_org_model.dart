import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserOrgModel {
  String accessToken;
  UserOrgData data;
  String userType;

  UserOrgModel({this.accessToken, this.data, this.userType});

  UserOrgModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    data = json['data'] != null ? new UserOrgData.fromJson(json['data']) : null;
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['user_type'] = this.userType;
    return data;
  }

  Future<void> saveToken(String token) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    this.accessToken = "Bearer $token";
    _pref.setString("token", "Bearer $token");
  }

  Future<String> get getToken async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString("token");
  }

  Future<bool> get isLoggedIn async {
    // if token found , user loggedIn,
    return await getToken != null;
  }

  Future<void> saveRememberMe(bool remember) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setBool("remember_me", remember ?? false);
  }

  Future<bool> get getRememberMe async {
    // if token found , user loggedIn,
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getBool("remember_me") ?? false;
  }

  Future<void> resetUser() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.clear();
  }

  Future<void> saveUserData(UserOrgData userData) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String user = jsonEncode(userData);
    _pref.setString("user_data", "$user");
  }

  Future<UserOrgData> get getUserData async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    Map data = jsonDecode(_pref.getString("user_data"));
    var user = UserOrgData.fromJson(data);
    return user;
  }

  Future<void> saveUserType(String userType) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString("user_type", userType);
  }

  Future<String> get getUserType async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString("user_type");
  }
}

class UserOrgData {
  int id;
  String name;
  String nameAr;
  String nameEn;
  String description;
  String email;
  String descriptionAr;
  String descriptionEn;
  String address;
  String addressAr;
  String addressEn;
  String lat;
  String long;
  String logo;
  String organizationType;
  int organizationId;
  int cityId;
  int areaId;
  int watched;
  List<String> phones;
  List<String> images;
  List<Specializations> specializations;
  int rate;

  UserOrgData(
      {this.id,
      this.name,
      this.nameAr,
      this.nameEn,
      this.description,
      this.descriptionAr,
      this.descriptionEn,
      this.address,
      this.addressAr,
      this.email,
      this.addressEn,
      this.lat,
      this.long,
      this.logo,
      this.cityId,
      this.areaId,
      this.organizationType,
      this.organizationId,
      this.phones,
      this.images,
      this.specializations,
      this.watched,
      this.rate});

  UserOrgData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    email = json['email'];
    description = json['description'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    address = json['address'];
    addressAr = json['address_ar'];
    addressEn = json['address_en'];
    lat = json['lat'];
    long = json['long'];
    logo = json['logo'];
    cityId = json['city_id'];
    areaId = json['district_id'];
    organizationType = json['organization_type'];
    organizationId = json['organization_id'];
    phones = json['phones'].cast<String>();
    images = json['images'].cast<String>();

    if (json['specializations'] != null) {
      specializations = new List<Specializations>();
      json['specializations'].forEach((v) {
        specializations.add(new Specializations.fromJson(v));
      });
    }
    rate = json['rate'];
    watched = json['watched'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['description'] = this.description;
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;
    data['address'] = this.address;
    data['email'] = this.address;
    data['address_ar'] = this.addressAr;
    data['address_en'] = this.addressEn;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['logo'] = this.logo;
    data['organization_type'] = this.organizationType;
    data['organization_id'] = this.organizationId;
    data['phones'] = this.phones;
    data['images'] = this.images;
    data['watched'] = this.watched;

    if (this.specializations != null) {
      data['specializations'] =
          this.specializations.map((v) => v.toJson()).toList();
    }
    data['rate'] = this.rate;
    return data;
  }
}

class Specializations {
  int id;
  String name;

  Specializations({this.id, this.name});

  Specializations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
