
import 'package:procard_store/Base/api_provider.dart';
import 'package:procard_store/Base/shared_preference_manger.dart';
import 'package:procard_store/Model/Home_Models/latest_card_model.dart';
import 'package:procard_store/Model/Notifications_Model/notifications_model.dart';
import 'package:procard_store/Widgets/error_dialog.dart';
import 'package:procard_store/fileExport.dart';

class NotificationsRepository {

  ApiProvider _apiProvider = ApiProvider();

  Future<List<NotificationsModel>> getNotificationList({BuildContext context}) async {
    final response = await _apiProvider.getWithDio(Urls.GET_ALL_NOTIFICATIONS, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      //  'Authorization': 'Bearer 23|d9x9lJEhQixm19RGpEDCfoYVWvpZbNmTSrCWZa8P'
     'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'

    });
    print("home response : ${response}");
    List<NotificationsModel> ads_list = List<NotificationsModel>();
    if (response['status_code'] == 200) {
      print("1");
      Iterable iterable = response['response']['data'];
      print("iterable : $iterable");
      print("2");
      ads_list = iterable.map((model) => NotificationsModel.fromJson(model)).toList();
      // ads_list = iterable.toList();
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

  void remove_notification({BuildContext context, String notification_id})async{
    print('token : ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}');
    final response = await _apiProvider.postWithDio(
        'https://procard.store/api/notifications/${notification_id}/delete',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
         'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
          //  'Authorization': 'Bearer 23|d9x9lJEhQixm19RGpEDCfoYVWvpZbNmTSrCWZa8P'
        },
       );
    if(response['status_code']==200 || response['status_code']==204){
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=> Notifications()
      ));

    }else{
      errorDialog(
          context:context,
          text:response['response']['message']);
    }
  }

  void remove_All_notification({BuildContext context})async{
    print('token : ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}');
    final response = await _apiProvider.postWithDio(
      Urls.REMOVE_ALL_NOTIFICATIONS_URL,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
        // 'Authorization': 'Bearer 23|d9x9lJEhQixm19RGpEDCfoYVWvpZbNmTSrCWZa8P'
      },
    );
    if(response['status_code']==200 || response['status_code']==204){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context)=> Notifications()
      ));

    }else{
      errorDialog(
          context:context,
          text:response['response']['message']);
    }
  }

  void disable_notification({BuildContext context , String text})async{
    print('token : ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}');
    final response = await _apiProvider.postWithDio(
      'https://procard.store/api/notifications/$text',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
      },
    );
    if( response['status_code']==204){
      errorDialog(
          context:context,
          text:response['response']['message']);

    }else{
      if(text == 'mute'){
        sharedPreferenceManager.writeData(CachingKey.NOTIFICATIONS_STATUS, true);
      }else{
        sharedPreferenceManager.writeData(CachingKey.NOTIFICATIONS_STATUS, false);

      }
      errorDialog(
          context:context,
          text:response['response']['message']);
    }
  }
}

NotificationsRepository notificationsRepository = NotificationsRepository();