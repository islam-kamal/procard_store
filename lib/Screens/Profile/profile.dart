import 'package:flutter/material.dart';
import 'package:procard_store/Model/Profile_Model/profile_staistics_model.dart';
import 'package:procard_store/Screens/Profile/Credit_Cards/credit_cards_screen.dart';
import 'package:procard_store/Screens/Profile/Orders_history/orders_history_page.dart';

import 'package:procard_store/Widgets/Shimmer/slider_shimmer.dart';
import 'package:procard_store/Widgets/custom_circle_navigation_bar.dart';
import 'package:procard_store/Widgets/visitor_message.dart';
import 'package:procard_store/fileExport.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {

    profileBloc.add(GetProfileStatistics());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
        child: PageContainer(
        child: WillPopScope(
        onWillPop: () async=>false,
    child:Scaffold(
      body:  Directionality(
    textDirection: translator.currentLanguage == 'ar'
    ? TextDirection.rtl
        : TextDirection.ltr,
    child: (StaticData.vistor_value == 'visitor')
    ? VistorMessage()
        :Container(
        padding: EdgeInsets.all(StaticData.get_width(context) * 0.01),
        child: ListView(
          children: [
            //AppBar
        CustomAppBar(
                page_name: 'RecommendationsPage',
                frist_image: 'Assets/Images/menu.png',
                second_image: 'Assets/Images/notifi.png',
                text: translator.translate("My Account"),
              ),

            Container(
                height: StaticData.get_height(context) * 0.77,
                child: build_body())
          ],
        ),
    )),
      bottomNavigationBar: CustomCircleNavigationBar(
        page_index: 4,
      ),

      endDrawer: CustomComponents.sideBarMenu(context),

    ))) );
  }

  Widget build_body() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        profile_statics(),
        FittedBox(
            child: Container(
              width: width,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(height * .05))),
              child: Column(
                children: [
                  SizedBox(
                    height: height * .03,
                  ),
                  singleSettingRow(
                    context: context,
                    text:  "personal information" ,
                    image:"Assets/Images/persona.png",
                    onTapFunction: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) {
                           // return EditMyProfile();
                          },
                          transitionsBuilder: (context, animation8, animation15, child) {
                            return FadeTransition(
                              opacity: animation8,
                              child: child,
                            );
                          },
                          transitionDuration: Duration(milliseconds: 10),
                        ),
                      );
                    }
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  singleSettingRow(
                      context: context,
                      text: "Wallet" ,
                      image:"Assets/Images/raseed.png",
                      onTapFunction: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
                             return WalletScreen();
                            },
                            transitionsBuilder: (context, animation8, animation15, child) {
                              return FadeTransition(
                                opacity: animation8,
                                child: child,
                              );
                            },
                            transitionDuration: Duration(milliseconds: 10),
                          ),
                        );
                      }
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  singleSettingRow(
                      context: context,
                      text:  "Orders List",
                      image:"Assets/Images/segl.png",
                      onTapFunction: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
                               return OrdersHistoryPage();
                            },
                            transitionsBuilder: (context, animation8, animation15, child) {
                              return FadeTransition(
                                opacity: animation8,
                                child: child,
                              );
                            },
                            transitionDuration: Duration(milliseconds: 10),
                          ),
                        );
                      }
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  singleSettingRow(
                      context: context,
                      text: "Credit Cards" ,
                      image:"Assets/Images/cards.png",
                      onTapFunction: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
                               return CreditCardsScreen();
                            },
                            transitionsBuilder: (context, animation8, animation15, child) {
                              return FadeTransition(
                                opacity: animation8,
                                child: child,
                              );
                            },
                            transitionDuration: Duration(milliseconds: 10),
                          ),
                        );
                      }
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  singleSettingRow(
                      context: context,
                      text: "Favorite",
                      image:"Assets/Images/favourite.png",
                      onTapFunction: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
                              //      return SearchPage();
                              return MyFavourites();
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
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  singleSettingRow(
                      context: context,
                      text:"Settings",
                      image:"Assets/Images/settings.png",
                      onTapFunction: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
                               return ProfileSettings();
                            },
                            transitionsBuilder: (context, animation8, animation15, child) {
                              return FadeTransition(
                                opacity: animation8,
                                child: child,
                              );
                            },
                            transitionDuration: Duration(milliseconds: 10),
                          ),
                        );
                      }
                  ),
                  SizedBox(
                    height: height * .03,
                  ),

                ],
              ),
            ))
      ],
    );
  }
}

