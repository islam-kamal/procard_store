import 'package:procard_store/Model/Home_Models/departments_model.dart';
import 'package:procard_store/Model/Home_Models/latest_card_model.dart';
import 'package:procard_store/fileExport.dart';

class DepartmentsRepo {

  Future<DepartmentsModel> get_all_departments() async{
    return NetworkUtil.internal().get(
        DepartmentsModel(), Urls.DEPARTMENTS_URL);
  }

}

DepartmentsRepo departmentsRepo = DepartmentsRepo();