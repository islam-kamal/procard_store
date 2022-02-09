import 'package:procard_store/Base/network-mappers.dart';


class BankModel extends BaseMappable{
  int status;
  List<Data> data;

  BankModel({this.status, this.data});

  BankModel.fromJson(Map<String, dynamic> json) {
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
    return BankModel(status: status,data: data);
  }
}

class Data {
  int id;
  String title;
  String accountNumber;
  String accountOwner;
  String iban;
  String logo;

  Data(
      {this.id,
        this.title,
        this.accountNumber,
        this.accountOwner,
        this.iban,
        this.logo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    accountNumber = json['account_number'];
    accountOwner = json['account_owner'];
    iban = json['iban'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['account_number'] = this.accountNumber;
    data['account_owner'] = this.accountOwner;
    data['iban'] = this.iban;
    data['logo'] = this.logo;
    return data;
  }
}