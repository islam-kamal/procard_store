import 'package:procard_store/Model/Home_Models/best_seller_model.dart';
import 'package:procard_store/fileExport.dart';

class BestSellerRepo {

  Future<BestSellerModel> get_best_seller_products() async{
    return NetworkUtil.internal().get(
        BestSellerModel(), Urls.BEST_SELLER_URL);
  }

}

BestSellerRepo bestSellerRepo = BestSellerRepo();