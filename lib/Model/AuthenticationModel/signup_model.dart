import 'package:procard_store/Base/network-mappers.dart';

class SignUpModel extends BaseMappable{
  Data data;
  String token;
  int status;
  String message;
  Errors errors;
  SignUpModel({this.data, this.token, this.status,this.message, this.errors});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
    status = json['status'];
    message = json['message'];
    errors = json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['token'] = this.token;
    data['status'] = this.status;
    data['message'] = this.message;
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
    if(status ==200){
      return SignUpModel(status: status,token: token,data: data);
    }else{
      return SignUpModel(status: status,token: token,data: data,errors: errors,message: message);
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
  List<String> name;
  List<String> email;
  List<String> phone;
  List<String> password;
  List<String> phoneCode;

  Errors({this.name, this.email, this.phone, this.password, this.phoneCode});

  Errors.fromJson(Map<String, dynamic> json) {
    name = json['name']==null?null:json['name'].cast<String>();
    email = json['email']==null ? null :json['email'].cast<String>();
    phone = json['phone']==null?null : json['phone'].cast<String>();
    password = json['password']==null?null :json['password'].cast<String>();
    phoneCode = json['phone_code']==null? null : json['phone_code'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['phone_code'] = this.phoneCode;
    return data;
  }
}