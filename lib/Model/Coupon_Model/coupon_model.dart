import 'package:procard_store/Base/network-mappers.dart';

class CouponModel extends BaseMappable{
  int status;
  Data data;
  String message;
  CouponModel({this.status, this.data,this.message});

  CouponModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(status == 204){
      message = json['message'];
      return CouponModel(status: status,message: message);
    }else{

      data = json['data'] != null ? new Data.fromJson(json['data']) : null;
      return CouponModel(status: status,data: data);
    }
  }
}

class Data {
  int id;
  String code;
  int percent;
  String validUntil;

  Data({this.id, this.code, this.percent, this.validUntil});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    percent = json['percent'];
    validUntil = json['valid_until'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['percent'] = this.percent;
    data['valid_until'] = this.validUntil;
    return data;
  }
}