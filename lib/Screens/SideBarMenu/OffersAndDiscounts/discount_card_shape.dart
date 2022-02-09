import 'package:procard_store/Model/Discount_Model/discount_model.dart';
import 'package:procard_store/Model/Home_Models/latest_card_model.dart' as latest_card_model;
import 'package:procard_store/Widgets/custom_favourite.dart';
import 'package:procard_store/fileExport.dart';
import 'package:procard_store/Model/Discount_Model/discount_model.dart' as discount_model ;
class DiscountCardShape extends StatefulWidget{
  discount_model.Data discountModel;
  final String discount;
  DiscountCardShape({this.discount,this.discountModel});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DiscountCardShapeState();
  }

}

class DiscountCardShapeState extends State<DiscountCardShape>{

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translator.currentLanguage =='ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
          padding: EdgeInsets.all(StaticData.get_width(context) * 0.03),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network('${widget.discountModel.card.logo}',
                    height: StaticData.get_width(context) * 0.30,),
                  CustomComponents.rowWithTwoItems(
                      context,
                      widget.discountModel.card.name,
                      translator.translate("Starting from")+ ' '+widget.discountModel.card.leastPrice.toString() + ' '+ translator.translate("SAR")
                  )
                ],
              ),
               Positioned(
                right:  StaticData.get_width(context) * 0.02,
                top: 10,
                child: Container(
                  padding: EdgeInsets.all(StaticData.get_width(context) * 0.01),
                  decoration: BoxDecoration(
                    color: yellowColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(' ${widget.discountModel.price}  ${translator.translate('SR')}',style: TextStyle(color: primary_color),),
                ),
              )
            ],
          )
      ),
    );
  }

}