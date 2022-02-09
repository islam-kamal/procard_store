import 'package:bloc/bloc.dart';
import 'package:procard_store/Model/Home_Models/departments_model.dart';
import 'package:procard_store/Model/Home_Models/latest_card_model.dart';
import 'package:procard_store/Model/Settings_Model/settings_model.dart';
import 'package:procard_store/Repository/Departments_Repo/departments_respository.dart';
import 'package:procard_store/Repository/Latest_Cards_Repo/latest_card_repository.dart';
import 'package:procard_store/Repository/SettingsRepo/settings_repository.dart';
import 'package:procard_store/Repository/Slider_Repo/slider_repository.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';
import 'package:procard_store/Model/Settings_Model/social_model.dart';

class SettingsBloc extends Bloc<AppEvent,AppState>  {
  SettingsBloc(AppState initialState) : super(initialState);

  BehaviorSubject<SettingsModel> _settings_subject = new BehaviorSubject<SettingsModel>();

  get settings_subject {
    return _settings_subject;
  }
  BehaviorSubject<SocialModel> _social_subject = new BehaviorSubject<SocialModel>();

  get social_subject {
    return _social_subject;
  }
  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{

    if(event is AppSettingsEvent){
      yield Loading();
      final response = await settingsRepoistory.get_app_settings();
      print("response : ${response}");
      if(response.status  == 200){
        _settings_subject.sink.add(response);
        yield Done();
      }else{
        yield ErrorLoading(null);
      }

    }else if(event is AppSocialEvent){
      yield Loading();
      final response = await settingsRepoistory.get_app_social();
      print("response : ${response}");
      if(response.status  == 200){
        _social_subject.sink.add(response);
        yield Done();
      }else{
        yield ErrorLoading(null);
      }

    }

  }
}
SettingsBloc settingsBloc = new SettingsBloc(null);