import 'package:flushbar/flushbar.dart';
import 'package:procard_store/Bloc/Authentication_Bloc/SigninBloc/sign_in_bloc.dart';
import 'package:procard_store/Bloc/Authentication_Bloc/SignupBloc/sign_up_bloc.dart';
import 'package:procard_store/Model/AuthenticationModel/signin_model.dart';
import 'package:procard_store/Screens/Authentication/Sign_In/email_Sign_in.dart';
import 'package:procard_store/Screens/Authentication/Sign_In/phone_sign_in.dart';
import 'package:procard_store/Screens/Authentication/Sign_Up/sign_up_screen.dart';
import 'package:procard_store/Screens/Authentication/forget_password_screen.dart';
import 'package:procard_store/Widgets/error_dialog.dart';
import 'package:procard_store/Widgets/stagger_animation.dart';
import 'package:procard_store/Widgets/text_field/custom_textfield_widget.dart';
import 'package:procard_store/fileExport.dart';

class SignInScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SignInScreenState();
  }

}

class SignInScreenState extends State<SignInScreen>with TickerProviderStateMixin{
  bool move_color;
  bool checkedValue;
  bool _passwordVisible;
  bool _confirmPasswordVisible;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController _loginButtonController;
  bool isLoading = false;

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {
      print('[_playAnimation] error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
      print('[_stopAnimation] error');
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    sharedPreferenceManager.writeData(CachingKey.LOGIN_TYPE, 'email');

    move_color = false;
    checkedValue = false;
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child: WillPopScope(
          onWillPop: () async => false,
          child:  Scaffold(
            key: _drawerKey,
            body:BlocListener<SigninBloc, AppState>(
              bloc: signIn_bloc,
              listener: (context, state) async {
                var data = state.model as SignInModel;
                if (state is Loading) {
                  print('login Loading');
                  _playAnimation();
                } else if (state is Done) {
                  print('login done');
                  _stopAnimation();
                  StaticData.vistor_value = '';
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return HomeScreen();
                      },
                      transitionsBuilder: (context, animation8, animation15, child) {
                        return FadeTransition(
                          opacity: animation8,
                          child: child,
                        );
                      },
                      transitionDuration: Duration(milliseconds: 10),
                    ),
                  );

                } else if (state is ErrorLoading) {
                  print('login ErrorLoading');
                  _stopAnimation();
                  Flushbar(
                    messageText: Row(
                      children: [
                        Text(
                          '${data.message}',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: whiteColor),
                        ),
                        Spacer(),
                        Text(
                          translator.translate("Try Again"),
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: whiteColor),
                        ),
                      ],
                    ),
                    flushbarPosition: FlushbarPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    flushbarStyle: FlushbarStyle.FLOATING,
                    duration: Duration(seconds: 6),
                  )..show(_drawerKey.currentState.context);
                }
              },
              child: Directionality(
                textDirection: translator.currentLanguage == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child:SafeArea(
                  child: SingleChildScrollView(
                    child: Directionality(
                      textDirection: translator.currentLanguage == 'ar'? TextDirection.rtl : TextDirection.ltr,
                      child: Container(
                        padding: EdgeInsets.all(StaticData.get_width(context) * 0.01),
                        color: primary_color,
                        child: Column(
                          children: [
                            //AppBar
                            CustomAppBar(
                              text: translator.translate("Sign In"),
                              page_name: 'SignInScreen',
                              color: primary_color,

                            ),
                            Padding(
                                padding:
                                EdgeInsets.only(top: StaticData.get_width(context) * 0.05),
                                child: Image.asset('Assets/Images/logo.png',color: whiteColor,)),
                            SizedBox(
                              height: StaticData.get_width(context) * 0.1,
                            ),
                            registerRow(),
                            SizedBox(
                              height: StaticData.get_width(context) * 0.1,
                            ),

                            move_color?   PhoneSignIn() :  EmailSignIn(),

                            SizedBox(
                              height: StaticData.get_width(context) * 0.02,
                            ),
                            rememberAndForget()
                            ,
                            SizedBox(
                              height: StaticData.get_width(context) * 0.03,
                            ),

                            signInButton(),
                            SizedBox(
                              height: StaticData.get_width(context) * 0.07,
                            ),
                            notHaveAnAccount(),
                            navigtor_to_signUp(),
                            SizedBox(
                              height: StaticData.get_width(context) * 0.01,
                            ),
                            visitor(),
                            SizedBox(
                              height: StaticData.get_width(context) * 0.1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ));
  }


  Widget email_Button(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      splashColor: whiteColor,
      onTap: (){
        setState(() {
          move_color = ! move_color;
        });
      },
      child: Container(width: width*.4,
        child: Column(children: [
          MyText(text: translator.translate( "Email") ,color: yellowColor,size: height*.019,weight: FontWeight.bold,),
          Padding(
            padding: EdgeInsets.only(top: width * 0.02),
            child:  Container(
              width: width*.4,color:move_color ? primary_color : yellowColor,height: height*.002,) ,
          )

        ],),),
    );
  }
  Widget phone_Button(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(splashColor: Colors.white,
      onTap: (){
        setState(() {
          move_color = ! move_color;
        });
        /* Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => MyFavourites()
      ));*/
      },
      child: Container(width: width*.4,
        child: Column(children: [
          MyText(text: translator.translate( "Phone") ,color: yellowColor ,size: height*.02,weight: FontWeight.bold,),
          Padding(
              padding: EdgeInsets.only(top: width * 0.02),
              child:  Container(
                width: width*.35,color: move_color ? yellowColor : primary_color ,height: height*.002,))
        ],),),
    );
  }
  Widget registerRow(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(padding: EdgeInsets.only(left: width*.075,right: width*.075),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          phone_Button(),
          email_Button(),
        ],),
    );

  }

  Widget rememberAndForget() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: (){
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return ForgetPasswordScreen();
                },
                transitionsBuilder:
                    (context, animation8, animation15, child) {
                  return FadeTransition(
                    opacity: animation8,
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 10),
              ),
            );

          },
          child: MyText(
            text: translator.translate("Forgot your password ?"),
            color: greenColor,
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText(
                text:translator.translate("remember me"),
                size: height * .021,
                color: whiteColor,
              ),
              Theme(
                  data: ThemeData(
                      unselectedWidgetColor: yellowColor,
                      primaryColor: yellowColor,
                      accentColor: yellowColor),
                  child: Checkbox(
                      value: checkedValue,
                      tristate: false,
                      onChanged: (bool value) {
                        setState(() {
                          checkedValue = !checkedValue;
                          print(checkedValue);
                        });
                      })),
            ],
          ),
        ),
      ],
    );
  }

  Widget signInButton() {
    return StaggerAnimation(
      context: context,
      titleButton: translator.translate("sign in"),
      buttonController: _loginButtonController.view,
      btn_color: yellowColor,
      text_color: primary_color,
      onTap: () {
        signIn_bloc.add(click());
      },
    );

  }
  Widget notHaveAnAccount() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: width *0.1),
      child: Container(
        child:   MyText(text: translator.translate("Don't have an account?"), size: height * .018),

      ),
    );
  }

  Widget navigtor_to_signUp(){
    return  GestureDetector(
      onTap:() {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return SignUpScreen();
            },
            transitionsBuilder:
                (context, animation8, animation15, child) {
              return FadeTransition(
                opacity: animation8,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 10),
          ),
        );
      },
      child: Container(
          width: StaticData.get_width(context) * 0.9,
          height: StaticData.get_height(context) * .08,
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
            color: third_color,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Text(
            translator.translate( "Create a new account"),
            style: const TextStyle(
              color: yellowColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.3,
            ),
          )

      ),
    );

  }


  Widget visitor(){
    return Padding(
      padding: EdgeInsets.only(top: StaticData.get_width(context) * 0.05,right: 10,left: 10),
      child:  InkWell(
        onTap: (){
          StaticData.vistor_value = 'visitor';
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) {
                return HomeScreen();
              },
              transitionsBuilder:
                  (context, animation8, animation15, child) {
                return FadeTransition(
                  opacity: animation8,
                  child: child,
                );
              },
              transitionDuration: Duration(milliseconds: 10),
            ),
          );

        },
        child: Row(
        mainAxisAlignment: translator.currentLanguage == 'ar' ?MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Image.asset('Assets/Images/skip.png',
            color: whiteColor,),
          SizedBox(width: 5,),
          Container(
            child: Text(translator.translate("Skip as a visitor"),
              style: TextStyle(color: greenColor ),),
          ),


        ],
      ),),
    );
  }
}