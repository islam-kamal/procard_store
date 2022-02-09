
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:procard_store/Model/FavouriteModel/favourite_model.dart';
import 'package:procard_store/Repository/FavouriteRepo/favourite_repository.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';



class FavouriteBloc extends Bloc<AppEvent,AppState>  {

  final BehaviorSubject<List<FavouriteModel>> _fav_subject = BehaviorSubject<List<FavouriteModel>>();

  FavouriteBloc(AppState initialState) : super(initialState);

  @override
  void drainStream() {
    _fav_subject.value = null;
  }

  @override
  get fav_subject {
    return _fav_subject;
  }

  @override
  void dispose() async{
    await _fav_subject.drain();
    _fav_subject.close();
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    yield Loading();
  /*  if(event is AddFavouriteEvent){
      print('event.card_id : ${event.card_id}');
      var response = await favouriteRepository.addProudctToFavourite(
        card_id: event.card_id,
      );
      print('event.response : ${response}');
      if(response.data != null){
        yield Done(model: response);
      }else{
        yield  ErrorLoading(response);
      }
    }
    else if(event is RemoveFavouriteEvent){
      yield Loading();
      var response = await favouriteRepository.removeProudctFromFavourite(
        card_id: event.card_id,
      );
      if(response != null){
        yield  Done(model: response);
      }else{
        yield   ErrorLoading(response);
      }
    }*/

     if(event is GetAllFavouriteEvent){
      yield Loading();
      var response =await favouriteRepository.getAllFavourite();
      print("fav response : ${response}");
        _fav_subject.sink.add(response);
        yield  Done();

    }
  }


}
final favourite_bloc = FavouriteBloc(null);
