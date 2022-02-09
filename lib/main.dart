
import 'package:firebase_core/firebase_core.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:flutter/material.dart';
import 'package:procard_store/Screens/Authentication/check_otp_screen.dart';
import 'package:procard_store/Screens/Authentication/reset_password.dart';
import 'package:procard_store/Screens/Profile/Orders_history/order_codes.dart';
import 'package:procard_store/Screens/Profile/Orders_history/orders_history_page.dart';
import 'package:procard_store/Screens/SideBarMenu/Call_Us/call_us.dart';
import 'package:procard_store/Screens/Splash/splash.dart';
import 'Screens/Authentication/forget_password_screen.dart';
import 'file:///D:/Ibtdi/Procard%20Store/code/procard_store/lib/Screens/Authentication/Sign_Up/sign_up_screen.dart';
import 'fileExport.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await translator.init(
    assetsDirectory: 'Assets/Lang/',
     languagesList: ['ar','en']
  );
  runApp(
    new MyApp(),
  );
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType();
    print(newLocale.languageCode);
    // ignore: invalid_use_of_protected_member
    state.setState(() => state.local = newLocale);
  }

}

class _MyAppState extends State<MyApp>{

  Locale local;
  final GlobalKey<NavigatorState> navKey = GlobalKey();
  AppPushNotifications appPushNotifications = AppPushNotifications();

  @override
  void initState() {
    setState(() {
      appPushNotifications.notificationSetup(navKey);
    });
    Future<PermissionStatus> permissionStatus =
    NotificationPermissions.getNotificationPermissionStatus();
    permissionStatus.then((status) {
      print("======> $status");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   MaterialApp(
      localizationsDelegates: translator.delegates,
      locale: local,
      supportedLocales: translator.locals(),
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      home: Splash(),
      theme: ThemeData(
          primaryColor: greenColor,
          accentColor: greenColor,
          fontFamily: "Cairo",
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: whiteColor,
            displayColor: Colors.blue,
          )),
      localeResolutionCallback: (locale,supportedLocales){
        for( var supportedLocale in supportedLocales){
          if(supportedLocale.languageCode==locale.languageCode && supportedLocale.countryCode == locale.countryCode){
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }

}

