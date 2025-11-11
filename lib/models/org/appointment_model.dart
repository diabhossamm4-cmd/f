class AppointmentOrgModel {
  List<AppointmentOrgData> data;
  Meta meta;

  AppointmentOrgModel({this.data});

  AppointmentOrgModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new AppointmentOrgData.fromJson(v));
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

class AppointmentOrgData {
  int id;
  String date;
  String hour;
  String day;
  String status;
  int price;
  int doctorMeshmeshId;
  String doctorMeshmeshName;
  String doctorMeshmeshGender;
  String doctorMeshmeshProfilePic;
  int doctorMeshmeshPrice;
  int orgServiceId;
  String orgServiceTitle;
  int orgServicePrice;
  User user;

  AppointmentOrgData(
      {this.id,
      this.date,
      this.hour,
      this.day,
      this.status,
      this.price,
      this.doctorMeshmeshId,
      this.doctorMeshmeshName,
      this.doctorMeshmeshGender,
      this.doctorMeshmeshProfilePic,
      this.doctorMeshmeshPrice,
      this.orgServiceId,
      this.orgServiceTitle,
      this.orgServicePrice,
      this.user});

  AppointmentOrgData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    hour = json['hour'];
    day = json['day'];
    status = json['status'];
    price = json['price'];
    doctorMeshmeshId = json['doctor_meshmesh_id'];
    doctorMeshmeshName = json['doctor_meshmesh_name'];
    doctorMeshmeshGender = json['doctor_meshmesh_gender'];
    doctorMeshmeshProfilePic = json['doctor_meshmesh_profile_pic'];
    doctorMeshmeshPrice = json['doctor_meshmesh_price'];
    orgServiceId = json['org_service_id'];
    orgServiceTitle = json['org_service_title'];
    orgServicePrice = json['org_service_price'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['hour'] = this.hour;
    data['day'] = this.day;
    data['status'] = this.status;
    data['price'] = this.price;
    data['doctor_meshmesh_id'] = this.doctorMeshmeshId;
    data['doctor_meshmesh_name'] = this.doctorMeshmeshName;
    data['doctor_meshmesh_gender'] = this.doctorMeshmeshGender;
    data['doctor_meshmesh_profile_pic'] = this.doctorMeshmeshProfilePic;
    data['doctor_meshmesh_price'] = this.doctorMeshmeshPrice;
    data['org_service_id'] = this.orgServiceId;
    data['org_service_title'] = this.orgServiceTitle;
    data['org_service_price'] = this.orgServicePrice;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String socialId;
  String name;
  String email;
  String password;
  String phoneNumber;
  String gender;
  String birthday;
  String image;
  int valid;
  String notifid;
  String validCode;
  String deletedAt;
  String fcmToken;
  String mobileLang;
  String rememberToken;
  String createdAt;
  String updatedAt;

  User(
      {this.id,
      this.socialId,
      this.name,
      this.email,
      this.password,
      this.phoneNumber,
      this.gender,
      this.birthday,
      this.image,
      this.valid,
      this.notifid,
      this.validCode,
      this.deletedAt,
      this.fcmToken,
      this.mobileLang,
      this.rememberToken,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    socialId = json['social_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    birthday = json['birthday'];
    image = json['image'];
    valid = json['valid'];
    notifid = json['notifid'];
    validCode = json['valid_code'];
    deletedAt = json['deleted_at'];
    fcmToken = json['fcm_token'];
    mobileLang = json['mobile_lang'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['social_id'] = this.socialId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone_number'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['image'] = this.image;
    data['valid'] = this.valid;
    data['notifid'] = this.notifid;
    data['valid_code'] = this.validCode;
    data['deleted_at'] = this.deletedAt;
    data['fcm_token'] = this.fcmToken;
    data['mobile_lang'] = this.mobileLang;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  String path;
  int perPage;
  int to;
  int total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
