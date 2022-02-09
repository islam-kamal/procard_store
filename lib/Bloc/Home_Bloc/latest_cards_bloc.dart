import 'package:bloc/bloc.dart';
import 'package:procard_store/Model/Home_Models/latest_card_model.dart';
import 'package:procard_store/Repository/Latest_Cards_Repo/latest_card_repository.dart';
import 'package:procard_store/Repository/Slider_Repo/slider_repository.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class LatestCardsBloc extends Bloc<AppEvent,AppState>  {
  LatestCardsBloc(AppState initialState) : super(initialState);

  BehaviorSubject<LatestCardsModel> _latest_cards_subject = new BehaviorSubject<LatestCardsModel>();

  get latest_cards_subject {
    return _latest_cards_subject;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    yield Loading();
    if(event is GetLatestCardsEvent){
      final response = await latestCardRepo.get_latest_cards();
      print("response : ${response}");
      if(response.status == 200){
        _latest_cards_subject.sink.add(response);
        yield Done(indicator: 'latest_cards');
      }else{
        yield ErrorLoading(null,indicator: 'latest_cards');
      }

    }

  }
}
LatestCardsBloc latestCardsBloc = new LatestCardsBloc(null);