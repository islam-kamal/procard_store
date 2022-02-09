import 'package:procard_store/Base/network-mappers.dart';

class SignUpMerchantModel extends BaseMappable {
  Data data;
  String token;
  int status;
  String message;
  Errors errors;
  SignUpMerchantModel({this.data, this.token, this.status,this.message,this.errors});

  SignUpMerchantModel.fromJson(Map<String, dynamic> json) {
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
    if(status == 200){
      return SignUpMerchantModel(status: status,data: data,token: token);
    }else{
      return SignUpMerchantModel(status: status,data: data,token: token,message: message,errors: errors);
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
  String commercialNumber;
  String commercialImage;
  String localedType;
  String createdAt;
  String createdAtFormated;
  String address;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.type,
        this.avatar,
        this.commercialNumber,
        this.commercialImage,
        this.localedType,
        this.createdAt,
        this.createdAtFormated,
        this.address});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    type = json['type'];
    avatar = json['avatar'];
    commercialNumber = json['commercial_number'];
    commercialImage = json['commercial_image'];
    localedType = json['localed_type'];
    createdAt = json['created_at'];
    createdAtFormated = json['created_at_formated'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['avatar'] = this.avatar;
    data['commercial_number'] = this.commercialNumber;
    data['commercial_image'] = this.commercialImage;
    data['localed_type'] = this.localedType;
    data['created_at'] = this.createdAt;
    data['created_at_formated'] = this.createdAtFormated;
    data['address'] = this.address;
    return data;
  }
}

class Errors {
  List<String> name;
  List<String> email;
  List<String> phone;
  List<String> password;
  List<String> commercialNumber;
  List<String> commercialImage;
  List<String> phoneCode;
  List<String> address;

  Errors(
      {this.name,
        this.email,
        this.phone,
        this.password,
        this.commercialNumber,
        this.commercialImage,
        this.phoneCode,
        this.address});

  Errors.fromJson(Map<String, dynamic> json) {
    name = json['name'] ==null?null : json['name'].cast<String>();
    email = json['email']==null? null : json['email'].cast<String>();
    phone = json['phone']==null? null :json['phone'].cast<String>();
    password = json['password']==null? null :json['password'].cast<String>();
    commercialNumber = json['commercial_number']==null? null :json['commercial_number'].cast<String>();
    commercialImage = json['commercial_image']==null?null : json['commercial_image'].cast<String>();
    phoneCode = json['phone_code']==null? null : json['phone_code'].cast<String>();
    address = json['address']==null? null : json['address'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['commercial_number'] = this.commercialNumber;
    data['commercial_image'] = this.commercialImage;
    data['phone_code'] = this.phoneCode;
    data['address'] = this.address;
    return data;
  }
}