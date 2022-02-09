import 'package:procard_store/fileExport.dart';
import 'package:procard_store/main.dart';
import 'package:procard_store/Repository/NotificationsRepo/notifications_repository.dart';
class ProfileSettings extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileSettingsState();
  }

}

class ProfileSettingsState extends State<ProfileSettings>{
  bool notification_value;
  @override
  void initState() {
    notification_value = false;
    sharedPreferenceManager.readBoolean(CachingKey.NOTIFICATIONS_STATUS).then((value) {
    setState(() {
      notification_value = value;
      print("notification_value : ${notification_value}");
    });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child:WillPopScope(
        onWillPop: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) {
            return ProfilePage();
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
          body: Directionality(
            textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            child: Column(
              children: [
                CustomAppBar(
                  text: translator.translate("Settings"),
                  page_name: 'ProfileSettings',
                ),
                disable_notifications(),
                Divider(
                  color: primary_color,
                  height: 2,
                  endIndent: 20,
                  indent: 20,
                ),
                change_language()
              ],
            ),
          ),
        ),)
      ),
    );
  }

  Widget disable_notifications(){
    return Padding(
        padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
              text: translator.translate("Disable Notifications"),
              size: ProdCardStoreFont.primary_font_size,
          color: primary_color,
          weight: FontWeight.bold,
          ),
          Switch(
            value: notification_value ,
            onChanged: (value) {
              setState(() async{
                notification_value = ! notification_value;
                print(notification_value);
                if(notification_value){
                  await notificationsRepository.disable_notification(
                    context: context,
                    text: 'mute'
                  );
                }else{
                  await notificationsRepository.disable_notification(
                      context: context,
                      text: 'unmute'
                  );
                }
              });
            },
            activeTrackColor: primary_color,
            activeColor: whiteColor,
          )
        ],
      ),
    );
  }

  Widget change_language(){
    return Padding(
        padding: EdgeInsets.all(20),
      child:  InkWell(
        onTap: (){
          change_language_bottom_sheet(context: context);
        },
        child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              MyText(
                text: translator.translate("App Language"),
                color: primary_color,
                size: ProdCardStoreFont.primary_font_size,
                weight: FontWeight.bold,
              ),
              MyText(
                text: translator.translate("App Language"),
                color: gray_color,
                size: ProdCardStoreFont.primary_font_size,
                weight: FontWeight.normal,
              ),
            ],
          ),
          Icon(
              Icons.arrow_forward_ios
            ),
          
        ],)
      ),
    );

  }
   void change_language_bottom_sheet({BuildContext context }) {
    showModalBottomSheet<void>(
        context: context,
        shape: OutlineInputBorder(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return Directionality(
              textDirection: translator.currentLanguage == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Container(
                  height: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.only(top: 10),
                  child:Column(
                    children: [
                      Center(
                        child: Column(children: [
                          MyText(
                            text: translator.translate("App Language"),
                            size: ProdCardStoreFont.header_font_size,
                            color: black_color,
                            weight: FontWeight.bold,
                          ),
                          MyText(
                            text:translator.translate( "Choose your preferred application language" ),
                            size: ProdCardStoreFont.primary_font_size,
                            color: gray_color,
                          )
                        ],),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: InkWell(
                                onTap: () {
                                  changeLang("ar");
                                  Navigator.pop(context);
                                },
                                child:  MyText(
                                  text: "العربية",
                                  size: ProdCardStoreFont.primary_font_size,
                                  color: black_color,
                                )
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () {
                                  changeLang("en");
                                  Navigator.pop(context);
                                },
                                child:    MyText(
                                  text: "ENGLISH",
                                  size: ProdCardStoreFont.primary_font_size,
                                  color: black_color,
                                ),
                              )),
                        ],
                      )
                    ],
                  )));
        });
  }

  void changeLang(String lang) async {
    setState(() {
      translator.setNewLanguage(
        context,
        newLanguage: '${lang}',
        remember: true,
        restart: false,
      );
    });

    MyApp.setLocale(context, Locale('${lang}'));

  }
}