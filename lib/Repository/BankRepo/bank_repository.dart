import 'package:procard_store/Model/Bank_Model/bank_model.dart';
import 'package:procard_store/fileExport.dart';

class BankRepo {

  Future<BankModel> getAllBanks() async{
    return NetworkUtil.internal().get(
        BankModel(), Urls.BANK_URL);
  }

}

BankRepo bankRepo = BankRepo();