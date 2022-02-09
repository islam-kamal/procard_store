
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:procard_store/Model/FavouriteModel/favourite_model.dart';
import 'package:procard_store/Model/Home_Models/latest_card_model.dart';
import 'package:procard_store/Repository/FavouriteRepo/favourite_repository.dart';
import 'package:procard_store/Repository/Search_Repo/search_repo.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';



class SearchBloc extends Bloc<AppEvent,AppState> with Validator {
  SearchBloc(AppState initialState) : super(initialState);

  final search_controller = BehaviorSubject<String>();
  Function(String) get search_change => search_controller.sink.add;
  Stream<String> get search => search_controller.stream.transform(input_text_validator);



  final BehaviorSubject<LatestCardsModel> _search_subject = BehaviorSubject<LatestCardsModel>();

  @override
  void drainStream() {
    _search_subject.value = null;
  }

  @override
  get search_subject {
    return _search_subject;
  }

  @override
  void dispose() async{
    await _search_subject.drain();
    _search_subject.close();
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{

    if(event is SearchEvent){
      yield Loading();
      var response =await searchRepo.get_all_cards();
      print("search response : ${response}");
      if(response.status ==200){
        _search_subject.sink.add(response);
        yield  Done();
      }else{
        yield ErrorLoading(response);
      }


    }
  }


}
final search_bloc = SearchBloc(null);
