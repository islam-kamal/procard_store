import 'package:procard_store/fileExport.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferenceManager {
  SharedPreferences sharedPreferences;

  Future<bool> removeData(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.remove(key.value);
  }

  Future<bool> logout() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }

  Future<bool> writeData(CachingKey key, value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    print(
        "saving this value $value into local prefrence with key ${key.value}");
    Future returnedValue;
    if (value is String) {
      returnedValue = sharedPreferences.setString(key.value, value);
    } else if (value is int) {
      returnedValue = sharedPreferences.setInt(key.value, value);
    } else if (value is bool) {
      returnedValue = sharedPreferences.setBool(key.value, value);
    } else if (value is double) {
      returnedValue = sharedPreferences.setDouble(key.value, value);
    } else {
      return Future.error(NotValidCacheTypeException());
    }
    return returnedValue;
  }

  Future<bool> readBoolean(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences.getBool(key.value) ?? false);
  }

  Future<double> readDouble(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences.getDouble(key.value) ?? 0.0);
  }

  Future<int> readInteger(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences.getInt(key.value) ?? 0);
  }

  Future<String> readString(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences.getString(key.value) ?? "");
  }
}

class NotValidCacheTypeException implements Exception {
  String message() => "Not a valid cahing type";
}

class   CachingKey extends Enum<String> {
  const CachingKey(String val) : super(val);

  static const CachingKey VERIFCATION_TOKEN = const CachingKey('VERIFCATION_TOKEN');


  static const CachingKey USER_ID = const CachingKey('USER_ID');
  static const CachingKey AUTH_TOKEN = const CachingKey('AUTH_TOKEN');
  static const CachingKey USER_NAME = const CachingKey('USER_NAME');
  static const CachingKey EMAIL = const CachingKey('EMAIL');
  static const CachingKey MOBILE_NUMBER = const CachingKey('MOBILE_NUMBER');
  static const CachingKey IS_OWNER = const CachingKey('IS_OWNER');
  static const CachingKey FORGET_PASSWORD_EMAIL = const CachingKey('FORGET_PASSWORD_EMAIL');
  static const CachingKey DEFAULT_SHIPPING_ADDRESS = const CachingKey('DEFAULT_SHIPPING_ADDRESS');
  static const CachingKey MAPS_LAT = const CachingKey('lat');
  static const CachingKey Maps_lang = const CachingKey('lang');
  static const CachingKey MAP_ADDRESS = const CachingKey('map_address');
  static const CachingKey DEFAULT_CREDIT_CARD = const CachingKey('DEFAULT_CREDIT_CARD');
  static const CachingKey FRIST_LOGIN_STATUS = const CachingKey('FRIST_LOGIN_STATUS');
  static const CachingKey CITY = const CachingKey('city');
  static const CachingKey IQEMA_PHOTO = const CachingKey('IQEMA_PHOTO');
  static const CachingKey DRIVER_LICENCE_PHOTO = const CachingKey('DRIVER_LICENCE_PHOTO');
  static const CachingKey Car_LICENCE_PHOTO = const CachingKey('Car_LICENCE_PHOTO');
  static const CachingKey CAR_FRONT_PHOTO = const CachingKey('CAR_FRONT_PHOTO');
  static const CachingKey CAR_BACK_PHOTO = const CachingKey('CAR_BACK_PHOTO');

  static const CachingKey BIRTH_DAY = const CachingKey('BIRTH_DAY');
  static const CachingKey EXPIRE_Iqema = const CachingKey('EXPIRE_Iqema');
  static const CachingKey TIME = const CachingKey('Time');
  static const CachingKey IBAN = const CachingKey('IBAN');
  static const CachingKey BANK = const CachingKey('BANK');
  static const CachingKey USER_STATUS = const CachingKey('USER_STATUS');
  static const CachingKey USER_WALLET_BALANCE= const CachingKey('USER_WALLET_BALANCE');

  static const CachingKey FILTER_FROM= const CachingKey('FILTER_FROM');
  static const CachingKey FILTER_TO= const CachingKey('FILTER_TO');
  static const CachingKey DATE = const CachingKey('Date');
  static const CachingKey DATE_REVERSE = const CachingKey('Date_reverse');
  static const CachingKey FIREBASE_TOKEN = const CachingKey('FIREBASE_TOKEN');
  static const CachingKey PHONE_CODE = const CachingKey('PHONE_CODE');
  static const CachingKey User_TYPE = const CachingKey('User_TYPE');
  static const CachingKey LOGIN_TYPE = const CachingKey('LOGIN_TYPE');
  static const CachingKey COMMERCIAL_PHOTO = const CachingKey('COMMERCIAL_PHOTO');
  static const CachingKey NOTIFICATIONS_STATUS = const CachingKey('NOTIFICATIONS_STATUS');
}

final sharedPreferenceManager =SharedPreferenceManager();
