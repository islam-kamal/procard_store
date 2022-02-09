import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procard_store/Bloc/Recommednations_Bloc/recommendations_bloc.dart';
import 'package:procard_store/Model/Recommendations_Model/recommendations_model.dart';
import 'package:procard_store/Screens/SideBarMenu/Recommendations/recommendations_shape.dart';
import 'package:procard_store/Widgets/Shimmer/list_shimmer.dart';
import 'package:procard_store/Widgets/Shimmer/shimmer_notification.dart';
import 'package:procard_store/fileExport.dart';
class RecommendationsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RecommendationsPageState();
  }

}

class RecommendationsPageState extends State<RecommendationsPage>{

  @override
  void initState() {
    recommendationsBloc.add(GetAllRecommendationsEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
        child: PageContainer(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(StaticData.get_width(context)  * 0.01),
        child: Column(
          children: [
            //AppBar
           Padding(
             padding: EdgeInsets.only(top: StaticData.get_width(context)  * 0.05),
             child:  CustomAppBar(
               page_name: 'RecommendationsPage',
               frist_image: 'Assets/Images/menu.png',
               second_image: 'Assets/Images/notifi.png',
               logo: 'Assets/Images/tlogo.png',
             ),
           ),
            Container(
              height: StaticData.get_height(context) * 0.80,
              child:   build_body()
            )

          ],
        ),
      ),
      endDrawer: CustomComponents.sideBarMenu(context),

    )));
  }

  Widget build_body(){
    return BlocBuilder(
      bloc: recommendationsBloc,
      builder: (context, state) {
        if (state is Loading) {
          return ShimmerNotification();
        } else if (state is Done) {
          return StreamBuilder<List<RecommendationsModel>>(
              stream: recommendationsBloc.recommendation_subject,
              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  if (snapshot.data.isEmpty) {
                    return ShimmerNotification(
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {

                          return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xfff7f7f7),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              child:  RecommendationsShape(
                                main_image: '${snapshot.data[index].logo}',
                                second_image: 'Assets/Images/shahid.png',
                                frist_text: '${snapshot.data[index].title}',
                                second_text: '${snapshot.data[index].description}',
                                third_text: '${snapshot.data[index].url}',
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
          return NoData(
            message: 'no favourite',
          );
        }else{
          return Container();
        }
      },
    );
  }
}