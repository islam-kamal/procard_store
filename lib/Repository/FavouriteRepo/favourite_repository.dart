import 'package:dio/dio.dart';
import 'package:procard_store/Base/api_provider.dart';
import 'package:procard_store/Base/network_util.dart';
import 'package:procard_store/Base/shared_preference_manger.dart';
import 'package:procard_store/Model/FavouriteModel/favourite_model.dart';
import 'package:procard_store/fileExport.dart';

class FavouriteRepository {
  ApiProvider _apiProvider = ApiProvider();

 /* Future<FavouriteModel> getAllFavourite()async{
    print("fav 1");
    var token = await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    Map<String, String> headers = {
      'token' : '21|Y7r1hGJRPLyNJbPYn10sw9fxIobznNpp4gDJKhd2',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    print("fav 2");
    return NetworkUtil.internal().get(
        FavouriteModel(), Urls.GET_ALL_FAVOURITES,
        headers: headers);
  }*/


  Future<List<FavouriteModel>> getAllFavourite({BuildContext context}) async {
    final response = await _apiProvider.getWithDio(Urls.GET_ALL_FAVOURITES, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
     // 'Authorization': 'Bearer 23|d9x9lJEhQixm19RGpEDCfoYVWvpZbNmTSrCWZa8P'
       'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'

    });
    print("home response : ${response}");
    List<FavouriteModel> ads_list = List<FavouriteModel>();
    if (response['status_code'] == 200) {
      print("1");
      Iterable iterable = response['response']['data'];
      print("iterable : $iterable");
      print("2");
      ads_list = iterable.map((model) => FavouriteModel.fromJson(model)).toList();
      // ads_list = iterable.toList();
      print("3");
      print("fav----ads_list : ${ads_list}");

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



/*
  Future<FavouriteModel> addProudctToFavourite({int card_id })async {
    var token = await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    FormData formData = FormData.fromMap({
      'token': token,
    });
    return NetworkUtil.internal().post(
        FavouriteModel(),'https://procard.store/api/cards/${card_id}/favorites', body: formData);
  }

  Future<FavouriteModel> removeProudctFromFavourite({int card_id,})async{
    var token = await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    FormData formData =FormData.fromMap({
      'token' : token,
    });
    return NetworkUtil.internal().post(FavouriteModel(),'/api/cards/${card_id}/favorites',body: formData);

  }*/
}
final FavouriteRepository favouriteRepository = FavouriteRepository();
