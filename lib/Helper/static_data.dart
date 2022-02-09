import 'package:flutter/material.dart';
import 'package:procard_store/Model/Card_Details_model/card_details_model.dart';

class StaticData {
  static int TOTAL_AMOUNT = 0;
  static int CART_ITEMS_NUMBER = 0;
  static List CART_IDS;
  static List<CardDetailsModel> cartProductList = [];
  static shoppingCart(CardDetailsModel cartProductDetailsHelper) {
    cartProductList.add(cartProductDetailsHelper);
  }


  static String vistor_value;

  static double get_height(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return height;
  }

  static double get_width(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return width;
  }
}

// StaticData.get_height(context);
