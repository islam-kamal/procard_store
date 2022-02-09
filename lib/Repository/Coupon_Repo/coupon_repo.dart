import 'package:procard_store/Base/api_provider.dart';
import 'package:procard_store/Model/Coupon_Model/coupon_model.dart';
import 'package:procard_store/fileExport.dart';

class CouponRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<CouponModel> addCoupon(String value) async {

    final response = await _apiProvider.getWithDio('https://procard.store/api/coupons/check/', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
      'code' : value
    });
    print("coupon ------response : ${response}");
    CouponModel couponModel = CouponModel();
    if (response['status_code'] == 200) {
      return  couponModel.fromJson(response['data']);
    }
    else if (response['status_code'] == 204) {
      return  couponModel.fromJson(response['message'])  ;
    }else {
      print("error");
    }

/*
    return NetworkUtil.internal().get(
        CouponModel(), 'https://procard.store/api/coupons/check/$value');*/
  }
}
CouponRepository couponRepository = CouponRepository();