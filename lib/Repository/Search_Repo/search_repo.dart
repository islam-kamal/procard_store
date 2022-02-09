import 'package:procard_store/Model/Home_Models/latest_card_model.dart';
import 'package:procard_store/fileExport.dart';

class SearchRepo{
  Future<LatestCardsModel> get_all_cards() async{
    return NetworkUtil.internal().get(
        LatestCardsModel(), Urls.ALL_CARDS_URL);
  }

}
SearchRepo searchRepo = SearchRepo();