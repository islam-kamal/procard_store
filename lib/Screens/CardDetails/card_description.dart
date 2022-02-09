
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:procard_store/Screens/CardDetails/card_details_screen.dart';
import 'package:procard_store/fileExport.dart';

class CardDescription extends StatefulWidget{
  final String charge;
  final int card_id;
  CardDescription({this.charge,this.card_id});
  @override
  State<StatefulWidget> createState() {
    return CardDescriptionState();
  }

}

class CardDescriptionState extends State<CardDescription>{
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          body: WillPopScope(
            onWillPop: (){
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return CardDetailsScreen(
                      card_id: widget.card_id,
                    );
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
            child: Container(
              padding: EdgeInsets.all(StaticData.get_width(context) * 0.01),
              child: Column(
                crossAxisAlignment: translator.currentLanguage == 'ar' ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  //AppBar
                  CustomAppBar(
                    text: translator.translate("Card Description"),
                    page_name: 'CardDescription',

                  ),
                  Padding(
                      padding:
                      EdgeInsets.only(left: StaticData.get_width(context) * 0.03 , right: StaticData.get_width(context) * 0.03
                          , top: StaticData.get_width(context) * 0.08),
                      child: MyText(
                        size: ProdCardStoreFont.header_font_size,
                        color: primary_color,
                        weight: FontWeight.bold,
                        align: translator.currentLanguage=='ar' ? TextAlign.right : TextAlign.left,
                        text: translator.translate("How do you charge a Careem card?"),
                      )),

                  Padding(
                      padding:
                      EdgeInsets.only(left: StaticData.get_width(context) * 0.03 , right: StaticData.get_width(context) * 0.03
                          , top: StaticData.get_width(context) * 0.08),
                      child: SingleChildScrollView(
                        child: Html(
                          data: widget.charge,
                          style: {
                            "body": Style(
                              fontSize: FontSize(16.0),
                              fontWeight: FontWeight.normal,
                              color: primary_color
                            ),
                          },
                        ),
                      ))

                ],
              ),
            ),
          ),
          endDrawer: CustomComponents.sideBarMenu(context),
        ),
      ),
    );
  }

}