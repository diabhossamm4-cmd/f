import 'package:espitaliaa_doctors/models/org/appointment_model.dart';

class OrgServicesModel {
  List<ServicesData> data;
  Meta meta;

  OrgServicesModel({this.data});

  OrgServicesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new ServicesData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
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

class ServicesData {
  int id;
  String title;
  String titleEn;
  String titleAr;
  String description;
  String descriptionAr;
  String descriptionEn;
  String price;
  int active;
  String overalRate;

  ServicesData(
      {this.id,
      this.title,
      this.titleEn,
      this.titleAr,
      this.description,
      this.descriptionAr,
      this.descriptionEn,
      this.active,
      this.price,
      this.overalRate});

  ServicesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    titleEn = json['title_en'];
    titleAr = json['title_ar'];
    description = json['description'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    price = json['price'];
    active = json['active'];

    overalRate = json['overal_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['title_en'] = this.titleEn;
    data['title_ar'] = this.titleAr;
    data['description'] = this.description;
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;
    data['price'] = this.price;
    data['active'] = this.active;
    data['overal_rate'] = this.overalRate;
    return data;
  }
}
