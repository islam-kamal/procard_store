import 'package:procard_store/Model/Common_Questions_Model/common_questions_model.dart';
import 'package:procard_store/Model/Home_Models/departments_model.dart';
import 'package:procard_store/Model/Home_Models/latest_card_model.dart';
import 'package:procard_store/Model/Settings_Model/settings_model.dart';
import 'package:procard_store/fileExport.dart';

class CommonQuestionsRepoistory {

  Future<CommonQuestionsModel> get_CommonQuestions() async{
    return NetworkUtil.internal().get(
        CommonQuestionsModel(), Urls.COMMON_QUESTIONS);
  }

}

CommonQuestionsRepoistory commonQuestionsRepoistory = CommonQuestionsRepoistory();