
import 'package:procard_store/fileExport.dart';

class UserElements extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserElementsState();
  }

}

class UserElementsState extends State<UserElements>{
  String _phonecode = '';
  bool _passwordVisible;
  bool _confirmPasswordVisible;
  @override
  void initState() { _passwordVisible = false;
  _confirmPasswordVisible = false;
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    sharedPreferenceManager.writeData(CachingKey.User_TYPE, 'user');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        name_textfield(),
        SizedBox(
          height: 10,
        ),
        phone_textfield(),
        SizedBox(
          height: 10,
        ),
        email_textfield() ,
        SizedBox(
          height: 10,
        ),
        password_textfield(),
        SizedBox(
          height: 10,
        ),
        confirm_password_textfield()
      ],
    );
  }
  //register as user
  Widget name_textfield(){
    return StreamBuilder<String>(
      stream: signUpBloc.name,
      builder: (context, snapshot) {
        return  Padding(
            padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,
                left: StaticData.get_width(context) * 0.02),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("Full Name *"),
              iconData: Icons.person_outline,
              onchange: signUpBloc.name_change,
              suffixIcon: null,
              errorText: snapshot.error,
              inputType: TextInputType.name,
            )
        );

      },
    );
  }

  Widget phone_textfield(){
    return  StreamBuilder<String>(
        stream: signUpBloc.phone,
        builder: (context, snapshot) {
          return Container(
            width: StaticData.get_width(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child:Padding(
                padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,
                    left: StaticData.get_width(context) * 0.02),
                child: Row(
                  children: [

                    Expanded(
                        child:   CustomTextFieldWidget(
                          context: context,
                          hint: translator.translate("Phone"),
                          iconData: Icons.phone,
                          onchange: signUpBloc.phone_change,
                          errorText: snapshot.error,
                          inputType: TextInputType.phone,

                        )),
                    Container(
                        width: StaticData.get_width(context)*0.25,
                        child:  CountryListPick(
                          appBar: AppBar(
                            backgroundColor: Colors.blue,
                            title: Text(translator.translate('country_code')),
                          ),

                          // if you need custome picker use this
                          pickerBuilder: (context, CountryCode countryCode){
                            return Padding(
                                padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,
                                    left: StaticData.get_width(context) * 0.02),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(countryCode.dialCode,style: TextStyle(color: Colors.white),),
                                    SizedBox(width: StaticData.get_width(context) * 0.02,),
                                    Image.asset(
                                      countryCode.flagUri,
                                      package: 'country_list_pick',width: 30,height: 20,
                                    ),

                                  ],
                                ) );
                          },


                          // To disable option set to false
                          theme: CountryTheme(
                            isShowFlag: true,
                            isShowTitle: true,
                            isShowCode: true,
                            isDownIcon: true,
                            showEnglishName: true,


                          ),
                          // Set default value
                          initialSelection: '+966',
                          onChanged: (CountryCode code) {
                            sharedPreferenceManager.writeData(CachingKey.PHONE_CODE, code.dialCode);
                            print(code.name);
                            print(code.code);
                            print(code.dialCode);
                            print(code.flagUri);
                            _phonecode = code.dialCode;
                          },
                          // Whether to allow the widget to set a custom UI overlay
                          useUiOverlay: true,
                          // Whether the country list should be wrapped in a SafeArea
                          useSafeArea: false,

                        ) ),
                  ],
                )

            ),


          );
        });
  }

  Widget email_textfield(){
    return  StreamBuilder<String>(
        stream: signUpBloc.email,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,
                left: StaticData.get_width(context) * 0.02),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("Email"),
              iconData: Icons.email,
              onchange: signUpBloc.email_change,
              suffixIcon: null,
              errorText: snapshot.error,
              inputType: TextInputType.emailAddress,),
          );
        });
  }

  Widget password_textfield(){
    return  StreamBuilder<String>(
        stream: signUpBloc.password,
        builder: (context, snapshot) {
          return Padding(
              padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,left: StaticData.get_width(context) * 0.02),
              child: CustomTextFieldWidget(
                context: context,
                hint: translator.translate("Password" ),
                iconData: Icons.lock_outline,
                secure: !_passwordVisible ,
                onchange: signUpBloc.password_change,
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
    return StreamBuilder<String>(
        stream: signUpBloc.confirm_password,
        builder: (context, snapshot)
        {
          return Padding(
            padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,
                left: StaticData.get_width(context) * 0.02),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("Confirm Password"),
              iconData: Icons.lock_outline,
              secure: !_confirmPasswordVisible ,
              onchange: signUpBloc.confirm_password_change,
              inputType: TextInputType.emailAddress,
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _confirmPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _confirmPasswordVisible = !_confirmPasswordVisible;
                  });
                },
              ),
              errorText: snapshot.error,
            ),
          );
        });
  }
}