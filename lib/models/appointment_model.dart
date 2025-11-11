class AppointmentModel {
  List<AppointmentData> data;
  Links links;
  Meta meta;

  AppointmentModel({this.data, this.links, this.meta});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<AppointmentData>();
      json['data'].forEach((v) {
        data.add(new AppointmentData.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class AppointmentData {
  int id;
  String date;
  String hour;
  String day;
  String status;
  int price;
  String userName;
  String userPhone;
  String userImage;

  AppointmentData(
      {this.id,
      this.date,
      this.hour,
      this.day,
      this.status,
      this.price,
      this.userName,
      this.userPhone,
      this.userImage});

  AppointmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    hour = json['hour'];
    day = json['day'];
    status = json['status'];
    price = json['price'];
    userName = json['user-name'];
    userPhone = json['user-phone_number'];
    userImage = json['user-image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['hour'] = this.hour;
    data['day'] = this.day;
    data['status'] = this.status;
    data['price'] = this.price;
    data['user-name'] = this.userName;
    data['user-image'] = this.userImage;
    return data;
  }
}

class Links {
  String first;
  String last;
  String prev;
  String next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
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
