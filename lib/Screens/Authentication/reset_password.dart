import 'package:procard_store/Bloc/Authentication_Bloc/ForgetPasswordBloc/forget_password_bloc.dart';
import 'package:procard_store/Model/AuthenticationModel/reset_password_model.dart';
import 'package:procard_store/Widgets/error_dialog.dart';
import 'package:procard_store/Widgets/stagger_animation.dart';
import 'package:procard_store/fileExport.dart';

class ResetPassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ResetPasswordState();
  }

}
class ResetPasswordState extends State<ResetPassword>with TickerProviderStateMixin{
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
        child: Scaffold(
          key: _drawerKey,
          body: BlocListener<ForgetPasswordBloc, AppState>(
              bloc: forgetPassword_bloc,
        listener: (context, state) async {
      var data = state.model as ResetPasswordModel;
      if (state is Loading) {
        print('login Loading');
        _playAnimation();
      } else if (state is Done) {
        print('login done');
        _stopAnimation();
        errorDialog(
            context: context,
            text: '${translator.translate("Password changed successfully")}',
          function: (){
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
    child:SafeArea(
      child: SingleChildScrollView(
          child:Column(
            children: [
              CustomAppBar(
                text: translator.translate("new password"),
                page_name: 'ResetPassword',
                color: whiteColor,

              ),
              Padding(
                padding: EdgeInsets.only(top: StaticData.get_width(context) * 0.1),
                child: Container(
                  child: Image.asset('Assets/Images/newpass.png'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: StaticData.get_width(context) * 0.1),
                child:  Container(
                  child: Text(translator.translate("Enter the new password") ,style: TextStyle(color: primary_color),),
                ),),
              Padding(
                padding: EdgeInsets.only(top: StaticData.get_width(context) * 0.1),
                child:  password_textfield(),

              ),
              Padding(
                padding: EdgeInsets.only(top: StaticData.get_width(context) * 0.1),
                child:  confirm_password_textfield(),

              ),
              Padding(
                  padding: EdgeInsets.only(top: StaticData.get_width(context) * 0.1),
                  child: changePasswordButton()
              ),

            ],
    )  ),
    )) ),
      ),
    );
  }
  Widget password_textfield(){
    return  StreamBuilder<String>(
        stream: forgetPassword_bloc.password,
        builder: (context, snapshot) {
          return Padding(
              padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,left: StaticData.get_width(context) * 0.02),
              child: CustomTextFieldWidget(
                context: context,
                hint: translator.translate("Password" ),
                iconData: Icons.lock_outline,
                color: primary_color,
                secure: !_passwordVisible ,
                onchange: forgetPassword_bloc.password_change,
                inputType: TextInputType.text,
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                errorText: snapshot.error,
              ));
        });
  }

  Widget confirm_password_textfield(){
    return  StreamBuilder<String>(
        stream: forgetPassword_bloc.confirm_password,
        builder: (context, snapshot) {
          return Padding(
              padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,left: StaticData.get_width(context) * 0.02),
              child: CustomTextFieldWidget(
                context: context,
                hint: translator.translate("Confirm Password" ),
                iconData: Icons.lock_outline,
                secure: !_confirmPasswordVisible ,
                onchange: forgetPassword_bloc.confirm_password_change,
                inputType: TextInputType.text,
                color: primary_color,
                suffixIcon: IconButton(
                  icon: Icon(
                    _confirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _confirmPasswordVisible = !_confirmPasswordVisible;
                    });
                  },
                ),
                errorText: snapshot.error,
              ));
        });
  }

  Widget changePasswordButton() {
    return StaggerAnimation(
      context: context,
      titleButton: "Change Password",
      buttonController: _loginButtonController.view,
      btn_color: primary_color,
      text_color: whiteColor,
      onTap: () {

        forgetPassword_bloc.add(changePasswordClick());
      },
    );

  }
}