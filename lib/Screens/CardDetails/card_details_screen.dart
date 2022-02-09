
import 'package:procard_store/Base/Database/DB_Helper.dart';
import 'package:procard_store/Base/Database/Product.dart';
import 'package:procard_store/Bloc/Favourite_Bloc/favourite_bloc.dart';
import 'package:procard_store/Model/Card_Details_model/card_details_model.dart';
import 'package:procard_store/Model/Card_Details_model/card_details_model.dart' as card_model;
import 'package:procard_store/Screens/CardDetails/card_description.dart';
import 'package:procard_store/Widgets/Shimmer/slider_shimmer.dart';
import 'package:procard_store/fileExport.dart';
import 'package:procard_store/Model/Card_Details_model/countries_model.dart';
import 'package:procard_store/Bloc/Card_Details_bloc/card_details_bloc.dart';

class CardDetailsScreen extends StatefulWidget{
  final int card_id;
  CardDetailsScreen({this.card_id});
  @override
  State<StatefulWidget> createState() {
    return CardDetailsScreenState();
  }

}

class CardDetailsScreenState extends State<CardDetailsScreen>{
bool is_favorited = false;
int _selected_country_Index;
int _selected_type_Index;

int category_id;
int country_id;
int type_id;
int qty;
int main_quantity;
double card_price;
var _cart_status = 0;
var _order_status = 0;


_onSelected(int index) {
  setState(() {
    _selected_country_Index = index;
  });
}
_onSelected_type(int index) {
  setState(() {
    _selected_type_Index = index;
  });
}
  @override
  void initState() {
  qty = 0;
  main_quantity = 0;
  card_price = 0;

  cardDetailsBloc.add(GetCardDetailsEvent(card_id: widget.card_id));
  cardDetailsBloc.add(GetCountriesEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return NetworkIndicator(
     child: PageContainer(
       child:Scaffold(
         body: WillPopScope(
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
           child: SingleChildScrollView(
             child: Directionality(
                 textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                 child: BlocBuilder(
                   bloc: cardDetailsBloc,
                   builder: (context, state) {
                     if (state is Loading) {
                       return Center(
                         child: SliderSimmer(
                         ),
                       );
                     } else if (state is Done) {
                       return StreamBuilder<CardDetailsModel>(
                           stream: cardDetailsBloc.card_details_subject,
                           builder: (context, snapshot) {
                             if (snapshot.hasData) {
                               if (snapshot.data.data ==null) {
                                 return SliderSimmer(
                                 );
                               } else {
                                 return  Column(
                                   children: [
                                     page_appbar(
                                         is_favorited: snapshot.data.data.isFavorited,
                                         name: snapshot.data.data.name
                                     ),
                                     card_image(
                                         image: snapshot.data.data.logo,
                                         price: snapshot.data.data.leastPrice.toString(),
                                         flag: snapshot.data.data.types.isEmpty ? '' : snapshot.data.data.types[0].country.flag
                                     ),
                                     card_details_text(
                                       name: snapshot.data.data.name,
                                       description: snapshot.data.data.description,
                                       code: snapshot.data.data.code,
                                       category: snapshot.data.data.section
                                     ),
                                     Divider(color: primary_color,height: 3,endIndent: 10,indent: 10,),
                                     card_countries(),
                                     Divider(color: primary_color,height: 3,endIndent: 10,indent: 10,),
                                     card_types(
                                         data: snapshot.data.data
                                     ),
                                     Divider(color: primary_color,height: 3,endIndent: 10,indent: 10,),
                                     card_description(
                                         charge: snapshot.data.data.charge
                                     ),
                                     Divider(color: primary_color,height: 3,endIndent: 10,indent: 10,),
                                     quantity_view(
                                         quantity: main_quantity
                                     ),
                                     add_to_cart(
                                       cardDetailsModel: snapshot.data
                                     )
                                   ],
                                 );
                               }
                             } else {
                               return SliderSimmer(
                               );
                             }
                           });

                     } else if (state is ErrorLoading) {
                       return SliderSimmer(
                       );

                     }else{
                       return Container();
                     }
                   },
                 )
             ),
           ),
         ),

         ),
       ),
   );
  }



  Widget page_appbar({bool is_favorited,String name}){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return      Padding(
        padding: EdgeInsets.only(
            left: width * .045, right: width * .045, top: height * .01,bottom: height * .01),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              },
              child: Image.asset('Assets/Images/skip.png',
                color: primary_color  ),
            ),
            MyText(
              text: name,
              size: ProdCardStoreFont.header_font_size,
              color: primary_color,
              weight: FontWeight.bold,),
            Row(
              children: [

                InkWell(
                  onTap: (){

                  },
                  child: Icon(
                    Icons.ios_share,
                    color: primary_color,
                  ),
                ),
                SizedBox(
                  width: width * 0.06,
                ),
                Container(
                    child:(is_favorited)?  IconButton(
                      icon: Image.asset("Assets/Images/star_lg.png"),
                      onPressed: (StaticData.vistor_value == 'visitor')? null:() async{
                        await  favourite_bloc.add(RemoveFavouriteEvent(
                          card_id: widget.card_id,
                        ));
                        setState(() {
                         is_favorited= !is_favorited;
                        });


                      },
                    )
                        :  IconButton(
                      icon:Image.asset("Assets/Images/star_lg_outline.png",color: Colors.yellow.shade800,),
                      onPressed: (StaticData.vistor_value == 'visitor')? null: () {
                        favourite_bloc.add(AddFavouriteEvent(
                          card_id: widget.card_id,
                        ));
                        setState(() {
                          is_favorited = !is_favorited;
                        });
                      },
                    )
                )
              ],
            )
          ],
        ));
  }

  Widget card_image({String image , String price , String flag}){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: width * 0.43,
      padding: EdgeInsets.only(left: 10,right: 10),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        shape: BoxShape.rectangle
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius:
              BorderRadius.circular( 15),
              child:   Container(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(height * .015)),
                ),
                child: ClipRRect(
                    borderRadius:
                    BorderRadius.all(Radius.circular(height * .015)),
                    child: Image.network(
                     image,
                      fit: BoxFit.fitWidth,
                    )),
                height: height ,
                width: width ,
              ),

            )
          ),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
               price==0? Container() :   MyText(text: "${price.toString()} ${translator.translate("SAR")}", size: ProdCardStoreFont.primary_font_size,color: whiteColor,),
                  Image.network(flag,
                    width: width * 0.2,
                  ),


                ],
              ))
        ],
      ),
    );
  }

  Widget card_details_text({String name, String description,String code , String category}){
    double width = MediaQuery.of(context).size.width;

    return Padding(
        padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: translator.currentLanguage == 'ar' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          MyText(text: name, size: ProdCardStoreFont.header_font_size,color: primary_color,weight: FontWeight.bold,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MyText(text: translator.translate("card code"), size: ProdCardStoreFont.primary_font_size,color: primary_color,),

                  MyText(text: "${code}   : ", size: ProdCardStoreFont.primary_font_size,color: primary_color,),

                ],
              ),
              Row(
                children: [
                  MyText(text: translator.translate("category"), size: ProdCardStoreFont.primary_font_size,color: primary_color,),
                  MyText(text: "${category}  : ", size: ProdCardStoreFont.primary_font_size,color: primary_color,),

                ],
              ),


            ],
          ),
          MyText(text: description, size: ProdCardStoreFont.primary_font_size,color: primary_color,)
        ],
      ),
    );
  }

  Widget card_countries(){
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder(
      bloc: cardDetailsBloc,
      builder: (context, state) {
        if (state is Loading) {
          return SliderSimmer(
          );
        } else if (state is Done) {
          return StreamBuilder<CountriesModel>(
              stream: cardDetailsBloc.countries_subject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.data.isEmpty) {
                    return Container(
                    );
                  } else {

                    return  Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset('Assets/Images/flag.png'),
                                SizedBox(width: width * 0.05,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start ,
                                  children: [
                                    MyText(text: translator.translate("Account Country"), size: ProdCardStoreFont.header_font_size,weight: FontWeight.bold,color: primary_color,),
                                    MyText(text: translator.translate("Choose the country of the card account"), size: ProdCardStoreFont.primary_font_size,weight: FontWeight.normal,color: primary_color,)
                                  ],
                                )
                              ],
                            ),
                            Container(
                                height: MediaQuery.of(context).size.width / 9,
                                child: ListView.builder(
                                    itemCount: snapshot.data.data.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap:
                                            () {
                                          setState(() {
                                            _onSelected(index);
                                            country_id = snapshot.data.data[index].id;
                                          });
                                        },
                                        child:
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: _selected_country_Index == index ? yellowColor : Colors.grey.shade200,
                                            ),
                                            child: Center(
                                              child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child:  Image.network(snapshot.data.data[index].flag),
                                                      ),
                                                      SizedBox(width: width *0.05,),
                                                      Text(
                                                        snapshot.data.data[index].name,
                                                        textDirection: TextDirection.ltr,
                                                        style: TextStyle(fontSize: 12,color: primary_color),
                                                      ),
                                                    ],
                                                  )
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    })),

                          ],
                        )
                    );
                  }
                } else {
                  return SliderSimmer(
                  );
                }
              });

        } else if (state is ErrorLoading) {
          return SliderSimmer(
          );

        }else{
          return Container();
        }
      },
    );

  }

  Widget card_types({card_model.Data data}){
    double width = MediaQuery.of(context).size.width;
    return Column(
    children: [
      Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('Assets/Images/value.png'),
                  SizedBox(width: width * 0.05,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start ,
                    children: [
                      MyText(text: translator.translate("value"),
                        size: ProdCardStoreFont.header_font_size,weight: FontWeight.bold,
                        color: primary_color,),
                      MyText(text: translator.translate("Choose the value of the card"),
                        size: ProdCardStoreFont.primary_font_size,weight: FontWeight.normal,
                        color: primary_color,)
                    ],
                  )
                ],
              ),
              Container(
                  height: MediaQuery.of(context).size.width / 9,
                  child: ListView.builder(
                      itemCount: data.types.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _onSelected_type(index);
                              type_id = data.types[index].id;
                              main_quantity = data.types[index].quantity;
                              card_price = double.parse(data.types[index].priceAfterDiscount);
                            });
                          },
                          child:
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: _selected_type_Index == index ? yellowColor : Colors.grey.shade200,
                              ),
                              child: Center(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                    child:  Text(
                                      "${data.types[index].priceAfterDiscount} ${translator.translate("SAR")}" ,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(fontSize: 12,color: primary_color),
                                    ),
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
            ],
          )
      )
    ],
  );
  }

  Widget card_description({String charge}){
    return Padding(
        padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline_outlined,color: primary_color,),
              SizedBox(width: 10,),
              MyText(text: translator.translate("Card Description"),
                size: ProdCardStoreFont.primary_font_size,color: primary_color,
              ),
            ],
          ),
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return CardDescription(
                      charge: charge,
                      card_id: widget.card_id,
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
            child: Icon(Icons.arrow_forward_ios,color: primary_color,),
          )
        ],
      ),
    );
  }

  Widget quantity_view({int quantity}){
   return Padding(
       padding: EdgeInsets.all(10),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Row(
           children: [
             MaterialButton(
               height: 5,
               minWidth: StaticData.get_width(context) * 0.1,
               onPressed: () {
                 setState(() {
                   if (qty <= 1) {
                     errorDialog(
                       context: context,
                       text:
                       "لقد نفذت الكمية من هذا المنتج",
                     );
                   } else {
                     setState(() {
                       qty--;
                     });
                   }
                 });
               },
               color: whiteColor,
               textColor: Colors.white,
               child: Icon(
                 Icons.remove,
                 size: 18,
                 color: primary_color,
               ),
               padding: EdgeInsets.all(5),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(8), // <-- Radius
               ),
             ),
             Text(
               '${qty}',
               style: TextStyle(
                 color: Colors.black,
                 fontWeight: FontWeight.bold,
                 fontSize: 20,
               ),
             ),
             MaterialButton(
               height: 5,
               minWidth: StaticData.get_width(context) * 0.1,
               onPressed: () {
                 setState(() {
                   print("prod_main_quantity : ${quantity}");
                   if (qty == quantity) {
                     errorDialog(
                       context: context,
                       text:
                       "لا يمكنك تخطى الكمية المتاحة",
                     );
                   } else {
                     setState(() {
                       qty++;
                     });
                   }
                 });
               },
               color: whiteColor,
               textColor: gray_color,
               child: Icon(
                 Icons.add,
                 size: 18,
                 color: yellowColor,
               ),

               padding: EdgeInsets.all(5),
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(8),

               )
             ),
           ],
         ),
         Container(
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10),
             color: greenColor,
           ),
           child: Center(
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
               child:  Text(
                 main_quantity == 0 ? "${translator.translate( "Out of stock")}" : "${translator.translate( "In stock")}" ,
                 textDirection: TextDirection.ltr,
                 style: TextStyle(fontSize: 12,color: main_quantity == 0 ? Colors.red : whiteColor),
               ),
             ),
           ),
         ),

       ],
     ),
   );
  }

  Widget add_to_cart({card_model.CardDetailsModel cardDetailsModel}){
    double width = MediaQuery.of(context).size.width;

    return Container(
    color: primary_color,
    height: width * 0.12,
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(text: "${translator.translate("SAR")} ${card_price * qty}",
          size: ProdCardStoreFont.header_font_size,color: yellowColor,),
      Container(
        height: width * 0.08,
        width: 1,
        color: whiteColor,
      ),
       InkWell(
      onTap: (){
    if(_cart_status ==0) {
      _cart_status = 1;
      print("cart 2");
      DB_Helper.insert_product(new Product(
          prod_id: cardDetailsModel.data.id,
          prod_name: cardDetailsModel.data.name,
          prod_price: cardDetailsModel.data.leastPrice,
          prod_pricture: cardDetailsModel.data.logo.isEmpty
              ? 'https://procard.store/storage/65/group-24-1-at-2x.png'
              : cardDetailsModel.data.logo,
          prod_chossed_quantity: qty,
          prod_main_quantity: main_quantity,
          prod_discount: 1,
          prod_price_after_discount: card_price,
          prod_cart_status: _cart_status,
          prod_order_status: _order_status,
          prod_country: cardDetailsModel.data.types[0].country.name
      ));


      setState(() {
        //use to calculate price of all products in cart
        DB_Helper.calculate_amount();
      });
    }
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return ShoppingCart();
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
      child: Row(
        children: [
          Icon(Icons.shopping_cart_outlined,color: yellowColor,),
          SizedBox(width: 10,),
          MyText(text: "${translator.translate( "add to cart")}",
            size: ProdCardStoreFont.header_font_size,color: whiteColor,),
        ],
      ),
    )
      ],
    ),
  );
  }



}