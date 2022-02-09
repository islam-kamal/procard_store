import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';
import 'package:procard_store/Repository/CallUs_Repo/call_us_repo.dart';
class CallUsBloc extends Bloc<AppEvent,AppState> with Validator{
  CallUsBloc(AppState initialState) : super(initialState);

  final name_controller = BehaviorSubject<String>();
  final message_controller = BehaviorSubject<String>();
  final email_controller = BehaviorSubject<String>();

  Function(String) get name_change => name_controller.sink.add;
  Function(String) get message_change  => message_controller.sink.add;
  Function(String) get email_change => email_controller.sink.add;

  Stream<String> get name => name_controller.stream.transform(username_validator);
  Stream<String> get message => message_controller.stream.transform(input_text_validator);
  Stream<String> get email => email_controller.stream.transform(email_validator);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is CallUsEvent){
      yield Loading();
      var response = await callUsRepo.call_us_fun(
        name: name_controller.value,
        message: message_controller.value,
        email: email_controller.value
      );
      if(response.status ==204){
        yield Done(model:response);
      }else{
        yield ErrorLoading(response);
      }
    }
  }
}
CallUsBloc callUsBloc = CallUsBloc(null);