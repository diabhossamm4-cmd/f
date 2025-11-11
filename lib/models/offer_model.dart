import 'package:espitaliaa_doctors/models/appointment_model.dart';

class OfferModel {
  List<OfferData> data;
  Links links;
  Meta meta;
  OfferModel({this.data});

  OfferModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <OfferData>[];
      json['data'].forEach((v) {
        data.add(new OfferData.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferData {
  int id;
  String title;
  String description;
  int discount;
  String discountPic;
  String mainPic;
  String fromDate;
  String toDate;
  int watched;
  int highlighted;
  int active;
  int notified;
  int doctorId;
  String doctorName;
  String doctorAddress;
  String doctorProfilePic;
  String doctorBio;
  String doctorLat;
  String doctorLong;
  String doctorRate;
  List<String> images;

  OfferData(
      {this.id,
      this.title,
      this.description,
      this.discount,
      this.discountPic,
      this.mainPic,
      this.fromDate,
      this.toDate,
      this.watched,
      this.highlighted,
      this.active,
      this.notified,
      this.doctorId,
      this.doctorName,
      this.doctorAddress,
      this.doctorProfilePic,
      this.doctorBio,
      this.doctorLat,
      this.doctorLong,
      this.doctorRate,
      this.images});

  OfferData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    discount = json['discount'];
    discountPic = json['discount_pic'];
    mainPic = json['main_pic'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    watched = json['watched'];
    highlighted = json['highlighted'];
    active = json['active'];
    notified = json['notified'];
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name'];
    doctorAddress = json['doctor_address'];
    doctorProfilePic = json['doctor_profile_pic'];
    doctorBio = json['doctor_bio'];
    doctorLat = json['doctor_lat'];
    doctorLong = json['doctor_long'];
    doctorRate = json['doctor_rate'];
    images = json['images'] != null ? json['images'].cast<String>() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['discount_pic'] = this.discountPic;
    data['main_pic'] = this.mainPic;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['watched'] = this.watched;
    data['highlighted'] = this.highlighted;
    data['active'] = this.active;
    data['notified'] = this.notified;
    data['doctor_id'] = this.doctorId;
    data['doctor_name'] = this.doctorName;
    data['doctor_address'] = this.doctorAddress;
    data['doctor_profile_pic'] = this.doctorProfilePic;
    data['doctor_bio'] = this.doctorBio;
    data['doctor_lat'] = this.doctorLat;
    data['doctor_long'] = this.doctorLong;
    data['doctor_rate'] = this.doctorRate;
    data['images'] = this.images;
    return data;
  }
}
