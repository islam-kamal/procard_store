import 'package:procard_store/Base/network-mappers.dart';


class SliderModel extends BaseMappable{
  int status;
  List<Data> data;

  SliderModel({this.status, this.data});

  SliderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    return SliderModel(status: status,data: data);
  }
}

class Data {
  var id;
  var title;
  var content;
  var image;
  var createdAt;
  var createdAtFormated;

  Data(
      {this.id,
        this.title,
        this.content,
        this.image,
        this.createdAt,
        this.createdAtFormated});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    createdAt = json['created_at'];
    createdAtFormated = json['created_at_formated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['created_at_formated'] = this.createdAtFormated;
    return data;
  }
}