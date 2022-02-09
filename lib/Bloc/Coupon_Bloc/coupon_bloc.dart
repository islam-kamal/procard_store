import 'package:bloc/bloc.dart';
import 'package:procard_store/Model/Bank_Model/bank_model.dart';
import 'package:procard_store/Repository/BankRepo/bank_repository.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';
import 'package:procard_store/Model/Coupon_Model/coupon_model.dart';
import 'package:procard_store/Repository/Coupon_Repo/coupon_repo.dart';
class CouponBloc extends Bloc<AppEvent,AppState>  {
  CouponBloc(AppState initialState) : super(initialState);

  BehaviorSubject<CouponModel> _coupon_subject = new BehaviorSubject<CouponModel>();

  get bank_subject {
    return _coupon_subject;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{

    if(event is AddCouponEvent){
      yield Loading();
      final response = await couponRepository.addCoupon(event.value);
      print("coupon response : ${response}");
      if(response.status  == 200){
        _coupon_subject.sink.add(response);
        yield Done();
      }else{
        yield ErrorLoading(null);
      }

    }

  }
}
CouponBloc couponBloc = new CouponBloc(null);