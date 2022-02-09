
import 'package:procard_store/Bloc/Wallet_Bloc/wallet_bloc.dart';
import 'package:procard_store/Screens/Profile/Credit_Cards/credit_cards_screen.dart';
import 'package:procard_store/Screens/Profile/Wallet/charge_wallet_screen.dart';
import 'package:procard_store/fileExport.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StaticData.vistor_value = null; // clear vistor state

    Timer(Duration(seconds: 0), () async {
      try {
        print(
            '--- token -- : ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}');
        checkAuthentication(await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN));
      } catch (e) {
        checkAuthentication(null);
      }
    });
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: greenColor,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: height,
            width: width,
            child: Image.asset(
              "Assets/Images/splashscreen.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  void checkAuthentication(String token) async {
   if (token.isEmpty) {
     StaticData.vistor_value = 'visitor';
     await Future.delayed(Duration(seconds: 2));
     Navigator.pushReplacement(
         context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
     await  walletBloc.add(getWalletHistoryEvent());

     await Future.delayed(Duration(seconds: 2));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }

    }


  }

