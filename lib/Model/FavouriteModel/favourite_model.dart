
import 'package:procard_store/Base/network-mappers.dart';
/*


class FavouriteModel extends BaseMappable{
  int status;
  List<Data> data;

  FavouriteModel({this.status, this.data});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
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
    return FavouriteModel(status: status,data: data);
  }
}

class Data {
  Card card;
  var createdAt;
  var createdAtFormated;

  Data({this.card, this.createdAt, this.createdAtFormated});

  Data.fromJson(Map<String, dynamic> json) {
    card = json['card'] != null ? new Card.fromJson(json['card']) : null;
    createdAt = json['created_at'];
    createdAtFormated = json['created_at_formated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.card != null) {
      data['card'] = this.card.toJson();
    }
    data['created_at'] = this.createdAt;
    data['created_at_formated'] = this.createdAtFormated;
    return data;
  }
}

class Card {
  var id;
  var name;
  var description;
  var charge;
  var logo;
  var createdAt;
  var createdAtFormated;
  List<Types> types;
  bool isFavorited;
  var leastPrice;

  Card(
      {this.id,
        this.name,
        this.description,
        this.charge,
        this.logo,
        this.createdAt,
        this.createdAtFormated,
        this.types,
        this.isFavorited,
        this.leastPrice});

  Card.fromJson(Map<String, dynamic> json) {
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
}*/

class FavouriteModel {
  Card card;
  String createdAt;
  String createdAtFormated;

  FavouriteModel({this.card, this.createdAt, this.createdAtFormated});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    card = json['card'] != null ? new Card.fromJson(json['card']) : null;
    createdAt = json['created_at'];
    createdAtFormated = json['created_at_formated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.card != null) {
      data['card'] = this.card.toJson();
    }
    data['created_at'] = this.createdAt;
    data['created_at_formated'] = this.createdAtFormated;
    return data;
  }
}

class Card {
  int id;
  String name;
  String description;
  String charge;
  String logo;
  String createdAt;
  String createdAtFormated;
  List<Types> types;
  bool isFavorited;
  String leastPrice;

  Card(
      {this.id,
        this.name,
        this.description,
        this.charge,
        this.logo,
        this.createdAt,
        this.createdAtFormated,
        this.types,
        this.isFavorited,
        this.leastPrice});

  Card.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Types {
  int id;
  String price;
  String amountInSr;
  String priceAfterDiscount;
  int quantity;
  Country country;
  int cardId;

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