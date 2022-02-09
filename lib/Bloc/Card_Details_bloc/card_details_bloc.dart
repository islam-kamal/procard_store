import 'package:bloc/bloc.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';
import 'package:procard_store/Repository/Card_Details_Repo/card_details_repo.dart';
import 'package:procard_store/Model/Card_Details_model/card_details_model.dart';
import 'package:procard_store/Model/Card_Details_model/countries_model.dart';
class CardDetailsBloc extends Bloc<AppEvent,AppState>  {
  CardDetailsBloc(AppState initialState) : super(initialState);

  BehaviorSubject<CardDetailsModel> _card_details_subject = new BehaviorSubject<CardDetailsModel>();

  get card_details_subject {
    return _card_details_subject;
  }
  BehaviorSubject<CountriesModel> _countries_subject = new BehaviorSubject<CountriesModel>();

  get countries_subject {
    return _countries_subject;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is GetCardDetailsEvent){
      yield Loading();
      final response = await cardDetailsRepo.get_card_details(event.card_id);
      print("card details response : ${response}");
      if(response.status == 200){
        _card_details_subject.sink.add(response);
        yield Done(model: response);
      }else{
        yield ErrorLoading(response);
      }

    }else if(event is GetCountriesEvent){
      yield Loading();
      final response = await cardDetailsRepo.get_all_countries();
      print("card details response : ${response}");
      if(response.status == 200){
        _countries_subject.sink.add(response);
        yield Done(model: response,indicator: 'countries');
      }else{
        yield ErrorLoading(response,indicator: 'countries');
      }

    }

  }
}
CardDetailsBloc cardDetailsBloc = new CardDetailsBloc(null);