import 'package:bloc/bloc.dart';
import 'package:procard_store/Base/shared_preference_manger.dart';
import 'package:procard_store/Base/validator.dart';
import 'package:procard_store/Repository/AuthenticationRepo/authentication_repository.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';


class SigninBloc extends Bloc<AppEvent,AppState> with Validator {
  final AuthenticationRepository _authenticationRepository;
    SigninBloc(this._authenticationRepository): super(Start());

    final email_controller = BehaviorSubject<String>();
    final phone_controller = BehaviorSubject<String>();
    final email_password_controller = BehaviorSubject<String>();
  final phone_password_controller = BehaviorSubject<String>();

    Function(String) get email_change => email_controller.sink.add;
    Function(String) get phone_change => phone_controller.sink.add;
    Function(String) get email_password_change => email_password_controller.sink.add;
  Function(String) get phone_password_change => phone_password_controller.sink.add;

    Stream<String> get email => email_controller.stream.transform(email_validator);
    Stream<String> get phone => email_controller.stream.transform(phone_validator);
   Stream<String> get phone_password => phone_password_controller.stream.transform(password_validator);
   Stream<String> get email_password => email_password_controller.stream.transform(password_validator);




  @override
  Stream<AppState> mapEventToState(AppEvent event)async*{
    if(event is click){
      yield Loading(model: null);
      var response;
      if(await sharedPreferenceManager.readString(CachingKey.LOGIN_TYPE) == 'email'){
        response = await AuthenticationRepository.signIn(
            email_controller.value,
            email_password_controller.value);
        if(response.status == 200){
          sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, response.token);
          sharedPreferenceManager.writeData(CachingKey.USER_NAME, response.data.name);
          sharedPreferenceManager.writeData(CachingKey.EMAIL, response.data.email);
          sharedPreferenceManager.writeData(CachingKey.MOBILE_NUMBER, response.data.phone);
          yield Done(model:response);
        }else{
          yield ErrorLoading(response);
        }
      }else{
        response = await AuthenticationRepository.signIn(
            phone_controller.value,
            phone_password_controller.value);
        if(response.status == 200){
          sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, response.token);
          sharedPreferenceManager.writeData(CachingKey.USER_NAME, response.data.name);
          sharedPreferenceManager.writeData(CachingKey.EMAIL, response.data.email);
          sharedPreferenceManager.writeData(CachingKey.MOBILE_NUMBER, response.data.phone);
          yield Done(model:response);
        }else{
          yield ErrorLoading(response);
        }
      }

    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    email_controller?.close();
    phone_controller?.close();
    email_password_controller?.close();
    phone_password_controller?.close();

  }



}
final signIn_bloc = SigninBloc(null);