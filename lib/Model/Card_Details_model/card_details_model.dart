import 'package:procard_store/Base/network-mappers.dart';


class CardDetailsModel extends BaseMappable{
  int status;
  Data data;

  CardDetailsModel({this.status, this.data});

  CardDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    return CardDetailsModel(status: status,data: data);
  }
}

class Data {
  var id;
  var name;
  var description;
  var charge;
  var logo;
  var createdAt;
  var createdAtFormated;
  List<Types> types;
  var isFavorited;
  var leastPrice;
  var code;
  var section;

  Data(
      {this.id,
        this.name,
        this.description,
        this.charge,
        this.logo,
        this.createdAt,
        this.createdAtFormated,
        this.types,
        this.isFavorited,
        this.leastPrice,
        this.code,
        this.section});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    charge = json['charge'];
    logo = json['logo'];
    createdAt = json['created_at'];
    createdAtFormated = json['created_at_formated'];
    if (json['types'] != null) {
      types = new List<Types>();
      json['types'].forEach((v) {
        types.add(new Types.fromJson(v));
      });
    }
    isFavorited = json['is_favorited'];
    leastPrice = json['least_price'];
    code = json['code'];
    section = json['section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['charge'] = this.charge;
    data['logo'] = this.logo;
    data['created_at'] = this.createdAt;
    data['created_at_formated'] = this.createdAtFormated;
    if (this.types != null) {
      data['types'] = this.types.map((v) => v.toJson()).toList();
    }
    data['is_favorited'] = this.isFavorited;
    data['least_price'] = this.leastPrice;
    data['code'] = this.code;
    data['section'] = this.section;
    return data;
  }
}

class Types {
  var id;
  var price;
  var amountInSr;
  var priceAfterDiscount;
  var quantity;
  Country country;
  var cardId;

  Types(
      {this.id,
        this.price,
        this.amountInSr,
        this.priceAfterDiscount,
        this.quantity,
        this.country,
        this.cardId});

  Types.fromJson(Map<String, dynamic> json) {
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

class Country {
  var id;
  var name;
  var code;
  var key;
  var currency;
  var flag;

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