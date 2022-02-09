import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procard_store/Bloc/Home_Bloc/latest_cards_bloc.dart';
import 'package:procard_store/Bloc/Search_Bloc/search_bloc.dart';
import 'package:procard_store/Model/Home_Models/best_seller_model.dart';
import 'package:procard_store/Model/Home_Models/latest_card_model.dart';
import 'package:procard_store/Screens/HomeScreen/BestSeller/best_seller_shape.dart';
import 'package:procard_store/Widgets/Shimmer/list_shimmer.dart';
import 'package:procard_store/fileExport.dart';

class CardView extends StatefulWidget{
  final String view_type;
  final String type;
  CardView({this.view_type , this.type});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CardViewState();
  }

}

class CardViewState extends State<CardView>{
  @override
  void initState() {
    latestCardsBloc.add(GetLatestCardsEvent());
    bestSellerBloc.add(GetBestSellerEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    switch(widget.type){
      case 'latest_cards':
        return widget.view_type == 'horizontal_ListView' ?
        BlocBuilder(
          bloc: latestCardsBloc,
          builder: (context, state) {
            if (state is Loading) {
              return ListShimmer(
                type: 'horizontal',
              );
            } else if (state is Done) {
              if(state.indicator == 'latest_cards'){
                return StreamBuilder<LatestCardsModel>(
                    stream: latestCardsBloc.latest_cards_subject,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.data.isEmpty) {
                          return ListShimmer(
                            type: 'horizontal',
                          );
                        } else {
                          return  ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (context,index){
                                return CardShape(
                                  cardModel: snapshot.data.data[index],
                                );
                              });
                        }
                      } else {
                        return ListShimmer(
                          type: 'horizontal',
                        );
                      }
                    });
              }
            } else if (state is ErrorLoading) {
              if(state.indicator == 'latest_cards'){
                return ListShimmer(
                  type: 'horizontal',
                );
              }

            }else{
              return Container();
            }
          },
        )
            : BlocBuilder(
          bloc: latestCardsBloc,
          builder: (context, state) {
            if (state is Loading) {
              return ListShimmer(
                type: 'grid_view',
              );
            } else if (state is Done) {
              if(state.indicator == 'latest_cards'){
                return StreamBuilder<LatestCardsModel>(
                    stream: latestCardsBloc.latest_cards_subject,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.data.isEmpty) {
                          return ListShimmer(
                            type: 'grid_view',
                          );
                        } else {
                          return  GridView.builder(
                              itemCount: snapshot.data.data.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: .9000,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color(0xfff7f7f7),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                    ),
                                    child:  CardShape(
                                      cardModel: snapshot.data.data[index],
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
              }
            } else if (state is ErrorLoading) {
              if(state.indicator == 'latest_cards'){
                return ListShimmer(
                  type: 'grid_view',
                );
              }

            }else{
              return Container();
            }
          },
        );
        break;
      case 'best_seller':
        return widget.view_type == 'horizontal_ListView' ?
        BlocBuilder(
          bloc: bestSellerBloc,
          builder: (context, state) {
            if (state is Loading) {
              return ListShimmer(
                type: 'horizontal',
              );
            } else if (state is Done) {
              if(state.indicator == 'best_seller'){
                return StreamBuilder<BestSellerModel>(
                    stream: bestSellerBloc.best_seller_subject,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.data.isEmpty) {
                          return ListShimmer(
                            type: 'horizontal',
                          );
                        } else {
                          return  ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (context,index){
                                return BestSellerShape(
                                  cardModel: snapshot.data.data[index],
                                );
                              });
                        }
                      } else {
                        return ListShimmer(
                          type: 'horizontal',
                        );
                      }
                    });
              }
            } else if (state is ErrorLoading) {
              if(state.indicator == 'best_seller'){
                return ListShimmer(
                  type: 'horizontal',
                );
              }

            }else{
              return Container();
            }
          },
        )
            : BlocBuilder(
          bloc: bestSellerBloc,
          builder: (context, state) {
            if (state is Loading) {
              return ListShimmer(
                type: 'grid_view',
              );
            } else if (state is Done) {
              if(state.indicator == 'best_seller'){
                return StreamBuilder<BestSellerModel>(
                    stream: bestSellerBloc.best_seller_subject,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.data.isEmpty) {
                          return ListShimmer(
                            type: 'grid_view',
                          );
                        } else {
                          return  GridView.builder(
                              itemCount: snapshot.data.data.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: .9000,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color(0xfff7f7f7),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                    ),
                                    child:  BestSellerShape(
                                      cardModel: snapshot.data.data[index],
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
              }
            } else if (state is ErrorLoading) {
              if(state.indicator == 'best_seller'){
                return ListShimmer(
                  type: 'grid_view',
                );
              }

            }else{
              return Container();
            }
          },
        );
        break;

    }

  }

}