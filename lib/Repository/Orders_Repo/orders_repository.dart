import 'package:dio/dio.dart';
import 'package:procard_store/Base/api_provider.dart';
import 'package:procard_store/fileExport.dart';
import 'package:procard_store/Model/Orders_Model/orders_model.dart';
import 'package:procard_store/Model/Orders_Model/order_details_model.dart';
class OrdersRepo {

  ApiProvider _apiProvider = ApiProvider();

  Future<List<OrdersModel>> getOrdersList({BuildContext context}) async {
    final response = await _apiProvider.getWithDio(Urls.GET_ALL_ORDERS, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'

    });
    print("orders response : ${response}");
    List<OrdersModel> orders_list = [];
    if (response['status_code'] == 200) {
      print("1");
      Iterable iterable = response['response']['data'];
      print("iterable : $iterable");
      print("2");
      orders_list = iterable.map((model) => OrdersModel.fromJson(model)).toList();
      // ads_list = iterable.toList();
      print("3");

    }
    else if (response['status_code'] == 401) {
      print('there is error');
      /*errorDialog(
        context: context,
          text:'there is error');*/
    }
    print("orders : ${orders_list}");
    return orders_list;
  }

  Future<GeneralResponseModel> cancel_order({int order_id})async{

    Map<String, String> headers = {
      //   'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'

    };
    return NetworkUtil.internal().delete(GeneralResponseModel(), Urls.CANCEL_ORDER +'${order_id}',headers: headers);
  }

  Future<OrderDetailsModel> get_order_details({int order_id}) async {
/*    Map<String,String> headers = {
  //  'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'

    };
    return NetworkUtil.internal().get(
        OrderDetailsModel(), Urls.ORDER_DETAILS + order_id.toString(),headers: headers);*/

    final response = await _apiProvider.getWithDio( Urls.ORDER_DETAILS + order_id.toString(), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'

    });
    OrderDetailsModel order;
    print("orders response : ${response}");
    if (response['status_code'] == 200) {
       order =  OrderDetailsModel.fromJson(response['response']);

    }
    else if (response['status_code'] == 401) {
      print('there is error');
      /*errorDialog(
        context: context,
          text:'there is error');*/
    }
    return order;
  }
}

OrdersRepo ordersRepo = OrdersRepo();