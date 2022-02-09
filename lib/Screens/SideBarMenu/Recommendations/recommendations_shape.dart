import 'package:flutter/material.dart';
import 'package:procard_store/Widgets/customText.dart';
import 'package:procard_store/fileExport.dart';
class RecommendationsShape extends StatefulWidget{
  final String main_image;
  final String second_image;
  final String frist_text;
  final String second_text;
  final String third_text;
  RecommendationsShape({this.main_image,this.second_image,this.frist_text,this.second_text,this.third_text});
  @override
  State<StatefulWidget> createState() {
    return RecommendationsShapeState();
  }

}

class RecommendationsShapeState extends State<RecommendationsShape>{
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: StaticData.get_width(context) * 0.55,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(left: StaticData.get_width(context) * 0.01 , right: StaticData.get_width(context) * 0.01),
                      child: Column(
                        children: [
                          CustomComponents.rowWithTwoItems(context, widget.frist_text, widget.second_text),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MyText(
                                text: widget.third_text,
                                color: primary_color,
                                weight: FontWeight.normal,
                                size: ProdCardStoreFont.secondary_font_size,
                              ),
                              SizedBox(width: 5,),
                              Image.asset(widget.second_image),
                            ],
                          )
                        ],
                      ),
                    )
                ),
                Expanded(
                  flex: 1,
                  child: Image.network(widget.main_image),
                ),

              ],
            ),
            Divider(color: primary_color,thickness: 0.5,)
          ],
        )
    );
  }

}