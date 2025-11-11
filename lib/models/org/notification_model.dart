class NotificationModel {
  List<NotificationData> data;

  NotificationModel({this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  int id;
  String title;
  String description;
  String actionType;
  int actionId;
  String readAt;
  String createdAt;
  String updatedAt;

  NotificationData(
      {this.id,
      this.title,
      this.description,
      this.actionType,
      this.actionId,
      this.readAt,
      this.createdAt,
      this.updatedAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    actionType = json['action_type'];
    actionId = json['action_id'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['action_type'] = this.actionType;
    data['action_id'] = this.actionId;
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
