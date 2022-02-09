import 'package:procard_store/Base/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:procard_store/Model/Profile_Model/profile_staistics_model.dart';
import 'package:procard_store/fileExport.dart';
class ProfileRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<ProfileStaisticsModel> getProfileStaistics() async {
    final response = await _apiProvider.getWithDio(Urls.PROFILE_STAISTICS_URL, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
   // 'Authorization': 'Bearer 73|K9cXhSytrOZrE51OOVU76m2jeapvioM7tOk6roMP'
    });
    print("home response : ${response}");
    ProfileStaisticsModel staticts = ProfileStaisticsModel();
    if (response['status_code'] == 200) {
      return  staticts.fromJson(response['response'])  ;

    }
    else if (response['status_code'] == 401) {
      print("there is error");
    }
  }
}
ProfileRepository profileRepository =ProfileRepository();