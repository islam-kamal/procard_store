import 'package:procard_store/Base/network-mappers.dart';

class ResetPasswordModel extends BaseMappable{
  Data data;
  String token;
  int status;
  String message;
  Errors errors;
  ResetPasswordModel({this.data, this.token, this.status,this.errors,this.message});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
    status = json['status'];
    message = json['message'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['token'] = this.token;
    data['status'] = this.status;
    if (this.errors != null) {
      data['errors'] = this.errors.toJson();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
    status = json['status'];
    message = json['message'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    if(status == 200){
      return ResetPasswordModel(status: status,data: data,token: token);
    }else{
      return ResetPasswordModel(status: status,data: data,token: token,message: message,errors: errors);
    }
  }
}

class Data {
  int id;
  String name;
  String email;
  String phone;
  String type;
  String avatar;
  String localedType;
  String createdAt;
  String createdAtFormated;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.type,
        this.avatar,
        this.localedType,
        this.createdAt,
        this.createdAtFormated});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    type = json['type'];
    avatar = json['avatar'];
    localedType = json['localed_type'];
    createdAt = json['created_at'];
    createdAtFormated = json['created_at_formated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['avatar'] = this.avatar;
    data['localed_type'] = this.localedType;
    data['created_at'] = this.createdAt;
    data['created_at_formated'] = this.createdAtFormated;
    return data;
  }
}
class Errors {
  List<String> token;
  List<String> password;

  Errors({this.token, this.password});

  Errors.fromJson(Map<String, dynamic> json) {
    token = json['token']==null?null :json['token'].cast<String>();
    password = json['password'] ==null? null : json['password'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['password'] = this.password;
    return data;
  }
}