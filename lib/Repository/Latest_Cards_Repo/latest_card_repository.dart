import 'package:procard_store/Model/Home_Models/latest_card_model.dart';
import 'package:procard_store/fileExport.dart';

class LatestCardRepo {

  Future<LatestCardsModel> get_latest_cards() async{
    return NetworkUtil.internal().get(
        LatestCardsModel(), Urls.LATEST_CARDS_URL);
  }

}

LatestCardRepo latestCardRepo = LatestCardRepo();