import 'package:procard_store/Base/network-mappers.dart';

class GeneralResponseModel extends BaseMappable{
  int status;
  String message;

  GeneralResponseModel({this.status, this.message});

  GeneralResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    return GeneralResponseModel(status: status,message: message);
  }
}