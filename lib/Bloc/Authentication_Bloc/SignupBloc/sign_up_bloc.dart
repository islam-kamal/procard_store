import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:procard_store/Base/shared_preference_manger.dart';
import 'package:procard_store/Base/validator.dart';
import 'package:procard_store/Repository/AuthenticationRepo/authentication_repository.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc extends Bloc<AppEvent,AppState> with Validator{
  final AuthenticationRepository _authenticationRepository;
  SignUpBloc(this._authenticationRepository) : super(Start());

  final name_controller = BehaviorSubject<String>();
  final phone_controller = BehaviorSubject<String>();
  final email_controller = BehaviorSubject<String>();
  final password_controller = BehaviorSubject<String>();
  final confirm_password_controller = BehaviorSubject<String>();
  final merchant_name_controller = BehaviorSubject<String>();
  final merchant_phone_controller = BehaviorSubject<String>();
  final merchant_email_controller = BehaviorSubject<String>();
  final merchant_password_controller = BehaviorSubject<String>();
  final merchant_confirm_password_controller = BehaviorSubject<String>();

 final commercialRegister_controller = BehaviorSubject<String>();
 final merchant_address_controller = BehaviorSubject<String>();


  Function(String) get name_change => name_controller.sink.add;
  Function(String) get phone_change  => phone_controller.sink.add;
  Function(String) get email_change => email_controller.sink.add;
  Function(String) get password_change => password_controller.sink.add;
  Function(String) get confirm_password_change => confirm_password_controller.sink.add;
  Function(String) get merchant_name_change => merchant_name_controller.sink.add;
  Function(String) get merchant_phone_change  => merchant_phone_controller.sink.add;
  Function(String) get merchant_email_change => merchant_email_controller.sink.add;
  Function(String) get merchant_password_change => merchant_password_controller.sink.add;
  Function(String) get merchant_confirm_password_change => merchant_confirm_password_controller.sink.add;
  Function(String) get commercialRegister_change => commercialRegister_controller.sink.add;
  Function(String) get merchant_address_change => merchant_address_controller.sink.add;


  Stream<String> get name => name_controller.stream.transform(username_validator);
  Stream<String> get phone => phone_controller.stream.transform(phone_validator);
  Stream<String> get email => email_controller.stream.transform(email_validator);
  Stream<String> get password => password_controller.stream.transform(password_validator);
  Stream<String> get confirm_password => confirm_password_controller.stream.transform(password_validator);
  Stream<String> get merchant_name => merchant_name_controller.stream.transform(username_validator);
  Stream<String> get merchant_phone => merchant_phone_controller.stream.transform(phone_validator);
  Stream<String> get merchant_email => merchant_email_controller.stream.transform(email_validator);
  Stream<String> get merchant_password => merchant_password_controller.stream.transform(password_validator);
  Stream<String> get merchant_confirm_password => merchant_confirm_password_controller.stream.transform(password_validator);
  Stream<String> get commercialRegister => commercialRegister_controller.stream.transform(input_text_validator);
  Stream<String> get merchant_address => merchant_address_controller.stream.transform(input_text_validator);

  Stream<bool> get submitCheck => Rx.combineLatest4(name, phone, email, password, (a, b, c, d) => true);



  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is click){
      yield Loading(model: null);
      print('signup 1');
      String type = await sharedPreferenceManager.readString(CachingKey.User_TYPE);
      print("type : ${type}");
      var status ;
      if(type == 'user'){
        var response = await AuthenticationRepository.user_signUp(
          name:   name_controller.value,
          phone: phone_controller.value,
          email: email_controller.value,
          password: password_controller.value,
          password_confirmation:  confirm_password_controller.value,
          phone_code: await sharedPreferenceManager.readString(CachingKey.PHONE_CODE),
        );
        if(response.status ==200){
          print('signup 3');

          sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, response.token);
          sharedPreferenceManager.writeData(CachingKey.USER_NAME,response.data.name);
          sharedPreferenceManager.writeData(CachingKey.FORGET_PASSWORD_EMAIL, response.data.email);
          sharedPreferenceManager.writeData(CachingKey.MOBILE_NUMBER, response.data.phone);
          yield Done(model:response,indicator: 'user');
          print('signup 4');
        }else if (response.status == false){
          print('signup 5');
          yield ErrorLoading(response,indicator: 'user');
          print('response status : ${response.status}');

        }

      }else{
        print("33333333333333");
        var  response = await AuthenticationRepository.merchant_signUp(
          name:   merchant_name_controller.value,
          phone: merchant_phone_controller.value,
          email: merchant_email_controller.value,
          password: merchant_password_controller.value,
          password_confirmation:  merchant_confirm_password_controller.value,
          phone_code: await sharedPreferenceManager.readString(CachingKey.PHONE_CODE),
          commercialRegister: commercialRegister_controller.value,
          commercialRegister_photo: await sharedPreferenceManager.readString(CachingKey.COMMERCIAL_PHOTO),
          merchant_address: merchant_address_controller.value,

        );
        if(response.status ==200){
          print('signup 3');
          sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, response.token);
          sharedPreferenceManager.writeData(CachingKey.USER_NAME,response.data.name);
          sharedPreferenceManager.writeData(CachingKey.FORGET_PASSWORD_EMAIL, response.data.email);
          sharedPreferenceManager.writeData(CachingKey.MOBILE_NUMBER, response.data.phone);
          yield Done(model:response,indicator: 'merchant');
          print('signup 4');
        }else {
          print('signup 5');
          yield ErrorLoading(response,indicator: 'merchant');
          print('response status : ${response.status}');

        }

      }



    }
  }

  @override
  void dispose() {
    name_controller?.close();
    phone_controller?.close();
    email_controller?.close();
    password_controller?.close();
    confirm_password_controller?.close();
    commercialRegister_controller?.close();
    merchant_address_controller?.close();
  }


}


SignUpBloc signUpBloc = SignUpBloc(null);