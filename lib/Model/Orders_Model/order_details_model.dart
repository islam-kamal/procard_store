import 'package:procard_store/Base/network-mappers.dart';

class OrderDetailsModel extends BaseMappable{
  int status;
  List<Data> data;

  OrderDetailsModel({this.status, this.data});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
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
    return OrderDetailsModel(status: status,data: data);
  }
}

class Data {
  String validUntil;
  String code;
  String serial;
  String status;
  Product product;
  Type type;

  Data(
      {this.validUntil,
        this.code,
        this.serial,
        this.status,
        this.product,
        this.type});

  Data.fromJson(Map<String, dynamic> json) {
    validUntil = json['valid_until'];
    code = json['code'];
    serial = json['serial'];
    status = json['status'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['valid_until'] = this.validUntil;
    data['code'] = this.code;
    data['serial'] = this.serial;
    data['status'] = this.status;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    return data;
  }
}

class Product {
  String name;
  String price;
  String amountInSr;
  String priceAfterDiscount;
  Country country;
  String logo;

  Product(
      {this.name,
        this.price,
        this.amountInSr,
        this.priceAfterDiscount,
        this.country,
        this.logo});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    amountInSr = json['amount_in_sr'];
    priceAfterDiscount = json['price_after_discount'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['amount_in_sr'] = this.amountInSr;
    data['price_after_discount'] = this.priceAfterDiscount;
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    data['logo'] = this.logo;
    return data;
  }
}

class Country {
  int id;
  String name;
  String code;
  String key;
  String currency;
  String flag;

  Country({this.id, this.name, this.code, this.key, this.currency, this.flag});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    key = json['key'];
    currency = json['currency'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['key'] = this.key;
    data['currency'] = this.currency;
    data['flag'] = this.flag;
    return data;
  }
}

class Type {
  int id;
  String price;
  String amountInSr;
  String priceAfterDiscount;
  int quantity;
  Country country;
  int cardId;

  Type(
      {this.id,
        this.price,
        this.amountInSr,
        this.priceAfterDiscount,
        this.quantity,
        this.country,
        this.cardId});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    amountInSr = json['amount_in_sr'];
    priceAfterDiscount = json['price_after_discount'];
    quantity = json['quantity'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    cardId = json['card_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['amount_in_sr'] = this.amountInSr;
    data['price_after_discount'] = this.priceAfterDiscount;
    data['quantity'] = this.quantity;
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    data['card_id'] = this.cardId;
    return data;
  }
}