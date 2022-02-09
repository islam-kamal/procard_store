import 'package:procard_store/Model/Notifications_Model/notifications_model.dart';
import 'package:procard_store/Repository/NotificationsRepo/notifications_repository.dart';
import 'package:procard_store/fileExport.dart';

class NotificationShape extends StatefulWidget{
  final String image;
  final String message;
  final String date;
  final String id;
  NotificationsModel notificationsModel;
  NotificationShape({this.id,this.image,this.date,this.message,this.notificationsModel});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NotificationShapeState();
  }

}

class NotificationShapeState extends State<NotificationShape>{
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(StaticData.get_width(context)  * 0.02),
    child: Container(
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: ()async{
                  await notificationsRepository.remove_notification(
                    context: context,
                      notification_id: widget.id
                  );
                },
                child: Container(
                  child: widget.image==null?Image.asset("Assets/Images/delnot.png",color:Colors.red,fit: BoxFit.none,)
                      : Image.network(widget.image,fit: BoxFit.fill),
                ),
              )
          ),
          Expanded(
            flex: 3,
            child:  Padding(
              padding: EdgeInsets.only(right: 5,left: 5),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: translator.currentLanguage =='ar'? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                MyText(
                  text: widget.message==null? '' : widget.message,
                  color: primary_color,
                  weight: FontWeight.bold,
                  size: ProdCardStoreFont.primary_font_size,
                   align: translator.currentLanguage =='ar'? TextAlign.end : TextAlign.start,
                ),
              Row(
                  mainAxisAlignment: translator.currentLanguage =='ar'? MainAxisAlignment.start : MainAxisAlignment.end,

                  children: [
                    MyText(
                      text: widget.date ==null ? ' ' :widget.date,
                      color: primary_color,
                      weight: FontWeight.normal,
                      size: ProdCardStoreFont.secondary_font_size,
                    ),
                    Image.asset("Assets/Images/sprivacy.png",width: 30,),
                  ],
                ),

              ],
            ),    )
          ),

          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(50),
                color: yellowColor
              ),
              width: StaticData.get_width(context) * 0.02,
              height: StaticData.get_width(context) * 0.2,
              child: widget.image==null?Image.asset("Assets/Images/notifi.png",color:Colors.black,fit: BoxFit.none,)
                  : Image.network(widget.image,fit: BoxFit.fill),
            )
          ),
        ],
      ),
    ));
  }

}