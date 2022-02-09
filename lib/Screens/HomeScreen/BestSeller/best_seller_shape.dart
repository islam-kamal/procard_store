import 'package:procard_store/Model/Discount_Model/discount_model.dart';
import 'package:procard_store/Model/Home_Models/latest_card_model.dart' as latest_card_model;
import 'file:///D:/Ibtdi/Procard%20Store/code/procard_store/lib/Screens/CardDetails/card_details_screen.dart';
import 'package:procard_store/Widgets/custom_favourite.dart';
import 'package:procard_store/fileExport.dart';
import 'package:procard_store/Model/Discount_Model/discount_model.dart' as discount_model ;
import 'package:procard_store/Model/Home_Models/best_seller_model.dart' as best_seller_model;

class BestSellerShape extends StatefulWidget{
  best_seller_model.Data cardModel;
  BestSellerShape({this.cardModel,});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BestSellerShapeState();
  }

}

class BestSellerShapeState extends State<BestSellerShape>{

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translator.currentLanguage =='ar' ? TextDirection.rtl : TextDirection.ltr,
      child: InkWell(
        onTap: (){
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) {
            return CardDetailsScreen(
              card_id: widget.cardModel.id,
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
    child: Padding(
          padding: EdgeInsets.all(StaticData.get_width(context) * 0.01),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network('${widget.cardModel.logo}',
                    height: StaticData.get_width(context) * 0.30,),
                  CustomComponents.rowWithTwoItems(
                      context,
                      widget.cardModel.name,
                      translator.translate("Starting from")+ ' '+widget.cardModel.leastPrice.toString() + ' '+ translator.translate("SAR")
                  )
                ],
              ),
              Positioned(
                left: - StaticData.get_width(context) * 0.25,
                top: -5,
                child: CustomFauvourite(
                  color: yellowColor,
                  card_id: 1,
                  favourite_status: widget.cardModel.isFavorited,
                ),
              )
            ],
          )
    ) ),
    );
  }

}