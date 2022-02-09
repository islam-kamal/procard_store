import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:procard_store/Base/shared_preference_manger.dart';
import 'package:procard_store/fileExport.dart';

class MerchantElements extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MerchantElementsState();
  }

}

class MerchantElementsState extends State<MerchantElements>{

  bool _passwordVisible;
  bool _confirmPasswordVisible;
  final picker = ImagePicker();
  File commerical_photo;
  String _phonecode = '';

  @override
  void initState() {
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    sharedPreferenceManager.writeData(CachingKey.User_TYPE, 'merchant');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        merchant_name_textfield(),
        SizedBox(
          height: 10,
        ),
        merchant_phone_textfield(),
        SizedBox(
          height: 10,
        ),
        merchant_email_textfield() ,
        SizedBox(
          height: 10,
        ),
        commercialRegister_textfield(),
        SizedBox(
          height: 10,
        ),
        SelectCommericalImage(),
        SizedBox(
          height: 10,
        ),
        merchant_address_textfield(),
        SizedBox(
          height: 10,
        ),
        merchant_password_textfield(),
        SizedBox(
          height: 10,
        ),
        merchant_confirm_password_textfield()

      ],
    );
  }


  //register as merchant
  Widget merchant_name_textfield(){
    return  StreamBuilder<String>(
        stream: signUpBloc.merchant_name,
        builder: (context, snapshot)
        {
          return Padding(
            padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,
                left: StaticData.get_width(context) * 0.02),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate(
                  "Merchant / Store Name (Name must be quadrant)"),
              iconData: Icons.person_outline,
              secure: false,
              onchange: signUpBloc.merchant_name_change,
              suffixIcon: null,
              errorText: snapshot.error,
              inputType: TextInputType.name,
            ),
          );
        });
  }

  Widget merchant_phone_textfield(){
    return  StreamBuilder<String>(
        stream: signUpBloc.merchant_phone,
        builder: (context, snapshot) {
          return Container(
            width: StaticData.get_width(context),

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
                          onchange: signUpBloc.merchant_phone_change,
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

  Widget merchant_email_textfield(){
    return  StreamBuilder<String>(
        stream: signUpBloc.merchant_email,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,
                left: StaticData.get_width(context) * 0.02),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("Email"),
              iconData: Icons.email,
              onchange: signUpBloc.merchant_email_change,
              suffixIcon: null,
              errorText: snapshot.error,
              inputType: TextInputType.emailAddress,),
          );
        });
  }

  Widget merchant_password_textfield(){
    return  StreamBuilder<String>(
        stream: signUpBloc.merchant_password,
        builder: (context, snapshot) {
          return Padding(
              padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,left: StaticData.get_width(context) * 0.02),
              child: CustomTextFieldWidget(
                context: context,
                hint: translator.translate("Password" ),
                iconData: Icons.lock_outline,
                secure: !_passwordVisible ,
                onchange: signUpBloc.merchant_password_change,
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

  Widget merchant_confirm_password_textfield(){
    return StreamBuilder<String>(
        stream: signUpBloc.merchant_confirm_password,
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
              onchange: signUpBloc.merchant_confirm_password_change,
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


  Widget commercialRegister_textfield(){
    return StreamBuilder<String>(
        stream: signUpBloc.commercialRegister,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,
                left: StaticData.get_width(context) * 0.02),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("Commercial Register"),
              iconData: Icons.border_color,
              secure: false,
              onchange: signUpBloc.commercialRegister_change,
              suffixIcon: null,
              errorText: snapshot.error,
              inputType: TextInputType.text,
            ),
          );
        });
  }
  Widget merchant_address_textfield(){
    return StreamBuilder<String>(
        stream: signUpBloc.merchant_address,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(right: StaticData.get_width(context) * 0.02,left: StaticData.get_width(context) * 0.02),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("Store address" ),
              iconData: Icons.location_on,
              secure: false  ,
              onchange: signUpBloc.merchant_address_change,
              errorText: snapshot.error,
              inputType: TextInputType.streetAddress,
            ),
          );
        });
  }


  Widget commerical_register_Photo() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        commerical_photo==null?Container(
            height: height * .13,
            // width: width * .25,
            child: Column(
              children: [
                Image(
                  image: AssetImage( 'Assets/Images/camera.png'),
                  height: StaticData.get_width(context) * 0.1,
                  width:   StaticData.get_width(context) * 0.1,
                ),
                SizedBox(
                  height: StaticData.get_width(context) * 0.01,
                ),
                Text(translator.translate("commercial register image",))

              ],
            ) ): ClipRRect(
          child: Container(
              height: height * .13,
              width: width * .25,
              decoration:
              BoxDecoration(shape: BoxShape.circle, color: whiteColor),
              child: Image.file(File(commerical_photo.path,),fit: BoxFit.fill,)),
          borderRadius: BorderRadius.circular(70),
          clipBehavior: Clip.antiAliasWithSaveLayer,
        ),
      ],
    );
  }

  Widget SelectCommericalImage() {
    return InkWell(
        onTap: getCommericalmage,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: commerical_register_Photo()
        ));
  }
  Future getCommericalmage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: StaticData.get_width(context)/3,
        maxWidth: StaticData.get_width(context)/3);

    setState(() {
      if (pickedFile != null) {
        setState(() {
          commerical_photo = File(pickedFile.path);
          sharedPreferenceManager.writeData(CachingKey.COMMERCIAL_PHOTO, commerical_photo.path);
        });
        print("delivery_photo---- : ${commerical_photo.path}");
      } else {
        print('No image selected.');
      }
    });
  }
}