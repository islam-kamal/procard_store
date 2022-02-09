import 'package:procard_store/Widgets/Shimmer/shimmer_notification.dart';
import 'package:procard_store/Widgets/visitor_message.dart';
import 'package:procard_store/fileExport.dart';
import 'package:procard_store/Bloc/Orders_Bloc/orders_bloc.dart';
import 'package:procard_store/Model/Orders_Model/orders_model.dart';



class OrdersHistoryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrdersHistoryPageState();
  }

}

class OrdersHistoryPageState extends State<OrdersHistoryPage> {

  @override
  void initState() {
    ordersBloc.add(GetAllOrdersEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return NetworkIndicator(
        child: PageContainer(
            child: WillPopScope(
              onWillPop: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return ProfilePage();
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
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Directionality(
                    textDirection: translator.currentLanguage == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: (StaticData.vistor_value == 'visitor')
                        ? VistorMessage()
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                        padding: EdgeInsets.only(
                            left: width * .045, right: width * .045, top: height * .02,bottom: height * .02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation1, animation2) {
                                      return ProfilePage();
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
                              child: Image.asset("Assets/Images/skip.png",color: primary_color,),
                            ),
                            MyText(
                                text: translator.translate( "Orders History" ),
                                size: ProdCardStoreFont.header_font_size,
                              weight: FontWeight.bold,
                              color: primary_color,
                  ),
                    InkWell(
                      onTap: (){
                        //filter orders
                        CustomComponents.filterByStatusBottomSheet(
                          context: context,
                          data: [ "Waiting", "Done","Cancelled" ],
                        );
                      },
                      child: Image.asset("Assets/Images/filter.png",color: yellowColor,),)
                          ],
                        ) ),
                        SizedBox(
                          height: height * .01,
                        ),
                      Container(
                          height: height * 0.9,
                          child:   build_body())

                      ],
                    ),
                  ),
                ),
              ),
            )));
  }

  Widget build_body(){
    return BlocBuilder(
      bloc: ordersBloc,
      builder: (context, state) {
        if (state is Loading) {
          return ShimmerNotification(
          );
        } else if (state is Done) {
          return StreamBuilder<List<OrdersModel>>(
              stream: ordersBloc.orders_subject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isEmpty) {
                    return Center(
                      child: NoData(
                        message: "No orders",
                      ),
                    );
                  } else {
                    return  ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          print("ordersBloc.radio_choosed_value.value : ${ordersBloc.radio_choosed_value.value}");
                          if(ordersBloc.radio_choosed_value.value == null){
                            print("-------- 1----");

                            return InkWell(
                              onTap: (){
                                print("####### status ###### ${snapshot.data[index].status}");
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation1, animation2) {
                                      return OrderDetails(
                                         order_details: snapshot.data[index],
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
                              child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xfff7f7f7),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                  ),
                                  child:  order_shape(
                                    order_number: snapshot.data[index].id,
                                    price: snapshot.data[index].totalPrice,
                                    status: snapshot.data[index].status,
                                    date: snapshot.data[index].createdAt,
                                    products:  snapshot.data[index].products,
                                  )
                              ),
                            );
                          }else{
                            if(ordersBloc.radio_choosed_value.value ==snapshot.data[index].status){
                              print("----- 2 -------");

                              return InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation1, animation2) {
                                          return OrderDetails(
                                            order_details: snapshot.data[index],
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
                                  child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xfff7f7f7),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                  ),
                                  child:  order_shape(
                                    order_number: snapshot.data[index].id,
                                    price: snapshot.data[index].totalPrice,
                                    status: snapshot.data[index].status,
                                    date: snapshot.data[index].createdAt,
                                    products:  snapshot.data[index].products,
                                  )
                              ));
                            }else{
                              print("------ 3 ------");
                            /*  return NoData(
                                message: translator.translate("there is no orders avaliable now"),
                              );*/
                            return Container();
                            }
                          }

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
    );
  }

  Widget order_shape ({int order_number , String price ,String status , String date , List<Products> products}){
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Image.asset('Assets/Images/hist.png')
        ),
        Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
    padding: EdgeInsets.all(10),
    child:   MyText(
                    text: "${order_number}#",
                    size: ProdCardStoreFont.header_font_size,
                  color: primary_color,
                weight: FontWeight.bold,),),
            Padding(
              padding: EdgeInsets.only(right: 10,left: 10),
              child:  MyText(
                  text: "${price} ${translator.translate("SAR")}",
                  size: ProdCardStoreFont.primary_font_size,
                  color: primary_color,
                  weight: FontWeight.normal,),),
            Padding(
              padding: EdgeInsets.all(10),
              child:  ListView.builder(
                   itemCount: products.length,
                  shrinkWrap: true,
                  itemBuilder: (context , index){
                     return Row(
                       children: [
                         MyText(
                           text: "${products[index].name}",
                           size: ProdCardStoreFont.primary_font_size,
                           color: primary_color,
                           weight: FontWeight.normal,),
                         SizedBox(
                           width: width * 0.05,
                         ),
                         MyText(
                           text: "${products[index].priceAfterDiscount} ${translator.translate("SAR")}",
                           size: ProdCardStoreFont.secondary_font_size,
                           color: primary_color,
                           weight: FontWeight.normal,),
                       ],
                     );
                  },

                ),),
            Row(

                    children: [
                      Container(
                          width: StaticData.get_width(context) * 0.3,
                          height: StaticData.get_width(context) * .1,
                          alignment: FractionalOffset.center,
                          decoration: BoxDecoration(
                            color: yellowColor,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Text(
                            status,
                            style: const TextStyle(
                              color: primary_color,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.3,
                            ),
                          )),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      MyText(
                        text: "${date.substring(0,16)}",
                        size: ProdCardStoreFont.secondary_font_size,
                        color: primary_color,
                        weight: FontWeight.normal,),
                    ],
                  ),

              ],
            )
        ),
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: (){
                CustomComponents.order_procedures(
                    context : context,
                    order_number: order_number,
                  status: status,
                  price: price,
                  products: products,
                  date: date
                );
              },
              child: Image.asset('Assets/Images/list.png'),
            )
        )
      ],
    );
  }
}