class OrdersModel {
  int id;
  String paymentType;
  String totalPrice;
  String status;
  List<Products> products;
  String createdAt;

  OrdersModel(
      {this.id,
        this.paymentType,
        this.totalPrice,
        this.status,
        this.products,
        this.createdAt});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentType = json['payment_type'];
    totalPrice = json['total_price'];
    status = json['status'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_type'] = this.paymentType;
    data['total_price'] = this.totalPrice;
    data['status'] = this.status;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Products {
  String name;
  String price;
  String amountInSr;
  String priceAfterDiscount;
  Country country;
  String logo;

  Products(
      {this.name,
        this.price,
        this.amountInSr,
        this.priceAfterDiscount,
        this.country,
        this.logo});

  Products.fromJson(Map<String, dynamic> json) {
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