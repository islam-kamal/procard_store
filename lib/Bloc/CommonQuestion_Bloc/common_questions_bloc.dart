import 'package:bloc/bloc.dart';
import 'package:procard_store/Model/Common_Questions_Model/common_questions_model.dart';
import 'package:procard_store/Model/Home_Models/departments_model.dart';
import 'package:procard_store/Model/Home_Models/latest_card_model.dart';
import 'package:procard_store/Model/Settings_Model/settings_model.dart';
import 'package:procard_store/Repository/Common_Questions_Repo/common_questions_repository.dart';
import 'package:procard_store/Repository/Departments_Repo/departments_respository.dart';
import 'package:procard_store/Repository/Latest_Cards_Repo/latest_card_repository.dart';
import 'package:procard_store/Repository/SettingsRepo/settings_repository.dart';
import 'package:procard_store/Repository/Slider_Repo/slider_repository.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class CommonQuestionsBloc extends Bloc<AppEvent,AppState>  {
  CommonQuestionsBloc(AppState initialState) : super(initialState);

  BehaviorSubject<CommonQuestionsModel> _common_questions_subject = new BehaviorSubject<CommonQuestionsModel>();

  get common_questions_subject {
    return _common_questions_subject;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    yield Loading();
    if(event is GetCommonQuestionsEvent){
      final response = await commonQuestionsRepoistory.get_CommonQuestions();
      print("response : ${response}");
      if(response.status  == 200){
        _common_questions_subject.sink.add(response);
        yield Done();
      }else{
        yield ErrorLoading(null);
      }

    }

  }
}
CommonQuestionsBloc commonQuestionsBloc = new CommonQuestionsBloc(null);