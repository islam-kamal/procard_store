import 'package:procard_store/Model/FavouriteModel/favourite_model.dart' as fav_card_model;
import 'package:procard_store/Widgets/custom_favourite.dart';
import 'package:procard_store/fileExport.dart';

class FavCardShape extends StatefulWidget{
  fav_card_model.Card cardModel;
  final String discount;
  FavCardShape({this.cardModel,this.discount});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FavCardShapeState();
  }

}

class FavCardShapeState extends State<FavCardShape>{

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translator.currentLanguage =='ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.all(StaticData.get_width(context) * 0.01),
        child: Stack(
          children: [
            Column(
              children: [
                widget.cardModel==null? Image.asset('Assets/Images/careem.png') :Image.network('${widget.cardModel.logo}',
                height: StaticData.get_width(context) * 0.34,),
                CustomComponents.rowWithTwoItems(
                    context,
                    widget.cardModel==null? ' ' : widget.cardModel.name,
                    widget.cardModel==null? '':  widget.cardModel.types.isEmpty ?
                   '':  translator.translate("Starting from")+ ' '+widget.cardModel.leastPrice.toString() + ' '+ translator.translate("SAR")
                )
              ],
            ),
            widget.discount ==null? Positioned(
              left: - StaticData.get_width(context) * 0.3,
              top: -10,
              child: CustomFauvourite(
                color: yellowColor,
                card_id: 1,
               favourite_status: widget.cardModel==null? false: widget.cardModel.isFavorited,
              ),
            ) : Positioned(
              right:  StaticData.get_width(context) * 0.01,
              top: 10,
              child: Container(
                padding: EdgeInsets.all(StaticData.get_width(context) * 0.01),
                decoration: BoxDecoration(
                  color: yellowColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text('% ${widget.discount}',style: TextStyle(color: primary_color),),
              ),
            )
          ],
        )
      ),
    );
  }

}