
import 'package:procard_store/Base/network-mappers.dart';

class ForgerPasswordModel extends BaseMappable {
  int status;
  String message;
  Links links;
  Errors errors;

  ForgerPasswordModel({this.status, this.message, this.links,this.errors});

  ForgerPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors.toJson();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    if(status == 204){
      return ForgerPasswordModel(status: status,message: message,links: links);
    }else{
      return ForgerPasswordModel(status: status,message: message,links: links,errors:errors);
    }
  }
}

class Links {
  Code code;

  Links({this.code});

  Links.fromJson(Map<String, dynamic> json) {
    code = json['code'] != null ? new Code.fromJson(json['code']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.code != null) {
      data['code'] = this.code.toJson();
    }

    return data;
  }
}

class Code {
  String href;
  String method;
  String code;

  Code({this.href, this.method, this.code});

  Code.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    method = json['method'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['method'] = this.method;
    data['code'] = this.code;
    return data;
  }
}
class Errors {
  List<String> username;

  Errors({this.username});

  Errors.fromJson(Map<String, dynamic> json) {
    username = json['username']==null ? null : json['username'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    return data;
  }
}