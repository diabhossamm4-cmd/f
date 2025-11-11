class AboutUsModel {
  AboutData data;

  AboutUsModel({this.data});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new AboutData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class AboutData {
  String description;
  String appFacebook;
  String appLinkedin;
  String appTwitter;
  String appInstgram;

  AboutData(
      {this.description,
      this.appFacebook,
      this.appLinkedin,
      this.appTwitter,
      this.appInstgram});

  AboutData.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    appFacebook = json['app_facebook'];
    appLinkedin = json['app_linkedin'];
    appTwitter = json['app_twitter'];
    appInstgram = json['app_instgram'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['app_facebook'] = this.appFacebook;
    data['app_linkedin'] = this.appLinkedin;
    data['app_twitter'] = this.appTwitter;
    data['app_instgram'] = this.appInstgram;
    return data;
  }
}
