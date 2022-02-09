import 'package:procard_store/fileExport.dart';


class SignInModel extends BaseMappable{
  Data data;
  String token;
  int status;
  String message;
  Errors errors;
  SignInModel({this.data, this.token, this.status,this.message,this.errors});

  SignInModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
    status = json['status'];
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
    message = json['message'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    if(status == 200){
      return SignInModel(status: status,token: token , data: data);

    }else{
      return SignInModel(status: status,token: token , data: data,message: message,);

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
  List<String> username;
  List<String> password;

  Errors({this.username, this.password});

  Errors.fromJson(Map<String, dynamic> json) {
    username = json['username']==null? null : json['username'].cast<String>();
    password = json['password']==null? null : json['password'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}