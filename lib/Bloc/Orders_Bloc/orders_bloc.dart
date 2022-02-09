import 'package:bloc/bloc.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';
import 'package:procard_store/Model/Orders_Model/orders_model.dart';
import 'package:procard_store/Repository/Orders_Repo/orders_repository.dart';
import 'package:procard_store/Model/Orders_Model/order_details_model.dart';
class OrdersBloc extends Bloc<AppEvent,AppState>  {
  OrdersBloc(AppState initialState) : super(initialState);

  BehaviorSubject<List<OrdersModel>> _orders_subject = new BehaviorSubject<List<OrdersModel>>();
  get orders_subject {
    return _orders_subject;
  }
  BehaviorSubject<OrderDetailsModel> _order_details_subject = new BehaviorSubject<OrderDetailsModel>();
  get order_details_subject {
    return _order_details_subject;
  }

  final radio_value = BehaviorSubject<String>();
  BehaviorSubject<String> get radio_choosed_value => radio_value;
  selectRadioValue(String value) {
    radio_value.add(value);
    print("status : ${radio_value}");
  }
  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{

    if(event is GetAllOrdersEvent){
      yield Loading();
      final response = await ordersRepo.getOrdersList();
      print("response : ${response}");
      _orders_subject.sink.add(response);
      print("_orders_subject : ${_orders_subject}");
      yield Done();
    }
    else  if(event is CancelOrderEvent){
      yield Loading();
      final response = await ordersRepo.cancel_order(
         order_id: event.order_id
      );
      if(response.status ==204){
        print("response : ${response}");
        yield Done();
      }else{
        yield ErrorLoading(response);
      }

    }else if(event is OrderDetailsEvent){
      yield Loading();
      final response = await ordersRepo.get_order_details(
        order_id: event.order_id
      );
      if(response.status == 200){
        _order_details_subject.sink.add(response);
        yield Done(model: response);
      }else{
        yield ErrorLoading(response);
      }
    }
  }
}
OrdersBloc ordersBloc = new OrdersBloc(null);