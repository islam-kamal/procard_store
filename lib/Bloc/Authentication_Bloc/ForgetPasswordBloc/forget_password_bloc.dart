

import 'package:bloc/bloc.dart';
import 'package:procard_store/Base/shared_preference_manger.dart';
import 'package:procard_store/Base/validator.dart';
import 'package:procard_store/Repository/AuthenticationRepo/authentication_repository.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';


abstract class BaseBloc{
  void dispose(){
  }
}

class ForgetPasswordBloc extends Bloc<AppEvent,AppState> with Validator implements BaseBloc{
  final AuthenticationRepository _authenticationRepository;
  ForgetPasswordBloc(this._authenticationRepository):super(Start());
  SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  final username_controller = BehaviorSubject<String>();
  Function(String) get username_change => username_controller.sink.add;
  Stream<String> get username => username_controller.stream.transform(email_validator);

  final code_controller = BehaviorSubject<String>();
  Function(String) get code_change => code_controller.sink.add;
  Stream<String> get code => code_controller.stream.transform(code_validator);

  final password_controller = BehaviorSubject<String>();
  Function(String) get password_change =>password_controller.sink.add;
  Stream<String> get password =>password_controller.stream.transform(password_validator);

  final confirm_password_controller = BehaviorSubject<String>();
  Function(String) get confirm_password_change =>confirm_password_controller.sink.add;
  Stream<String> get confirm_password =>confirm_password_controller.stream.transform(password_validator);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    String user_name;
    //send otp Api handle
    if( event is sendOtpClick){
      yield Loading(model: null);
      print(username_controller.value);
      var response = await AuthenticationRepository.sendVerificationCode(username_controller.value);
      if(response.status == 204){
        sharedPreferenceManager.writeData(CachingKey.FORGET_PASSWORD_EMAIL, username_controller.value);
        yield Done(model:response);
      }else{
        yield ErrorLoading(response);
      }
    }
    //check otp Api handle
    else if(event is checkOtpClick){
      yield Loading(model: null,indicator: 'checkOtpClick');
      await sharedPreferenceManager.readString(CachingKey.FORGET_PASSWORD_EMAIL).then((value) => user_name = value);
      var response= await AuthenticationRepository.checkOtpCode(user_name, code_controller.value);
      if(response.status == 200){
        yield Done(model:response, indicator:'checkOtpClick' );
        sharedPreferenceManager.writeData(CachingKey.VERIFCATION_TOKEN, response.resetToken);
      }else{
        yield ErrorLoading(response);
      }
    }
    else if( event is changePasswordClick){
      var token;
      yield Loading(model: null);
      print('password : ${password_controller.value}');
      print('confirm_password : ${confirm_password_controller.value}');
      await sharedPreferenceManager.readString(CachingKey.VERIFCATION_TOKEN).then((value) => token = value);
      var response = await AuthenticationRepository.reset_Password(
          token,
          password_controller.value ,
          confirm_password_controller.value);
      if(response.status == 200){
        yield  Done(model: response);
      }else{
        yield ErrorLoading(response);
      }
    }

  }
  @override
  void dispose() {
    username_controller?.close();
    code_controller?.close();
  }
}
final forgetPassword_bloc = new ForgetPasswordBloc(null);