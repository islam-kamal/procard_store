import 'package:procard_store/Bloc/Authentication_Bloc/ForgetPasswordBloc/forget_password_bloc.dart';
import 'package:procard_store/Model/AuthenticationModel/forget_password_model.dart';
import 'package:procard_store/Model/AuthenticationModel/verification_code_model.dart';
import 'package:procard_store/Screens/Authentication/reset_password.dart';
import 'package:procard_store/Widgets/stagger_animation.dart';
import 'package:procard_store/fileExport.dart';

class CheckOtpScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CheckOtpScreenState();
  }

}

class CheckOtpScreenState extends State<CheckOtpScreen> with TickerProviderStateMixin{

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
          body:BlocListener<ForgetPasswordBloc, AppState>(
            bloc: forgetPassword_bloc,
        listener: (context, state) async {
      var data = state.model as VerificationCodeModel;
      if (state is Loading) {
        print('login Loading');
        _playAnimation();
      } else if (state is Done) {
        print('login done');
        _stopAnimation();
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return ResetPassword();
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
    child: Scaffold(
    body: SafeArea(
    child: SingleChildScrollView(
    child:Column(
            children: [
              CustomAppBar(
                text: translator.translate("Verification Code"),
                page_name: 'CheckOtpScreen',
                color: whiteColor,
              ),
              Padding(
                padding: EdgeInsets.only(top: StaticData.get_width(context) * 0.1),
                child: Container(
                  child: Image.asset('Assets/Images/reset.png'),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: StaticData.get_width(context) * 0.2),
                child:  otp_textfield(),

              ),
              Padding(
                  padding: EdgeInsets.only(top: StaticData.get_width(context) * 0.1),
                  child: checkOtpButton()),
            ],
    )))),
        ),
      ),
    ));
  }

  Widget otp_textfield(){
    return  StreamBuilder<String>(
        stream: forgetPassword_bloc.code,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,
                left: StaticData.get_width(context) * 0.02),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("Enter Code"),
              onchange: forgetPassword_bloc.code_change,
              errorText: snapshot.error,
              color: primary_color,
              iconData: Icons.adjust,

              inputType: TextInputType.text,),
          );
        });
  }

  Widget checkOtpButton() {
    return StaggerAnimation(
      context: context,
      titleButton: "Verify",
      buttonController: _loginButtonController.view,
      btn_color: primary_color,
      text_color: whiteColor,
      onTap: () {
        forgetPassword_bloc.add(checkOtpClick());
      },
    );

  }
}