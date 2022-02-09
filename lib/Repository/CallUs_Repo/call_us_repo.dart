
import 'package:dio/dio.dart';
import 'package:procard_store/fileExport.dart';

class CallUsRepo {
   Future<GeneralResponseModel> call_us_fun({String name, String email , String message})async{
    FormData formData =FormData.fromMap({
      "name" : name,
      "email" : email,
      "message" : message
    });
    Map<String, String> headers = {
      //   'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return NetworkUtil.internal().post(GeneralResponseModel(), Urls.CALL_US ,body: formData,headers: headers);
  }
}

final callUsRepo = CallUsRepo();