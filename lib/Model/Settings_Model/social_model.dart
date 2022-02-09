import 'package:procard_store/Base/network-mappers.dart';

class SocialModel extends BaseMappable{
  Data data;
  int status;

  SocialModel({this.data, this.status});

  SocialModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['status'] = this.status;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
    return SocialModel(data: data,status: status);
  }
}

class Data {
  Null title;
  Contacts contacts;
  Social social;

  Data({this.title, this.contacts, this.social});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    contacts = json['contacts'] != null
        ? new Contacts.fromJson(json['contacts'])
        : null;
    social =
    json['social'] != null ? new Social.fromJson(json['social']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.contacts != null) {
      data['contacts'] = this.contacts.toJson();
    }
    if (this.social != null) {
      data['social'] = this.social.toJson();
    }
    return data;
  }
}

class Contacts {
  List<String> phones;
  String email;

  Contacts({this.phones, this.email});

  Contacts.fromJson(Map<String, dynamic> json) {
    phones = json['phones'].cast<String>();
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phones'] = this.phones;
    data['email'] = this.email;
    return data;
  }
}

class Social {
  String facebook;
  String twitter;
  String linkedin;
  String instagram;
  String snapchat;
  String youtube;

  Social(
      {this.facebook,
        this.twitter,
        this.linkedin,
        this.instagram,
        this.snapchat,
        this.youtube});

  Social.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    instagram = json['instagram'];
    snapchat = json['snapchat'];
    youtube = json['youtube'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['linkedin'] = this.linkedin;
    data['instagram'] = this.instagram;
    data['snapchat'] = this.snapchat;
    data['youtube'] = this.youtube;
    return data;
  }
}