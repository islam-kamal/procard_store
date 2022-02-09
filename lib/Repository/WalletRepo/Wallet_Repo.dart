import 'package:dio/dio.dart';
import 'package:procard_store/Base/api_provider.dart';
import 'package:procard_store/Model/Wallet_Model/wallet_model.dart';
import 'package:procard_store/fileExport.dart';

class WalletRepository{
  ApiProvider _apiProvider = ApiProvider();

  Future<WalletModel> get_wallet_history() async{
    final response = await _apiProvider.getWithDio(Urls.GET_WALLET_HISTORY, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
    //  'Authorization': 'Bearer 73|K9cXhSytrOZrE51OOVU76m2jeapvioM7tOk6roMP'
    });
    print("home ------response : ${response}");
    WalletModel walletModel = WalletModel();
    if (response['status_code'] == 200) {
      return  walletModel.fromJson(response['response'])  ;
    }
    else if (response['status_code'] == 401) {
    print('there is error');
    }
  }



   Future<GeneralResponseModel> recharge_wallet_bank_transfer({String bank_name, String account_owner, String iban, String account_number,
       String amount})async{
    FormData formData =FormData.fromMap({
      "bank_name" : bank_name,
      "account_owner" : account_owner,
      "iban" : iban,
      "account_number" : account_number,
      "amount" : amount,
      "reason" : '0'

    });
    Map<String, String> headers = {
      //   'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'

    };
    return NetworkUtil.internal().post(GeneralResponseModel(), Urls.RECHARGE_WALLET_BANK_TRANSFER,body: formData,headers: headers);
  }
}



WalletRepository walletRepository = WalletRepository();