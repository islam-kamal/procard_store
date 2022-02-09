import 'package:flutter/cupertino.dart';
import 'package:procard_store/Repository/NotificationsRepo/notifications_repository.dart';
import 'package:procard_store/Screens/Profile/Credit_Cards/credit_card_shape.dart';
import 'package:procard_store/Widgets/app_routing.dart';
import 'package:procard_store/Widgets/customText.dart';
import 'package:procard_store/fileExport.dart';

class CustomAppBar extends  StatefulWidget{
  final String text;
  final String page_name;
  final String  frist_image;
  final String second_image;
  final String logo;
  final Color color;

   CustomAppBar({this.text,this.page_name,this.frist_image=null,this.second_image=null,this.logo=null,this.color = whiteColor});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomAppBarState();
  }

}
class CustomAppBarState extends State<CustomAppBar>{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection:  translator.currentLanguage == 'ar'? TextDirection.rtl : TextDirection.ltr,
      child:  Container(
        child: Container(
          height: height * .10,
          color: widget.color,
          padding: EdgeInsets.only(
              left: width * .045, right: width * .045, top: height * .02,bottom: height * .02),
          child:  translator.currentLanguage == 'ar'?   Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              widget.frist_image ==null? translator.currentLanguage == 'ar' ? InkWell(
                onTap: (){
                  appRouting(
                      context: context,
                      page_name: widget.page_name
                  );
                },
                child: Image.asset('Assets/Images/skip.png',
                  color: widget.color == whiteColor ? primary_color  : whiteColor,),
              ) : InkWell(
                onTap: (){
                  appRouting(
                      context: context,
                      page_name: widget.page_name
                  );
                },
                child: Image.asset('Assets/Images/backlbl.png',
                  color: widget.color == whiteColor ? primary_color  : whiteColor,),
              )

                  : InkWell(
                onTap: (){
                  Scaffold.of(context).openEndDrawer();
                },
                child:Container(
                    child:  Image.asset( widget.frist_image)
                ),),
              Container(
                  width: StaticData.get_width(context) * 0.7,
                  alignment: Alignment.center,
                  child: widget.logo==null ?Wrap(
                    children: [
                      MyText(
                        text: widget.text,
                        size: ProdCardStoreFont.header_font_size,
                        weight: FontWeight.bold,
                        color: widget.color == whiteColor ? primary_color  : whiteColor ,
                      )
                    ],
                  ) :  Image.asset( widget.logo)
              ),
              InkWell(
                onTap: () {
                  appRouting(
                      context: context,
                      page_name: widget.page_name
                  );
                },
                child:  widget.second_image ==null? Container() :  InkWell(
                  onTap: ()async{
                    if(widget.text == 'remove_all_notifications'){
                      await notificationsRepository.remove_All_notification(
                        context: context,);
                    }else if(widget.text == translator.translate( "Credit Cards" )){
                      CreditCardWidget.credit_card_shape(context: context);

                  }else{
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) {
                            return Notifications();
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
                    }

                  },
                  child: Container(
                      child:  Image.asset( widget.second_image)
                  ),
                ),
              ),



            ],
          ) : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  appRouting(
                      context: context,
                      page_name: widget.page_name
                  );
                },
                child:  widget.second_image ==null? Container() :  InkWell(
                  onTap: ()async{
                    print("page name : ${widget.page_name}");
                    switch(widget.page_name){
                      case 'remove_all_notifications':
                        await notificationsRepository.remove_All_notification(
                          context: context,
                        );
                        break;
                      case "Credit Cards":
                      //add new credit card
                        CreditCardWidget.credit_card_shape(context: context);
                        break;
                      default:
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
                              return Notifications();
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
                    }




                  },
                  child: Container(
                      child:  Image.asset( widget.second_image)
                  ),
                ),
              ),

              Container(
                  width: StaticData.get_width(context) * 0.7,
                  alignment: Alignment.center,
                  child: widget.logo==null ?Wrap(
                    children: [
                      MyText(
                        text: widget.text,
                        size: ProdCardStoreFont.header_font_size,
                        weight: FontWeight.bold,
                        color: widget.color == whiteColor ? primary_color  : whiteColor ,
                      )
                    ],
                  ) :  Image.asset( widget.logo)
              ),

              widget.frist_image ==null? translator.currentLanguage == 'ar' ?  InkWell(
                onTap: (){
                  appRouting(
                      context: context,
                      page_name: widget.page_name
                  );
                },
                child: Image.asset('Assets/Images/backlbl.png',
                  color: widget.color == whiteColor ? primary_color  : whiteColor,),
              ) :
              InkWell(
                onTap: (){
                  appRouting(
                      context: context,
                      page_name: widget.page_name
                  );
                },
                child: Image.asset('Assets/Images/skip.png',
                  color: widget.color == whiteColor ? primary_color  : whiteColor,),
              )
                  : InkWell(
                onTap: (){
                  Scaffold.of(context).openEndDrawer();
                },
                child:Container(
                    child:  Image.asset( widget.frist_image)
                ),)


            ],
          ),
        ),
      ),
    );


  }

}