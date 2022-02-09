import 'package:flutter/material.dart';
import 'package:procard_store/Widgets/customText.dart';
import 'package:procard_store/fileExport.dart';
class BankAccountShape extends StatefulWidget{
  final String bank_image;
  final String bank_name;
  final String account_number;
  final String iban_number;
  BankAccountShape({this.bank_image,this.bank_name,this.account_number,this.iban_number,});
  @override
  State<StatefulWidget> createState() {
    return BankAccountShapeState();
  }

}

class BankAccountShapeState extends State<BankAccountShape>{
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: StaticData.get_width(context) * 0.35,
        width: StaticData.get_width(context),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(left: StaticData.get_width(context) * 0.01 , right: StaticData.get_width(context) * 0.01),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                text: widget.bank_name,
                                color: primary_color,
                                weight: FontWeight.normal,
                                size: ProdCardStoreFont.secondary_font_size,
                              ),
                              SizedBox(width: 5,),
                              MyText(
                                text: translator.translate("Bank Name"),
                                color: primary_color,
                                weight: FontWeight.normal,
                                size: ProdCardStoreFont.secondary_font_size,
                              ),


                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                text: widget.account_number,
                                color: primary_color,
                                weight: FontWeight.normal,
                                size: ProdCardStoreFont.secondary_font_size,
                              ),
                              SizedBox(width: 5,),
                              MyText(
                                text: translator.translate("Account Number"),
                                color: primary_color,
                                weight: FontWeight.normal,
                                size: ProdCardStoreFont.secondary_font_size,
                              ),


                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                text: widget.iban_number,
                                color: primary_color,
                                weight: FontWeight.normal,
                                size: ProdCardStoreFont.secondary_font_size,
                              ),
                              SizedBox(width: 5,),
                              MyText(
                                text: translator.translate("Iban Number"),
                                color: primary_color,
                                weight: FontWeight.normal,
                                size: ProdCardStoreFont.secondary_font_size,
                              ),


                            ],
                          )
                        ],
                      ),
                    )
                ),
                Expanded(
                  flex: 1,
                  child: Image.network(widget.bank_image),
                ),

              ],
            ),
            Divider(color: primary_color,thickness: 0.3,)
          ],
        )
    );
  }

}