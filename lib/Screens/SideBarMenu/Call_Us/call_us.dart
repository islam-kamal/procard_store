import 'package:flutter/material.dart';
import 'package:procard_store/fileExport.dart';
import 'package:procard_store/Bloc/CallUs_Bloc/call_us_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:procard_store/Model/Settings_Model/social_model.dart';

class CallUs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CallUsState();
  }
}

class CallUsState extends State<CallUs> with TickerProviderStateMixin {
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
    settingsBloc.add(AppSocialEvent());
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
      body: BlocListener<CallUsBloc, AppState>(
          bloc: callUsBloc,
          listener: (context, state) async {
            var data = state.model as GeneralResponseModel;
            if (state is Loading) {
              _playAnimation();
            } else if (state is Done) {
              _stopAnimation();
              errorDialog(
                  context: context,
                  text: data.message,
                  function: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => super.widget));
                  });
            } else if (state is ErrorLoading) {
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
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(StaticData.get_width(context) * 0.01),
                child: Column(
                  children: [
                    //AppBar
                    CustomAppBar(
                      page_name: 'RecommendationsPage',
                      frist_image: 'Assets/Images/menu.png',
                      second_image: 'Assets/Images/notifi.png',
                      logo: 'Assets/Images/tlogo.png',
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: StaticData.get_width(context) * 0.1),
                        child: Image.asset('Assets/Images/logoinfo.png')),
                    Padding(
                        padding: EdgeInsets.only(
                            top: StaticData.get_width(context) * 0.1),
                        child: Column(
                          children: [
                            name_textfield(),
                            SizedBox(
                              height: StaticData.get_width(context) * 0.05,
                            ),
                            email_textfield(),
                            SizedBox(
                              height: StaticData.get_width(context) * 0.05,
                            ),
                            message_textfield(),
                            SizedBox(
                              height: StaticData.get_width(context) * 0.1,
                            ),
                          ],
                        )),
                    sendMessageButton(),
                    SizedBox(height: StaticData.get_width(context) * 0.05,),
                    call_us_text(),
                    SizedBox(height: StaticData.get_width(context) * 0.05,),
                    social_links()
                  ],
                ),
              ),
            ),
          )),
      endDrawer: CustomComponents.sideBarMenu(context),
    )));
  }

  Widget name_textfield() {
    return StreamBuilder<String>(
      stream: callUsBloc.name,
      builder: (context, snapshot) {
        return Padding(
            padding: EdgeInsets.only(
                right: StaticData.get_width(context) * 0.02,
                left: StaticData.get_width(context) * 0.02),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("Full Name *"),
              iconData: Icons.person_outline,
              onchange: callUsBloc.name_change,
              suffixIcon: null,
              color: primary_color,
              errorText: snapshot.error,
              inputType: TextInputType.name,
            ));
      },
    );
  }

  Widget email_textfield() {
    return StreamBuilder<String>(
        stream: callUsBloc.email,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(
                right: StaticData.get_width(context) * 0.02,
                left: StaticData.get_width(context) * 0.02),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("Email"),
              iconData: Icons.email,
              color: primary_color,
              onchange: callUsBloc.email_change,
              suffixIcon: null,
              errorText: snapshot.error,
              inputType: TextInputType.emailAddress,
            ),
          );
        });
  }

  Widget message_textfield() {
    return StreamBuilder<String>(
        stream: callUsBloc.message,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(
                right: StaticData.get_width(context) * 0.02,
                left: StaticData.get_width(context) * 0.02),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("Message Text"),
              iconData: Icons.edit_outlined,
              max_lines: 4,
              onchange: callUsBloc.message_change,
              suffixIcon: null,
              color: primary_color,
              errorText: snapshot.error,
              inputType: TextInputType.text,
            ),
          );
        });
  }

  Widget sendMessageButton() {
    return StaggerAnimation(
      context: context,
      titleButton: translator.translate("Send Message"),
      buttonController: _loginButtonController.view,
      btn_color: primary_color,
      text_color: whiteColor,
      onTap: () {
        callUsBloc.add(CallUsEvent());
      },
    );
  }

  Widget call_us_text(){
    return Center(
      child: MyText(
        text: translator.translate("Contact With Us Through"),
        size: ProdCardStoreFont.primary_font_size,
        color: primary_color,
      ),
    );
  }
  
  Widget social_links(){
   return BlocBuilder(
     bloc: settingsBloc,
     builder: (context,state){
       if(state is Loading){
         return Center(child: SpinKitFadingCircle(
           itemBuilder: (BuildContext context, int index) {
             return DecoratedBox(
               decoration: BoxDecoration(
                 color: index.isEven ? primary_color : whiteColor,
               ),
             );
           },
         ));
       }else if(state is Done){
         var data = state.model as SocialModel;
         return Center(
           child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               InkWell(
                 onTap: (){
                   print("facebook : ${data.data.social.facebook}");
                   _launchURL('${data.data.social.facebook}');
                 },
                 child: Image.asset('Assets/Images/facebook.png'),
               ),
               SizedBox(width: StaticData.get_width(context) * 0.05,),
               InkWell(
                 onTap: (){
                   print("whatsapp : ${data.data.contacts.phones[0]}");
                   _launchURL(
                       'https://api.whatsapp.com/send?phone=${data.data.contacts.phones[0]}');
                 },
                 child:Image.asset('Assets/Images/whats.png'),
               )
             ],
           ),
         );
       }else if(state is ErrorLoading){
         return Container();
       }
     },
   );
  }
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
