class GeneralModel {
  List<GeneralData> data;

  GeneralModel({this.data});

  GeneralModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<GeneralData>();
      json['data'].forEach((v) {
        data.add(new GeneralData.fromJson(v));
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

class GeneralData {
  String id;
  String name;

  GeneralData({this.id, this.name});

  GeneralData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
