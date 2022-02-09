
import 'package:bloc/bloc.dart';
import 'package:procard_store/Model/Discount_Model/discount_model.dart';
import 'package:procard_store/Model/Notifications_Model/notifications_model.dart';
import 'package:procard_store/Model/Recommendations_Model/recommendations_model.dart';
import 'package:procard_store/Repository/DiscountRepository/discount_repository.dart';
import 'package:procard_store/Repository/NotificationsRepo/notifications_repository.dart';
import 'package:procard_store/Repository/Recommendations_Repo/recommendations_repository.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class RecommendationsBloc extends Bloc<AppEvent,AppState>  {
  RecommendationsBloc(AppState initialState) : super(initialState);

  BehaviorSubject<List<RecommendationsModel>> _recommendation_subject = new BehaviorSubject<List<RecommendationsModel>>();

  get recommendation_subject {
    return _recommendation_subject;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    yield Loading();
    if(event is GetAllRecommendationsEvent){
      final response = await recommendationsRepository.getAllRecommenations();
      print("response : ${response}");
      _recommendation_subject.sink.add(response);
      print("_notifications_subject : ${_recommendation_subject}");
      yield Done();
    }

  }
}
RecommendationsBloc recommendationsBloc = new RecommendationsBloc(null);