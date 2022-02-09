import 'package:flutter/material.dart';
import 'package:procard_store/Model/Settings_Model/settings_model.dart';
import 'package:procard_store/fileExport.dart';
class TermsAndConditions extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TermsAndConditionsState();
  }

}

class TermsAndConditionsState extends State<TermsAndConditions>{
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(StaticData.get_width(context) * 0.01),
            child: Column(
              children: [
                //AppBar
              CustomAppBar(
                    frist_image: 'Assets/Images/menu.png',
                    second_image: 'Assets/Images/notifi.png',
                    text: translator.translate("Terms and Conditions"),

                ),
                Padding(
                    padding:
                    EdgeInsets.only(top: StaticData.get_width(context) * 0.05),
                    child: Image.asset('Assets/Images/shrotfull.png')),

               Container(
                 height: StaticData.get_width(context) * 0.95,
                 child:  SingleChildScrollView(
                   child: StreamBuilder<SettingsModel>(
                       stream: settingsBloc.settings_subject,
                       builder: (context,snapshot) {
                         if (snapshot.hasData) {
                           if (snapshot.data.data.isEmpty) {
                             return Container();
                           } else {
                             return Padding(
                                 padding:
                                 EdgeInsets.only(
                                     left: StaticData.get_width(context) * 0.03,
                                     right: StaticData.get_width(context) * 0.03
                                     ,
                                     top: StaticData.get_width(context) * 0.08),
                                 child: MyText(
                                   size: ProdCardStoreFont.primary_font_size,
                                   color: primary_color,
                                   weight: FontWeight.normal,
                                   align: translator.currentLanguage == 'ar'
                                       ? TextAlign.right
                                       : TextAlign.left,
                                   text: '${snapshot.data.data[2].content}',
                                 ));
                           }
                         } else {
                           return Center(
                             child: SpinKitFadingCircle(color: greenColor),
                           );
                         }
                       } ),
                 ),
               )
              ],
            ),
          ),
          endDrawer: CustomComponents.sideBarMenu(context),
        ),
      ),
    );
  }

}