import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procard_store/Bloc/Notifications_Bloc/notifications_bloc.dart';
import 'package:procard_store/Model/Notifications_Model/notifications_model.dart';
import 'package:procard_store/Screens/Notifications/notification_shape.dart';
import 'package:procard_store/Widgets/Shimmer/list_shimmer.dart';
import 'package:procard_store/Widgets/Shimmer/shimmer_notification.dart';
import 'package:procard_store/Widgets/visitor_message.dart';
import 'package:procard_store/fileExport.dart';

class Notifications extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return NotificationsState();
  }

}

class NotificationsState extends State<Notifications>{

  @override
  void initState() {
    notificationsBloc.add(GetAllNotificationsEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return NetworkIndicator(
       child: PageContainer(
         child: WillPopScope(
           onWillPop: (){
             Navigator.pop(context);
           },
           child: (StaticData.vistor_value == 'visitor')
               ? VistorMessage() :Scaffold(
             body: Container(
               padding: EdgeInsets.all(StaticData.get_width(context)  * 0.01),
               child: Column(
                 children: [
                   //AppBar
                   Padding(
                     padding: EdgeInsets.only(top: StaticData.get_width(context)  * 0.05),
                     child:  CustomAppBar(
                       frist_image: 'Assets/Images/menu.png',
                       second_image: 'Assets/Images/delnot.png',
                       logo: 'Assets/Images/tlogo.png',
                       text: 'remove_all_notifications',
                       page_name: 'remove_all_notifications'
                     ),
                   ),

                   Container(
                     height: StaticData.get_height(context) * 0.80,
                     child: BlocBuilder(
                       bloc: notificationsBloc,
                       builder: (context, state) {
                         if (state is Loading) {
                           return ShimmerNotification(
                           );
                         } else if (state is Done) {
                           return StreamBuilder<List<NotificationsModel>>(
                               stream: notificationsBloc.notifications_subject,
                               builder: (context, snapshot) {
                                 if (snapshot.hasData) {
                                   if (snapshot.data.isEmpty) {
                                     return NoData(
                                       message: "No Notifications",
                                     );
                                   } else {
                                     return  ListView.builder(
                                         shrinkWrap: true,
                                         itemCount: snapshot.data.length,
                                         itemBuilder: (BuildContext context, int index) {
                                           return Container(
                                               margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                               alignment: Alignment.center,
                                               decoration: BoxDecoration(
                                                 color: Color(0xfff7f7f7),
                                                 borderRadius: BorderRadius.all(
                                                   Radius.circular(0),
                                                 ),
                                               ),
                                               child:  NotificationShape(
                                                 id: snapshot.data[index].id,
                                                 image: snapshot.data[index].image,
                                                 message: snapshot.data[index].body,
                                                 date: snapshot.data[index].createdAtFormated,
                                               )
                                           );
                                         });
                                   }
                                 } else {
                                   return ShimmerNotification(
                                   );
                                 }
                               });

                         } else if (state is ErrorLoading) {
                           return ShimmerNotification(
                           );

                         }else{
                           return Container();
                         }
                       },
                     ),
                   )

                 ],
               ),
             ),
             endDrawer: CustomComponents.sideBarMenu(context),

           ),
         ),
       ),
     );
  }

}