import 'package:procard_store/Base/network-mappers.dart';

class WalletModel extends BaseMappable{
  int status;
  String balance;
  List<Operations> operations;

  WalletModel({this.status, this.balance, this.operations});

  WalletModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    balance = json['balance'];
    if (json['operations'] != null) {
      operations = new List<Operations>();
      json['operations'].forEach((v) {
        operations.add(new Operations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['balance'] = this.balance;
    if (this.operations != null) {
      data['operations'] = this.operations.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    balance = json['balance'];
    if (json['operations'] != null) {
      operations = new List<Operations>();
      json['operations'].forEach((v) {
        operations.add(new Operations.fromJson(v));
      });
    }
    return WalletModel(status: status,balance: balance,operations: operations);
  }
}

class Operations {
  String type;
  String amount;
  String date;
  String paymentMethod;

  Operations({this.type, this.amount, this.date, this.paymentMethod});

  Operations.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    amount = json['amount'];
    date = json['date'];
    paymentMethod = json['payment_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['date'] = this.date;
    data['payment_method'] = this.paymentMethod;
    return data;
  }
}