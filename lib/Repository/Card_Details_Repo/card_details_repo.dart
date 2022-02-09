import 'package:procard_store/fileExport.dart';
import 'package:procard_store/Model/Card_Details_model/card_details_model.dart';
import 'package:procard_store/Model/Card_Details_model/countries_model.dart';
class CardDetailsRepo {

  Future<CardDetailsModel> get_card_details(int card_id) async{
    return NetworkUtil.internal().get(
        CardDetailsModel(), Urls.CARD_DETAILS_URL+ card_id.toString());
  }
  Future<CountriesModel> get_all_countries() async{
    return NetworkUtil.internal().get(
        CountriesModel(), Urls.COUNTRIES);
  }
}

CardDetailsRepo cardDetailsRepo = CardDetailsRepo();