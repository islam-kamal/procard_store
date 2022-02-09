import 'package:dio/dio.dart';
import 'package:procard_store/Base/api_provider.dart';
import 'package:procard_store/Model/CreditCard_Model/credit_card_model.dart';
import 'package:procard_store/Model/Wallet_Model/wallet_model.dart';
import 'package:procard_store/fileExport.dart';

class CreditCardRepository{

  ApiProvider _apiProvider = ApiProvider();

  Future<CreditCardModel> getAllCreditCards({BuildContext context}) async {

    final response = await _apiProvider.getWithDio(Urls.GET_All_CREDIT_CARDS, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer 73|K9cXhSytrOZrE51OOVU76m2jeapvioM7tOk6roMP'
      'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'

    });
    print("CreditCard response : ${response}");
    CreditCardModel ads_list = CreditCardModel();
    if (response['status_code'] == 200) {
      print("1");
    //  Iterable iterable = response['response']['data'];
     // print("iterable : $iterable");
      print("2");
      ads_list = CreditCardModel.fromJson(response['response']);
      print("3");

    }
    else if (response['status_code'] == 401) {
      print('there is error');
    }
    print("CreditCard list : ${ads_list}");
    return ads_list;
  }


   Future<GeneralResponseModel> addCreditCard({String card_name, String card_number, String  expire_date, String cvv})async{
    FormData formData =FormData.fromMap({
      "card_name" : card_name,
      "card_number" : card_number,
      "expire_date" : expire_date,
      "cvv" : cvv
    });
    Map<String, String> headers = {
      //   'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'

    };
    return NetworkUtil.internal().post(GeneralResponseModel(), Urls.ADD_CREDIT_CARD ,body: formData,headers: headers);
  }
}
CreditCardRepository creditCardRepository = CreditCardRepository();