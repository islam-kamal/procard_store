import 'package:bloc/bloc.dart';
import 'package:procard_store/Model/Discount_Model/discount_model.dart';
import 'package:procard_store/Repository/DiscountRepository/discount_repository.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class DiscountBloc extends Bloc<AppEvent,AppState>  {
  DiscountBloc(AppState initialState) : super(initialState);

  BehaviorSubject<DiscountModel> _discount_subject = new BehaviorSubject<DiscountModel>();

  get discount_subject {
    return _discount_subject;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    yield Loading();
    if(event is GetAllDiscountsEvent){
      final response = await discountRepository.getAllDiscounts();
      print("response : ${response}");
      if(response.status  == 200){
        _discount_subject.sink.add(response);
        yield Done();
      }else{
        yield ErrorLoading(null);
      }

    }

  }
}
DiscountBloc discountBloc = new DiscountBloc(null);