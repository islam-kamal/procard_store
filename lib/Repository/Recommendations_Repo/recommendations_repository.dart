import 'package:procard_store/Base/api_provider.dart';
import 'package:procard_store/Model/Recommendations_Model/recommendations_model.dart';
import 'package:procard_store/fileExport.dart';

class RecommendationsRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<List<RecommendationsModel>> getAllRecommenations({BuildContext context}) async {
    final response = await _apiProvider.getWithDio(Urls.RECOMMENDATIONS_URL, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer 23|d9x9lJEhQixm19RGpEDCfoYVWvpZbNmTSrCWZa8P'
    'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'

    });
    print("home response : ${response}");
    List<RecommendationsModel> ads_list = List<RecommendationsModel>();
    if (response['status_code'] == 200) {
      print("1");
      Iterable iterable = response['response']['data'];
      print("iterable : $iterable");
      print("2");
      ads_list = iterable.map((model) => RecommendationsModel.fromJson(model)).toList();
      print("3");

    }
    else if (response['status_code'] == 401) {
      print('there is error');
      /*errorDialog(
        context: context,
          text:'there is error');*/
    }
    print("home ads list : ${ads_list}");
    return ads_list;
  }
}
RecommendationsRepository recommendationsRepository = RecommendationsRepository();