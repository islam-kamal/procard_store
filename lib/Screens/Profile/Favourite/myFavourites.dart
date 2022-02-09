
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procard_store/Bloc/Favourite_Bloc/favourite_bloc.dart';
import 'package:procard_store/Model/FavouriteModel/favourite_model.dart';
import 'package:procard_store/Screens/Profile/Favourite/fav_card_shape.dart';
import 'package:procard_store/Widgets/Shimmer/list_shimmer.dart';
import 'package:procard_store/Widgets/visitor_message.dart';
import 'package:procard_store/fileExport.dart';

class MyFavourites extends StatefulWidget {
  @override
  _MyFavouritesState createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favourite_bloc.add(GetAllFavouriteEvent());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child: WillPopScope(
              onWillPop: (){
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return HomeScreen();
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
              child: Directionality(
                  textDirection: translator.currentLanguage == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: (StaticData.vistor_value == 'visitor')
                      ? VistorMessage() :Scaffold(
                    backgroundColor: whiteColor,
                    body:   (StaticData.vistor_value == 'visitor')
                        ? VistorMessage() :Container(
                        child: Column(children: [
                          // topPart(),
                          CustomAppBar(
                            text: translator.translate("Favourite"),
                            page_name: 'MyFavourites',
                          ),
                          SizedBox(
                            height: height * .0,
                          ),
                          Expanded(
                              child: Container(
                                  color: whiteColor, child: gridView()))
                        ])),

                  )),
            )));
  }


  Widget gridView() {
    return BlocBuilder(
      bloc: favourite_bloc,
      builder: (context, state) {
        //  var data = state.model as FavouriteListModel;
        if (state is Loading) {
          return Center(
            child: SpinKitFadingCircle(color: greenColor),
          );
        } else if (state is Done) {
          return StreamBuilder<List<FavouriteModel>>(
              stream: favourite_bloc.fav_subject,
              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  if (snapshot.data.isEmpty) {
                    return NoData(
                      message: translator.translate("There is no Favourites"),
                    );
                  } else {
                    return GridView.builder(
                        itemCount: snapshot.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .6995,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          print("card--- : ${snapshot.data[index].card}");
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
                            child:  FavCardShape(
                              cardModel: snapshot.data[index].card,
                            )
                          );
                        });
                  }
                } else {
                  return ListShimmer(
                    type: 'grid_view',
                  );
                }
              });
        } else if (state is ErrorLoading) {
          return NoData(
            message: 'no favourite',
          );
        }
      },
    );
  }

  Widget redDotOverNotificationsIcon() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: height > width ? width * .1 : width * .085,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: height > width ? width * .02 : width * .005,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                padding: EdgeInsets.only(top: height * .06),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
