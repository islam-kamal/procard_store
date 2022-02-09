import 'package:procard_store/Bloc/Authentication_Bloc/ForgetPasswordBloc/forget_password_bloc.dart';
import 'package:procard_store/Model/AuthenticationModel/forget_password_model.dart';

import 'package:procard_store/fileExport.dart';

class ForgetPasswordScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ForgetPasswordScreenState();
  }

}

class ForgetPasswordScreenState extends State<ForgetPasswordScreen> with TickerProviderStateMixin{

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
    forgetPassword_bloc.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          key: _drawerKey,
          body: BlocListener<ForgetPasswordBloc, AppState>(
            bloc: forgetPassword_bloc,
        listener: (context, state) async {
      var data = state.model as ForgerPasswordModel;
      if (state is Loading) {
        print('login Loading');
        _playAnimation();
      } else if (state is Done) {
        print('login done');
        _stopAnimation();
        errorDialog(
          context: context,
          text: translator.translate("The password recovery link has been sent to your email successfully" ),
          function: (){
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return CheckOtpScreen();
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
    child:Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(StaticData.get_width(context) * 0.01),
              child: Column(
                children: [
                  CustomAppBar(
                    text: translator.translate("Password Recovery"),
                    page_name: 'ForgetPasswordScreen',
                    color: whiteColor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: StaticData.get_width(context) * 0.1),
                    child: Container(
                      child: Image.asset('Assets/Images/reset.png'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: StaticData.get_width(context) * 0.1),
                    child:  Container(
                      child: Text(translator.translate("Enter your email to send a password recovery code" ),style: TextStyle(color: primary_color),),
                    ),),
                  Padding(
                    padding: EdgeInsets.only(top: StaticData.get_width(context) * 0.1),
                    child:  username_textfield(),
                  ),

                  Padding(
                      padding: EdgeInsets.only(top: StaticData.get_width(context) * 0.1),
                      child: forgetPasswordButton()),
                ],
              ) ),
        ),
      ),
    ),)
        ),
      ),
    );
  }
  Widget username_textfield(){
    return  StreamBuilder<String>(
        stream: forgetPassword_bloc.username,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,
                left: StaticData.get_width(context) * 0.02,),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("Email"),
              iconData: Icons.email,
              onchange: forgetPassword_bloc.username_change,
              errorText: snapshot.error,
              color: primary_color,
              inputType: TextInputType.emailAddress,),
          );
        });
  }

  Widget forgetPasswordButton() {
    return StaggerAnimation(
      context: context,
      titleButton: "Password Recovery",
      buttonController: _loginButtonController.view,
      btn_color: primary_color,
      text_color: whiteColor,
      onTap: () {
        forgetPassword_bloc.add(sendOtpClick());
      },
    );

  }
}