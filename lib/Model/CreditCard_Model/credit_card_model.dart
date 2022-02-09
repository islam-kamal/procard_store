import 'package:procard_store/Base/network-mappers.dart';

class CreditCardModel extends BaseMappable{
  int status;
  List<Data> data;

  CreditCardModel({this.status, this.data});

  CreditCardModel.fromJson(Map<String, dynamic> json) {
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
    return CreditCardModel(status: status,data: data);
  }
}

class Data {
  int id;
  String cardOwner;
  String cardNumber;
  String expireDate;
  String createdAt;
  String createdAtFormated;
  String image;

  Data(
      {this.id,
        this.cardOwner,
        this.cardNumber,
        this.expireDate,
        this.createdAt,
        this.createdAtFormated,
        this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardOwner = json['card_owner'];
    cardNumber = json['card_number'];
    expireDate = json['expire_date'];
    createdAt = json['created_at'];
    createdAtFormated = json['created_at_formated'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['card_owner'] = this.cardOwner;
    data['card_number'] = this.cardNumber;
    data['expire_date'] = this.expireDate;
    data['created_at'] = this.createdAt;
    data['created_at_formated'] = this.createdAtFormated;
    data['image'] = this.image;
    return data;
  }
}