import 'package:bloc/bloc.dart';
import 'package:procard_store/Model/Home_Models/best_seller_model.dart';
import 'package:procard_store/Model/Home_Models/latest_card_model.dart';
import 'package:procard_store/Repository/Best_Seller_Repo/best_seller_repository.dart';
import 'package:procard_store/Repository/Latest_Cards_Repo/latest_card_repository.dart';
import 'package:procard_store/Repository/Slider_Repo/slider_repository.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class BestSellerBloc extends Bloc<AppEvent,AppState>  {
  BestSellerBloc(AppState initialState) : super(initialState);

  BehaviorSubject<BestSellerModel> _best_seller_subject = new BehaviorSubject<BestSellerModel>();

  get best_seller_subject {
    return _best_seller_subject;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    yield Loading();
    if(event is GetBestSellerEvent){
      final response = await bestSellerRepo.get_best_seller_products();
      print("response : ${response}");
      if(response.status == 200){
        _best_seller_subject.sink.add(response);
        yield Done(indicator: 'best_seller');
      }else{
        yield ErrorLoading(null,indicator: 'best_seller');
      }

    }

  }
}
BestSellerBloc bestSellerBloc = new BestSellerBloc(null);