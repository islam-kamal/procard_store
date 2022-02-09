import 'package:dio/dio.dart';
import 'package:procard_store/Base/network-mappers.dart';
import 'package:procard_store/Base/shared_preference_manger.dart';
import 'package:procard_store/Helper/urls.dart';

class NetworkUtil {
  static final NetworkUtil _instance = new NetworkUtil.internal();
SharedPreferenceManager sharedPreferenceManager =SharedPreferenceManager();
  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  Dio dio = Dio();

  Future<ResponseType> get <ResponseType extends Mappable>(ResponseType responseType, String url,
      {Map headers}) async {
    print("headers : ${headers}");
    var response;
    try {
      response = await dio.get(url,queryParameters:headers);
      print('res : ${response}');
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
      }
    }
    return handleResponse(response, responseType);
  }

  Future<ResponseType> post<ResponseType extends Mappable>(ResponseType responseType, String url,
      {Map headers, FormData body, encoding}) async {

    var response;
    dio.options.baseUrl = Urls.BASE_URL;

    try {
      print(headers);
      print(body.fields);
      print(body.files);
      print('3');
      response = await dio.post(url,
          data: body,
          options: Options(headers: headers, requestEncoder: encoding ,
              followRedirects: false,  validateStatus: (status) { return status < 500; }));

      print("response card : $response");

    } on DioError catch (e) {
      if (e.response != null) {
        print('5');
        response = e.response;
      }
    }
    return handleResponse(response, responseType);

  }

  Future<ResponseType> delete<ResponseType extends Mappable>(ResponseType responseType, String url,
      {Map headers, FormData body, encoding}) async {

    var response;
    dio.options.baseUrl = Urls.BASE_URL;

    try {
      print(headers);
      print('delete url : $url');
      response = await dio.delete(url,
          data: body,
          options: Options(headers: headers, requestEncoder: encoding ,
              followRedirects: false,  validateStatus: (status) { return status < 500; }));

      print("delete response  : $response");

    } on DioError catch (e) {
      if (e.response != null) {
        print('5');
        response = e.response;
      }
    }
    return handleResponse(response, responseType);

  }

  ResponseType handleResponse<ResponseType extends Mappable>(Response response, ResponseType responseType) {
    print("res : ${response}");
    final int statusCode = response.statusCode;
    print("Status Code " + statusCode.toString());
    if (statusCode >= 200 && statusCode < 300) {
      print("correrct request: " + response.toString());
      print("Status Code " + statusCode.toString());
      print("11111");
      return Mappable(responseType, response.toString()) as ResponseType;
    } else {
      print("request error: " + response.toString());
      print("Status Code " + statusCode.toString());
      return Mappable(responseType, response.toString()) as ResponseType;
    }
  }
}
