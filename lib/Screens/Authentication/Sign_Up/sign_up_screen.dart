import 'dart:io';

import 'package:country_list_pick/country_list_pick.dart';

import 'package:image_picker/image_picker.dart';
import 'package:procard_store/Base/shared_preference_manger.dart';
import 'package:procard_store/Bloc/Authentication_Bloc/SigninBloc/sign_in_bloc.dart';
import 'package:procard_store/Bloc/Authentication_Bloc/SignupBloc/sign_up_bloc.dart';
import 'package:procard_store/Model/AuthenticationModel/signup_merchant_model.dart';
import 'package:procard_store/Model/AuthenticationModel/signup_model.dart';
import 'package:procard_store/Screens/Authentication/Sign_Up/merchant_elements.dart';
import 'package:procard_store/Screens/Authentication/Sign_Up/user_elements.dart';
import 'package:procard_store/Widgets/customTextField.dart';
import 'package:procard_store/Widgets/error_dialog.dart';
import 'package:procard_store/Widgets/stagger_animation.dart';
import 'package:procard_store/Widgets/text_field/custom_textfield_widget.dart';
import 'package:procard_store/fileExport.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  bool move_color;
  bool checkedValue;
  bool _passwordVisible;
  bool _confirmPasswordVisible;
  final picker = ImagePicker();
  File commerical_photo;
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
    move_color = false;
    checkedValue = false;
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    sharedPreferenceManager.writeData(CachingKey.User_TYPE, 'user');
    sharedPreferenceManager.writeData(CachingKey.PHONE_CODE, '+966');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child: WillPopScope(
          onWillPop: (){
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return SignInScreen();
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
          child: Scaffold(
              key: _drawerKey,
              body: BlocListener<SignUpBloc, AppState>(
                bloc: signUpBloc,
                listener: (context, state) async {
                  if (state is Loading) {
                    print('login Loading');
                    _playAnimation();
                  } else if (state is Done) {
                    if(state.indicator == 'user'){
                      var data = state.model as SignUpModel;
                      print('login done');
                      _stopAnimation();
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) {
                            return SignInScreen();
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
                    }else{
                      var data = state.model as SignUpMerchantModel;
                      print('login done');
                      _stopAnimation();
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) {
                            return SignInScreen();
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
                    }


                  } else if (state is ErrorLoading) {
                    print('login ErrorLoading');
                    if(state.indicator == 'user'){
                      var data = state.model as SignUpModel;
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
                    }else{
                      var data = state.model as SignUpMerchantModel;
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

                  }
                },
                child:  SafeArea(
                  child: SingleChildScrollView(
                    child: Directionality(
                      textDirection: translator.currentLanguage == 'ar'
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      child: Container(
                        padding: EdgeInsets.all(
                            StaticData.get_width(context) * 0.01),
                        color: primary_color,
                        child: Column(
                          children: [
                            //AppBar
                            CustomAppBar(
                              text: translator.translate("Sign UP"),
                              page_name: 'SignUpScreen',
                              color: primary_color,
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top:
                                    StaticData.get_width(context) * 0.05),
                                child: Image.asset(
                                  'Assets/Images/logo.png',
                                  color: whiteColor,
                                )),
                            SizedBox(
                              height: StaticData.get_width(context) * 0.1,
                            ),
                            registerRow(),
                            SizedBox(
                              height: StaticData.get_width(context) * 0.07,
                            ),

                            Container(
                              height: StaticData.get_height(context) * 0.6,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  move_color
                                      ? MerchantElements()
                                      : UserElements(),
                                  SizedBox(
                                    height:
                                    StaticData.get_width(context) * 0.02,
                                  ),
                                  checkBoxAndAccept(),
                                  SizedBox(
                                    height:
                                    StaticData.get_width(context) * 0.03,
                                  ),
                                  signUpButton(),
                                  SizedBox(
                                    height:
                                    StaticData.get_width(context) * 0.07,
                                  ),
                                  alreadyHaveAnAccount(),
                                  navigtor_to_signin_button()
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        )
      ),

    );
  }

  Widget register_userButton() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      splashColor: whiteColor,
      onTap: () {
        setState(() {
          move_color = !move_color;
        });
      },
      child: Container(
        width: width * .4,
        child: Column(
          children: [
            MyText(
              text: translator.translate("Register as User"),
              color: yellowColor,
              size: height * .019,
              weight: FontWeight.bold,
            ),
            Padding(
              padding: EdgeInsets.only(top: width * 0.02),
              child: Container(
                width: width * .4,
                color: move_color ? primary_color : yellowColor,
                height: height * .002,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget register_merchantButton() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      splashColor: Colors.white,
      onTap: () {
        setState(() {
          move_color = !move_color;
        });
      },
      child: Container(
        width: width * .4,
        child: Column(
          children: [
            MyText(
              text: translator.translate("Register as Merchant"),
              color: yellowColor,
              size: height * .02,
              weight: FontWeight.bold,
            ),
            Padding(
                padding: EdgeInsets.only(top: width * 0.02),
                child: Container(
                  width: width * .35,
                  color: move_color ? yellowColor : primary_color,
                  height: height * .002,
                ))
          ],
        ),
      ),
    );
  }

  Widget registerRow() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: width * .075, right: width * .075),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          register_merchantButton(),
          register_userButton(),
        ],
      ),
    );
  }

  Widget checkBoxAndAccept() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
          MyText(
            text: translator.translate("Accept Conditions"),
            size: height * .021,
            color: whiteColor,
          )
        ],
      ),
    );
  }

  Widget signUpButton() {
    return StaggerAnimation(
      context: context,
      titleButton: "Sign UP",
      buttonController: _loginButtonController.view,
      btn_color: yellowColor,
      text_color: primary_color,
      onTap: () {
        if (!isLoading) {
          if (checkedValue) {
            if (signUpBloc.password_controller.value ==
                signUpBloc.confirm_password_controller.value) {
              signUpBloc.add(click());
            } else {
              errorDialog(
                context: context,
                text: translator.translate("passwords are not identical"),
              );
            }
          } else {
            errorDialog(
              context: context,
              text: translator.translate("Accept terms & conditions *"),
            );
          }
        }
      },
    );
  }

  Widget alreadyHaveAnAccount() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: width * 0.1),
      child: Container(
        child: MyText(
            text: translator.translate("Already Have Account"),
            size: height * .018),
      ),
    );
  }

  Widget navigtor_to_signin_button() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return SignInScreen();
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
            translator.translate("Sign In"),
            style: const TextStyle(
              color: yellowColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.3,
            ),
          )),
    );
  }
}
