import 'package:espitaliaa_doctors/models/appointment_model.dart';

class OrgSubscribersModel {
  List<SubscribersData> data;
  Meta meta;
  OrgSubscribersModel({this.data, this.meta});

  OrgSubscribersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<SubscribersData>();
      json['data'].forEach((v) {
        data.add(new SubscribersData.fromJson(v));
      });
      meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class SubscribersData {
  int id;
  String name;
  String nameEn;
  String nameAr;
  String gender;
  String profilePic;
  String bio;
  String bioEN;
  String bioAr;
  int price;
  int active;
  int isEmergenc;
  String overalRate;
  Speicalize speicalize;
  Title title;
  int organizationId;

  SubscribersData(
      {this.id,
      this.name,
      this.nameEn,
      this.nameAr,
      this.gender,
      this.profilePic,
      this.bio,
      this.bioAr,
      this.bioEN,
      this.price,
      this.active,
      this.isEmergenc,
      this.overalRate,
      this.speicalize,
      this.title,
      this.organizationId});

  SubscribersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    gender = json['gender'];
    profilePic = json['profile_pic'];
    bio = json['bio'];
    bioAr = json['bio_ar'];
    bioEN = json['bio_en'];
    price = json['price'];
    active = json['active'];
    isEmergenc = json['is_emergenc'];
    overalRate = json['overal_rate'];
    speicalize = json['speicalize'] != null
        ? new Speicalize.fromJson(json['speicalize'])
        : null;
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    organizationId = json['organization_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['gender'] = this.gender;
    data['profile_pic'] = this.profilePic;
    data['bio'] = this.bio;
    data['bio_ar'] = this.bioAr;
    data['bio_en'] = this.bioEN;
    data['price'] = this.price;
    data['active'] = this.active;
    data['is_emergenc'] = this.isEmergenc;
    data['overal_rate'] = this.overalRate;
    if (this.speicalize != null) {
      data['speicalize'] = this.speicalize.toJson();
    }
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }
    data['organization_id'] = this.organizationId;
    return data;
  }
}

class Speicalize {
  int id;
  String nameEn;
  String nameAr;
  String icon;
  Null deletedAt;
  String createdAt;
  String updatedAt;
  String name;

  Speicalize(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.icon,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.name});

  Speicalize.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    icon = json['icon'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['icon'] = this.icon;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    return data;
  }
}

class Title {
  int id;
  String name;

  Title({this.id, this.name});

  Title.fromJson(Map<String, dynamic> json) {
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
