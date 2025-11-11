import 'dart:convert';

import 'package:espitaliaa_doctors/models/general_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  String accessToken;
  UserData data;
  String userType;

  UserModel({this.accessToken, this.data, this.userType});

  UserModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
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

  Future<void> saveUserData(UserData userData) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String user = jsonEncode(userData);
    _pref.setString("user_data", "$user");
  }

  Future<UserData> get getUserData async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    Map data = jsonDecode(_pref.getString("user_data"));
    var user = UserData.fromJson(data);
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

class UserData {
  int id;
  String name;
  String nameAr;
  String nameEn;
  String email;
  String profilePic;
  String mobile;
  String gender;
  String bio;
  String bioAr;
  String bioEn;
  String clinicInfo;
  String clinicInfoAr;
  int watched;
  String clinicInfoEn;
  List<String> clinicService;
  List<String> clinicServiceAr;
  List<String> clinicServiceEn;
  List<String> clinicImages;
  String address;
  String addressAr;
  String addressEn;
  String location;
  String lat;
  String long;
  int price;
  double overalRate;
  int isEmergenc;
  String type;
  GeneralData city;
  GeneralData district;
  List<GeneralData> specializations;
  GeneralData title;
  double rates;
  int valid;
  String validCode;
  int smsOtp;

  UserData(
      {this.id,
      this.name,
      this.nameAr,
      this.nameEn,
      this.email,
      this.profilePic,
      this.mobile,
      this.gender,
      this.bio,
      this.bioAr,
      this.bioEn,
      this.clinicInfo,
      this.clinicInfoAr,
      this.clinicInfoEn,
      this.clinicService,
      this.clinicServiceAr,
      this.clinicServiceEn,
      this.clinicImages,
      this.address,
      this.addressAr,
      this.addressEn,
      this.location,
      this.lat,
      this.long,
      this.price,
      this.overalRate,
      this.isEmergenc,
      this.type,
      this.city,
      this.district,
      this.specializations,
      this.smsOtp,
      this.valid,
      this.validCode,
      this.title,
      this.rates});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    email = json['email'];
    profilePic = json['profile_pic'];
    mobile = json['mobile'];
    gender = json['gender'];
    bio = json['bio'];
    bioAr = json['bio_ar'];
    bioEn = json['bio_en'];
    clinicInfo = json['clinic_info'];
    clinicInfoAr = json['clinic_info_ar'];
    clinicInfoEn = json['clinic_info_en'];
    clinicService = json['clinic_service'].cast<String>();
    clinicServiceAr = json['clinic_service_ar'] != null ? json['clinic_service_ar'].cast<String>() : null;
    clinicServiceEn = json['clinic_service_en'] != null ? json['clinic_service_en'].cast<String>() : null;
    clinicImages = json['clinic_images'].cast<String>();
    address = json['address'];
    addressAr = json['address_ar'];
    addressEn = json['address_en'];
    location = json['location'];
    lat = json['lat'];
    long = json['long'];
    price = json['price'];
    overalRate = json['overal_rate'] != null
        ? json['overal_rate'] is double
            ? json['overal_rate']
            : json['overal_rate'] is String
                ? double.parse(json['overal_rate'])
                : json['overal_rate'].toDouble()
        : null;
    isEmergenc = json['is_emergenc'];
    type = json['type'];
    city = json['city'] != null ? new GeneralData.fromJson(json['city']) : null;
    district = json['district'] != null ? new GeneralData.fromJson(json['district']) : null;

    if (json['specializations'] != null) {
      specializations = new List<GeneralData>();
      json['specializations'].forEach((v) {
        specializations.add(new GeneralData.fromJson(v));
      });
    }
    title = json['title'] != null ? new GeneralData.fromJson(json['title']) : null;
    rates = json['rates'] is double ? json['rates'] : json['rates'].toDouble();
    watched = json['watched'];
    valid = json['valid'];
    validCode = json['valid_code'];
    smsOtp = json['sms_otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profile_pic'] = this.profilePic;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['bio'] = this.bio;
    data['watched'] = this.watched;

    data['clinic_info'] = this.clinicInfo;
    data['clinic_service'] = this.clinicService;
    data['clinic_images'] = this.clinicImages;
    data['address'] = this.address;
    data['location'] = this.location;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['price'] = this.price;
    data['overal_rate'] = this.overalRate;
    data['is_emergenc'] = this.isEmergenc;
    data['type'] = this.type;
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    if (this.district != null) {
      data['district'] = this.district.toJson();
    }
    if (this.specializations != null) {
      data['specializations'] = this.specializations.map((v) => v.toJson()).toList();
    }
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }
    if (this.valid != null) {
      data['valid'] = this.valid;
    }

    if (this.validCode != null) {
      data['valid_code'] = this.validCode;
    }

    if (this.smsOtp != null) {
      data['sms_otp'] = this.smsOtp;
    }

    data['rates'] = this.rates;
    return data;
  }
}
