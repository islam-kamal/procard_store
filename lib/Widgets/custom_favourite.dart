
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procard_store/Bloc/Favourite_Bloc/favourite_bloc.dart';
import 'package:procard_store/fileExport.dart';

class CustomFauvourite extends StatefulWidget{
   bool favourite_status;
  final Color color;
  final int card_id;
  CustomFauvourite({this.favourite_status=false,this.color,this.card_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomFauvourite_State();
  }

}
class CustomFauvourite_State extends State<CustomFauvourite>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return    Padding(
        padding: EdgeInsets.only(
            bottom: StaticData.get_height(context)  * .14, left: StaticData.get_width(context) * .29,
            top: StaticData.get_height(context)  * 0.01),
        child: Container(
            child:(widget.favourite_status)?  IconButton(
                icon: Image.asset("Assets/Images/star_lg.png"),
                onPressed: (StaticData.vistor_value == 'visitor')? null:() async{
                  await  favourite_bloc.add(RemoveFavouriteEvent(
                    card_id: widget.card_id,
                  ));
                  setState(() {
                    widget.favourite_status= !widget.favourite_status;
                  });


                },
              )
            :  IconButton(
              icon:Image.asset("Assets/Images/star_lg_outline.png",color: Colors.white,),
              onPressed: (StaticData.vistor_value == 'visitor')? null: () {
              favourite_bloc.add(AddFavouriteEvent(
                  card_id: widget.card_id,
                ));
                setState(() {
                  widget.favourite_status = !widget.favourite_status;
                });
              },
            )
        ));
  }

}