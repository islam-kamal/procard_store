import 'package:bloc/bloc.dart';
import 'package:procard_store/Model/Discount_Model/discount_model.dart';
import 'package:procard_store/Model/Notifications_Model/notifications_model.dart';
import 'package:procard_store/Repository/DiscountRepository/discount_repository.dart';
import 'package:procard_store/Repository/NotificationsRepo/notifications_repository.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class NotificationsBloc extends Bloc<AppEvent,AppState>  {
  NotificationsBloc(AppState initialState) : super(initialState);

  BehaviorSubject<List<NotificationsModel>> _notifications_subject = new BehaviorSubject<List<NotificationsModel>>();

  get notifications_subject {
    return _notifications_subject;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    yield Loading();
    if(event is GetAllNotificationsEvent){
      final response = await notificationsRepository.getNotificationList();
      print("response : ${response}");
        _notifications_subject.sink.add(response);
        print("_notifications_subject : ${_notifications_subject}");
        yield Done();
    }

  }
}
NotificationsBloc notificationsBloc = new NotificationsBloc(null);