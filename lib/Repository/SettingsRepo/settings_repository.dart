import 'package:procard_store/Model/Home_Models/departments_model.dart';
import 'package:procard_store/Model/Home_Models/latest_card_model.dart';
import 'package:procard_store/Model/Settings_Model/settings_model.dart';
import 'package:procard_store/Model/Settings_Model/social_model.dart';
import 'package:procard_store/fileExport.dart';

class SettingsRepoistory {

  Future<SettingsModel> get_app_settings() async{
    return NetworkUtil.internal().get(
        SettingsModel(), Urls.APP_SETTINGS_URL);
  }

  Future<SocialModel> get_app_social() async{
    return NetworkUtil.internal().get(
        SocialModel(), Urls.App_SOCIAL);
  }
}

SettingsRepoistory settingsRepoistory = SettingsRepoistory();