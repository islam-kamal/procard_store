
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:procard_store/Base/shared_preference_manger.dart';
import 'package:procard_store/Model/AuthenticationModel/forget_password_model.dart';
import 'package:procard_store/Model/AuthenticationModel/reset_password_model.dart';
import 'package:procard_store/Model/AuthenticationModel/signin_model.dart';
import 'package:procard_store/Model/AuthenticationModel/signup_merchant_model.dart';
import 'package:procard_store/Model/AuthenticationModel/signup_model.dart';
import 'package:procard_store/Model/AuthenticationModel/verification_code_model.dart';
import 'package:procard_store/fileExport.dart';

class AuthenticationRepository{
 static SharedPreferenceManager sharedPreferenceManager =SharedPreferenceManager();

  static Future<SignUpModel> user_signUp({String name, String phone, String email,
            String password, String password_confirmation,String phone_code,})async{

    print("name : $name");
    print("email : $email");
    print("password : $password");
    print("password_confirmation : ${password_confirmation}");
    print("phone_code : ${phone_code}");
    print("phone : $phone");

    FormData formData=FormData.fromMap({
      "name" : name,
      "phone" : phone,
      "email" : email,
      "password" : password,
      "password_confirmation" :password_confirmation,
      "phone_code":phone_code,
      "firebase_id" : await sharedPreferenceManager.readString(CachingKey.FIREBASE_TOKEN)
    });
    Map<String, String> headers = {
    //  'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return NetworkUtil.internal().post(SignUpModel(), 'https://procard.store/api/register',body: formData,headers: headers);
  }



 static Future<SignUpMerchantModel> merchant_signUp({String name, String phone, String email,
   String password, String password_confirmation,String phone_code, String commercialRegister_photo,String commercialRegister ,
   String merchant_address})async{
   FormData formData=FormData.fromMap({
     "name" : name,
     "phone" : phone,
     "email" : email,
     "password" : password,
     "password_confirmation" :password_confirmation,
     "commercial_number" : commercialRegister,
     "commercial_image" : await MultipartFile.fromFile(commercialRegister_photo),
     "phone_code" : phone_code,
     "address" : merchant_address,
     "firebase_id" : await sharedPreferenceManager.readString(CachingKey.FIREBASE_TOKEN)

   });
   Map<String, String> headers = {
    // 'Content-Type': 'application/json',
     'Accept': 'application/json',
   };
   return NetworkUtil.internal().post(SignUpMerchantModel(), Urls.MERCHANT_SIGN_UP,body: formData,headers: headers);
 }

  static Future<SignInModel> signIn(String username, String password)async{
    FormData formData =FormData.fromMap({
      "username" : username,
      "password" : password,
      "firebase_id" : await sharedPreferenceManager.readString(CachingKey.FIREBASE_TOKEN)

    });
    Map<String, String> headers = {
   //   'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return NetworkUtil.internal().post(SignInModel(), 'https://procard.store/api/login' ,body: formData,headers: headers);
  }

  static Future<ForgerPasswordModel> sendVerificationCode(String username){
    FormData formData = FormData.fromMap({
      'username' : username,

    });
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    return NetworkUtil.internal().post(ForgerPasswordModel(), Urls.FORGET_PASSWORD, body: formData,headers: headers);
  }

  static Future<VerificationCodeModel> checkOtpCode(String username , String code){
    FormData formData =FormData.fromMap({
    'username' : username,
      'code' : code,
    });
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    return NetworkUtil.internal().post(VerificationCodeModel(), Urls.VERIFCATION_CODE, body: formData,headers: headers);
  }

/*  static Future<AuthenticationModel> resendOtp(String email){
    FormData formData =FormData.fromMap({
      'email' : email,
      'lang' : 'ar'
    });
    return NetworkUtil.internal().post(AuthenticationModel(), Urls.FORGET_PASSWORD ,body: formData);
  }*/

  static Future<ResetPasswordModel> reset_Password(String token, String password, String password_confirmation){
    FormData formData =FormData.fromMap({
      'token' : token,
      'password' :password,
      'password_confirmation' : password_confirmation,
    });
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    return NetworkUtil.internal().post(ResetPasswordModel(), Urls.RESET_PASSWORD,body: formData,headers: headers);
  }

  static Future<ResetPasswordModel> logout()async{

    FormData formData = FormData.fromMap({

    });
    Map<String, String> headers = {
      'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
      'Accept': 'application/json',
    };
    return NetworkUtil.internal().post(ResetPasswordModel(), Urls.LOGOUT, body: formData,headers: headers);
  }
/*
  static Future<AuthenticationModel> editProfile(String token, String username, String mobile, String email, String password ){
    FormData formData = FormData.fromMap({
      "token" : token,
      "username" : username,
      "mobile" : mobile,
      "email" : email,
      "password" : password
    });
    return NetworkUtil.internal().post(AuthenticationModel(), Urls.UPDATE_PROFILE, body: formData);
  }



  static Future<AuthenticationModel> upgradeAccount(String token , int is_owner){
    FormData formData = FormData.fromMap({
      'token' : token,
      'is_owner' : is_owner,
    });
    return NetworkUtil.internal().post(AuthenticationModel(), Urls.UPGRADE_BROKER, body: formData);

  }


 static Future<RefreshTokenModel> refresh_token() async{
    print("refresh : ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}");
    FormData formData = FormData.fromMap({
      'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
    });
    return NetworkUtil.internal().post(RefreshTokenModel(), Urls.REFRESH_TOKEN, body: formData);
 }*/
}