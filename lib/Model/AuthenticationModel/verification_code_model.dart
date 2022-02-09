import 'package:procard_store/Base/network-mappers.dart';

class VerificationCodeModel extends BaseMappable{
  int status;
  String resetToken;
  Links links;
  String message;
  Errors errors;
  VerificationCodeModel({this.status, this.resetToken, this.links,this.message,this.errors});

  VerificationCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    resetToken = json['reset_token'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    message = json['message'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['reset_token'] = this.resetToken;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors.toJson();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    resetToken = json['reset_token'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    message = json['message'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    if(status == 200){
      return VerificationCodeModel(status: status,resetToken: resetToken,links: links);
    }
  else{
      return VerificationCodeModel(status: status,resetToken: resetToken,links: links,message: message,errors: errors);

    }
  }
}

class Links {
  Reset reset;

  Links({this.reset});

  Links.fromJson(Map<String, dynamic> json) {
    reset = json['reset'] != null ? new Reset.fromJson(json['reset']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reset != null) {
      data['reset'] = this.reset.toJson();
    }
    return data;
  }
}

class Reset {
  String href;
  String method;

  Reset({this.href, this.method});

  Reset.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['method'] = this.method;
    return data;
  }
}

class Errors {
  List<String> username;
  List<String> code;

  Errors({this.username, this.code});

  Errors.fromJson(Map<String, dynamic> json) {
    username = json['username']==null?null : json['username'].cast<String>();
    code = json['code']==null?null :json['code'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['code'] = this.code;
    return data;
  }
}