Widget profile_statics() {
  return BlocBuilder(
    bloc: profileBloc,
    builder: (context, state) {
      if (state is Loading) {
         return SliderSimmer();
      } else if (state is Done) {
        return StreamBuilder<ProfileStaisticsModel>(
            stream: profileBloc.profile_statics_subject,
            builder: (context, snapshot) {

              if (snapshot.hasData) {
                if (snapshot.data.data==null) {
                  return NoData(
                    message:  translator.translate("There is no Data"),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(right: 10, left:10,top: 10),
                    child: Column(
                      children: [
                        Container(
                          color: pink_color,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child:
                                        Image.asset("Assets/Images/raseed.png"),
                                      ),
                                      Column(
                                        children: [
                                          MyText(
                                            text: 'العروض والخصومات',
                                            color: gray_color,
                                            weight: FontWeight.bold,
                                            size: ProdCardStoreFont
                                                .secondary_font_size,
                                          ),
                                          MyText(
                                            text:
                                            '${snapshot.data.data.offersCount}',
                                            color: gray_color,
                                            weight: FontWeight.normal,
                                            size: ProdCardStoreFont
                                                .primary_font_size,
                                          ),
                                        ],
                                      ),

                                    ],
                                  )
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child:
                                        Image.asset("Assets/Images/raseed.png"),
                                      ),
                                      Column(
                                        children: [
                                          MyText(
                                            text: 'رصيد محفظتك الحالى',
                                            color: gray_color,
                                            weight: FontWeight.bold,
                                            size: ProdCardStoreFont
                                                .primary_font_size,
                                          ),
                                          MyText(
                                            text:
                                            '${snapshot.data.data.walletBallance} ${translator.translate("SAR")}',
                                            color: gray_color,
                                            weight: FontWeight.normal,
                                            size: ProdCardStoreFont
                                                .primary_font_size,
                                          ),
                                        ],
                                      ),

                                    ],
                                  )),
                            ],
                          ),
                        ),
                        profile_statics_view(
                          context: context,
                          cards_number: snapshot.data.data.totalProducts,
                          suceeful_orders: snapshot.data.data.succesfullOrders,
                          order_average: snapshot.data.data.averageOrder,
                          total_purchase: snapshot.data.data.totalPayments,
                        )
                      ],
                    ),
                  );
                }
              } else {
                return SliderSimmer(

                );
              }
            });
      } else if (state is ErrorLoading) {
        return NoData(
          message: translator.translate("There is no Data"),
        );
      }
    },
  );

}

Widget profile_statics_view({BuildContext context,int cards_number , int total_purchase , int suceeful_orders , String order_average}){
  return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        //color: third_color,
      ),
      child: Container(
        width: StaticData.get_width(context),
        child: Stack(
          children: [
            Image.asset('Assets/Images/bg.png',
            height: StaticData.get_height(context) * 0.37,),
            Positioned(
                top: StaticData.get_width(context) *0.1,
              right: 0,
              left: 0,
              bottom: 0,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child:
                              Image.asset("Assets/Images/sells.png"),
                            ),
                            MyText(
                              text:
                              'إجمالي المشتريات',
                              color: gray_color,
                              weight: FontWeight.normal,
                              size: ProdCardStoreFont
                                  .secondary_font_size,
                            ),
                            MyText(
                              text:
                              '${total_purchase} ${translator.translate("SAR" )}',
                              color: gray_color,
                              weight: FontWeight.normal,
                              size: ProdCardStoreFont
                                  .secondary_font_size,
                            ),

                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child:
                              Image.asset("Assets/Images/cards.png"),
                            ),
                            MyText(
                              text:
                              'بطاقات قمت بشرائها',
                              color: gray_color,
                              weight: FontWeight.normal,
                              size: ProdCardStoreFont
                                  .secondary_font_size,
                            ),
                            MyText(
                              text:
                              '${cards_number} ',
                              color: gray_color,
                              weight: FontWeight.normal,
                              size: ProdCardStoreFont
                                  .secondary_font_size,
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                 Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child:  Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child:
                                Image.asset("Assets/Images/average.png"),
                              ),
                              MyText(
                                text:
                                'متوسط الطلب',
                                color: gray_color,
                                weight: FontWeight.normal,
                                size: ProdCardStoreFont
                                    .secondary_font_size,
                              ),
                              MyText(
                                text:
                                '${order_average} ${translator.translate("SAR" )}',
                                color: gray_color,
                                weight: FontWeight.normal,
                                size: ProdCardStoreFont
                                    .secondary_font_size,
                              ),

                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child:
                                Image.asset("Assets/Images/orders.png"),
                              ),
                              MyText(
                                text:
                                'طلبات تمت بنجاح',
                                color: gray_color,
                                weight: FontWeight.normal,
                                size: ProdCardStoreFont
                                    .secondary_font_size,
                              ),
                              MyText(
                                text:
                                '${suceeful_orders}',
                                color: gray_color,
                                weight: FontWeight.normal,
                                size: ProdCardStoreFont
                                    .secondary_font_size,
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),

                ],
              ),
            )

          ],
        ),
      )
  );
}


Widget singleSettingRow({BuildContext context ,String image, String text, onTapFunction}) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return InkWell(
    onTap: onTapFunction,
    child: Directionality(
      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: width * .05, right: width * .05),
            child: translator.currentLanguage == 'ar' ?   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      image,
                      height: height * .03,
                      color: fourth_color,
                    ),
                    SizedBox(width: width * 0.05,),
                    MyText(
                      text: translator.translate(text),
                      size: height * .02,
                      weight: FontWeight.normal,
                      color: black_color,
                    ),


                  ],
                ),
                Icon(Icons.arrow_forward_ios,size: 20,),
              ],
            ) : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_back_ios,size: 20,),
                Row(
                  children: [
                    MyText(
                      text: translator.translate(text),
                      size: height * .02,
                      weight: FontWeight.normal,
                      color: black_color,
                    ),
                    SizedBox(width: width * 0.05,),
                    Image.asset(
                      image,
                      height: height * .03,
                      color: fourth_color,
                    ),
                  ],
                )
              ],
            ) ,
          ),
          Divider(
            color: black_color,
            indent: 20,
            endIndent: 20,
          )
        ],
      ),
    ),
  );
}