import 'package:procard_store/Bloc/Authentication_Bloc/SigninBloc/sign_in_bloc.dart';
import 'package:procard_store/fileExport.dart';

class PhoneSignIn extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PhoneSignInState();
  }

}

class PhoneSignInState extends State<PhoneSignIn>{
  bool _passwordVisible;

  @override
  void initState() {
    sharedPreferenceManager.writeData(CachingKey.LOGIN_TYPE, 'phone');
    _passwordVisible = false;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        phone_textfield(),
        SizedBox(
          height: 10,
        ),
        phone_password_textfield(),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget phone_textfield(){
    return  StreamBuilder<String>(
        stream: signIn_bloc.phone,
        builder: (context, snapshot) {
          return Padding(
              padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,left: StaticData.get_width(context) * 0.02),
          child: CustomTextFieldWidget(
            context: context,
            hint: translator.translate("Phone"),
            iconData: Icons.phone,
            onchange: signIn_bloc.phone_change,
            errorText: snapshot.error,
            inputType: TextInputType.phone,

          ));
        });
  }

  Widget phone_password_textfield(){
    return  StreamBuilder<String>(
        stream: signIn_bloc.phone_password,
        builder: (context, snapshot) {
          return Padding(
              padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,left: StaticData.get_width(context) * 0.02),
              child: CustomTextFieldWidget(
                context: context,
                hint: translator.translate("Password" ),
                iconData: Icons.lock_outline,
                secure: !_passwordVisible ,
                onchange: signIn_bloc.phone_password_change,
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