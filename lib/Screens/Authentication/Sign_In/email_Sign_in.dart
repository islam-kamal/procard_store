import 'package:procard_store/Bloc/Authentication_Bloc/SigninBloc/sign_in_bloc.dart';
import 'package:procard_store/fileExport.dart';

class EmailSignIn extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EmailSignInState();
  }

}

class EmailSignInState extends State<EmailSignIn>{
  bool _passwordVisible;
  @override
  void initState() {
    sharedPreferenceManager.writeData(CachingKey.LOGIN_TYPE, 'email');
    _passwordVisible = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        email_textfield() ,
        SizedBox(
          height: 10,
        ),
        email_password_textfield(),
      ],
    );
  }
  Widget email_textfield(){
    return  StreamBuilder<String>(
        stream: signIn_bloc.email,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(
                right: StaticData.get_width(context) * 0.02,
                left: StaticData.get_width(context) * 0.02),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("Email"),
              iconData: Icons.email,
              onchange: signIn_bloc.email_change,
              suffixIcon: null,
              errorText: snapshot.error,
              inputType: TextInputType.emailAddress,),
          );
        });
  }

  Widget email_password_textfield(){
    return  StreamBuilder<String>(
        stream: signIn_bloc.email_password,
        builder: (context, snapshot) {
          return Padding(
              padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,left: StaticData.get_width(context) * 0.02),
              child: CustomTextFieldWidget(
                context: context,
                hint: translator.translate("Password" ),
                iconData: Icons.lock_outline,
                secure: !_passwordVisible ,
                onchange: signIn_bloc.email_password_change,
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
}