
import 'package:flutter/material.dart';
import 'package:procard_store/fileExport.dart';
class QuestionAnswer extends StatefulWidget{
  final String question;
  final String answer;
  QuestionAnswer({this.question,this.answer});
  @override
  State<StatefulWidget> createState() {
    return QuestionAnswerState();
  }

}

class QuestionAnswerState extends State<QuestionAnswer>{
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
                  text: widget.question,
                   page_name: 'QuestionAnswer',

                ),
                Padding(
                    padding:
                    EdgeInsets.only(left: StaticData.get_width(context) * 0.03 , right: StaticData.get_width(context) * 0.03
                        , top: StaticData.get_width(context) * 0.08),
                    child: MyText(
                      size: ProdCardStoreFont.primary_font_size,
                      color: primary_color,
                      weight: FontWeight.normal,
                      align: translator.currentLanguage=='ar' ? TextAlign.right : TextAlign.left,
                      text: widget.answer,
                    )),


              ],
            ),
          ),
          endDrawer: CustomComponents.sideBarMenu(context),
        ),
      ),
    );
  }

}