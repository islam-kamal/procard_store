import 'package:procard_store/Base/network-mappers.dart';

class ProfileStaisticsModel extends BaseMappable {
  int status;
  Data data;

  ProfileStaisticsModel({this.status, this.data});

/*  ProfileStaisticsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }*/

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String,dynamic > json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    return ProfileStaisticsModel(status: status,data: data);
  }
}

class Data {
  String walletBallance;
  int offersCount;
  int totalProducts;
  int totalPayments;
  int succesfullOrders;
  String averageOrder;

  Data(
      {this.walletBallance,
        this.offersCount,
        this.totalProducts,
        this.totalPayments,
        this.succesfullOrders,
        this.averageOrder});

  Data.fromJson(Map<String, dynamic> json) {
    walletBallance = json['wallet_ballance'];
    offersCount = json['offers_count'];
    totalProducts = json['total_products'];
    totalPayments = json['total_payments'];
    succesfullOrders = json['succesfull_orders'];
    averageOrder = json['average_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet_ballance'] = this.walletBallance;
    data['offers_count'] = this.offersCount;
    data['total_products'] = this.totalProducts;
    data['total_payments'] = this.totalPayments;
    data['succesfull_orders'] = this.succesfullOrders;
    data['average_order'] = this.averageOrder;
    return data;
  }
}