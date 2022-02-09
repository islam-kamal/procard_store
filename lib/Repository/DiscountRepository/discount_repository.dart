import 'package:procard_store/Model/Discount_Model/discount_model.dart';
import 'package:procard_store/fileExport.dart';

class DiscountRepository {
  Future<DiscountModel> getAllDiscounts() async {
    return NetworkUtil.internal().get(
        DiscountModel(), Urls.DISCOUNT_OFFERS_URL);
  }
}
DiscountRepository discountRepository = DiscountRepository();