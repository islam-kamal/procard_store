
import 'package:procard_store/Base/Database/DB_Helper.dart';
import 'package:procard_store/Screens/ShoppingCart/order_payment_ways_screen.dart';
import 'package:procard_store/Widgets/custom_circle_navigation_bar.dart';
import 'package:procard_store/fileExport.dart';
import 'package:procard_store/Base/Database/Product.dart';
import 'package:procard_store/Bloc/Coupon_Bloc/coupon_bloc.dart';
import 'package:procard_store/Model/Coupon_Model/coupon_model.dart';

class ShoppingCart extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ShoppingCartState();
  }

}

class ShoppingCartState extends State<ShoppingCart> with TickerProviderStateMixin{
  Future<List<Product>> cart_products;
  List<Product> product_Data;
  var product_quantity;
  int qty;
  var total = [];
  var coupon_value ;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController _loginButtonController;
  bool isLoading = false;

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {
      print('[_playAnimation] error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
      print('[_stopAnimation] error');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    cart_products = DB_Helper.get_cart_products();
    product_Data = [];
    print("cart_products : ${cart_products}");
    //use to calculate price of all products in cart
    DB_Helper.calculate_amount();
    print("1111111111");
/*    var sum = 0;
    for (num e in total) {
      setState(() {
        sum += e;
      });
    }
    print("sum : $sum");*/
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return NetworkIndicator(
      child: PageContainer(
        child:Scaffold(
            body: Directionality(
              textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomAppBar(
                      page_name: 'ShoppingCart',
                      frist_image: 'Assets/Images/menu.png',
                      second_image: 'Assets/Images/notifi.png',
                      text: translator.translate("Shopping Cart"),
                    ),
                    cart_items(),
                    SizedBox(height: width * 0.02,),
                    add_coupon(),
                    SizedBox(height: width * 0.02,),
                    purchase_text(),
                    SizedBox(height: width * 0.2,),
                    buttons()
                  ],
                ),
              )
            ),
          bottomNavigationBar: CustomCircleNavigationBar(
            page_index: 3,
          ),
          endDrawer: CustomComponents.sideBarMenu(context),

        ),
      ),
    );

  }

  Widget cart_items(){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(

      child:  FutureBuilder(
          future: cart_products,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return Container();
              } else {
                product_Data = snapshot.data;
                return SingleChildScrollView(
                    child:Column(
                      children: [
                        ListView.builder(
                            itemCount: product_Data.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),

                            itemBuilder: (BuildContext context, index) {
                              product_Data.forEach((element) {

                                total.add(element.prod_price_after_discount * element.prod_chossed_quantity);
                              });
                              return Column(
                                  children: [
                                    SizedBox(
                                      height: height * .01,
                                    ),
                                    shoppingCartItem(product_Data[index]),
                                    SizedBox(
                                      height: height * .01,
                                    ),
                                  ]);
                            }),
                      ],
                    ));
              }
            } else if (snapshot.hasError) {
              return Container(
                child: Text('${snapshot.error}'),
              );
            } else {
              return Center(
                child: SpinKitFadingCircle(color: greenColor),
              );
              ;
            }
          }),
    );
  }


  Widget shoppingCartItem(Product product) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    qty = product.prod_chossed_quantity;
    product_quantity = product.prod_main_quantity;
    return Directionality(
        textDirection: translator.currentLanguage =='ar'? TextDirection.rtl : TextDirection.ltr,
        child:Padding(padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(product.prod_pricture),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                text: product.prod_name,
                                size: ProdCardStoreFont.header_font_size,
                                color: black_color,
                                weight: FontWeight.bold,
                              ),
                              InkWell(
                                onTap: (){
                                  DB_Helper.delete_product(
                                      int.parse(product.prod_id));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          super.widget));

                                },
                                child: Image.asset('Assets/Images/delnot.png'),
                              )
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: pink_color
                                ),
                                child:  MyText(
                                  text: "${translator.translate("Country")}  :  ${product.prod_country} ",
                                  size: ProdCardStoreFont.primary_font_size,
                                  color: black_color,
                                  weight: FontWeight.normal,),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: pink_color
                                  ),
                                  child:      MyText(
                                    text: " ${translator.translate("Value")} :   ${translator.translate("SAR")} ${product.prod_price_after_discount}",
                                    size: ProdCardStoreFont.primary_font_size,
                                    color: black_color,
                                    weight: FontWeight.normal,)
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                text: "${translator.translate("Quantity")}  :  ${product.prod_chossed_quantity}",
                                size: ProdCardStoreFont.primary_font_size,
                                color: black_color,
                                weight: FontWeight.normal,),
                              SizedBox(width: width * 0.2,),
                              MyText(
                                text: " ${product.prod_price_after_discount * product.prod_chossed_quantity} ${translator.translate("SAR")}",
                                size: ProdCardStoreFont.header_font_size,
                                color: black_color,
                                weight: FontWeight.bold,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
              Divider(
                color: black_color,
                height: 2,
              )
            ],
          ),)
    );

  }

  Widget add_coupon(){
    double width = MediaQuery.of(context).size.width;
    return  Container(
        padding: EdgeInsets.all(10),
        color: open_gray_color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 3,
                child: Wrap(
                  children: [
                    Row(
                      children: [
                        Image.asset('Assets/Images/value.png'),
                        SizedBox(width: width * 0.02,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start ,
                          children: [
                            MyText(text: translator.translate("discount voucher"),
                              size: ProdCardStoreFont.header_font_size,weight: FontWeight.bold,
                              color: primary_color,),
                            MyText(text: translator.translate("Add the coupon and enjoy the discount"),
                              size: ProdCardStoreFont.secondary_font_size,weight: FontWeight.normal,
                              color: primary_color,)
                          ],
                        )
                      ],
                    )
                  ],
                )
            ),
            Expanded(
              flex: 2,
              child:   GestureDetector(
                onTap:() {
                  couponBottomSheet(
                      context: context
                  );
                },
                child: Container(
                    height: StaticData.get_height(context) * .05,
                    padding: EdgeInsets.all(5),
                    alignment: FractionalOffset.center,
                    decoration: BoxDecoration(
                      color: yellowColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.add_box_outlined,color: primary_color,),
                        SizedBox(width: 5,),
                        Text(
                          translator.translate( "Add Coupon"),
                          style: const TextStyle(
                            color: primary_color,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.3,
                          ),
                        )
                      ],
                    )

                ),
              ),
            )

          ],
        )
    );
  }

  Widget purchase_text(){
    double width = MediaQuery.of(context).size.width;

    return Padding(padding: EdgeInsets.all(10),
    child:   Column(
      children: [
        Row(
          children: [
            Image.asset('Assets/Images/flag.png'),
            SizedBox(width: width * 0.05,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start ,
              children: [
                MyText(text: translator.translate("Total Purchases"), size: ProdCardStoreFont.header_font_size,weight: FontWeight.bold,color: primary_color,),
                MyText(text: translator.translate( "Total cards in cart"), size: ProdCardStoreFont.primary_font_size,weight: FontWeight.normal,color: primary_color,)
              ],
            )
          ],
        ),
        SizedBox(height: width * 0.1,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(text: translator.translate("Total Purchases"), size: ProdCardStoreFont.header_font_size,
              weight: FontWeight.bold,color: primary_color,),
            MyText(text: "${StaticData.TOTAL_AMOUNT}  ${translator.translate("SAR")}", size: ProdCardStoreFont.header_font_size,
              weight: FontWeight.bold,color: primary_color,),

          ],
        ),
        SizedBox(height: width * 0.05,),
        Divider(color: primary_color,height: 2,),
        SizedBox(height: width * 0.05,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(text: translator.translate(  "total order"), size: ProdCardStoreFont.header_font_size,
              weight: FontWeight.bold,color: primary_color,),
            MyText(text: "${StaticData.TOTAL_AMOUNT}  ${translator.translate("SAR")}", size: ProdCardStoreFont.header_font_size,
              weight: FontWeight.bold,color: primary_color,),

          ],
        )

      ],
    )
    );
  }

  Widget buttons(){
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap:() async {
            String  wallet_balance = await  sharedPreferenceManager.readString(CachingKey.USER_WALLET_BALANCE);

           /*   Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return OrderPaymentWaysScreen(
                    balance: wallet_balance,
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
            );*/
            },
            child: Container(
                height: StaticData.get_height(context) * .06,
                width:  StaticData.get_height(context) * .2,

                padding: EdgeInsets.all(5),
                alignment: FractionalOffset.center,
                decoration: BoxDecoration(
                  color: primary_color,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Row(

                  children: [
                    Icon(Icons.check_box_outlined,color: yellowColor,),
                    SizedBox(width: 5,),
                    Text(
                      translator.translate(  "order payment"),
                      style: const TextStyle(
                        color: whiteColor,
                        fontSize: ProdCardStoreFont.secondary_font_size,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    )
                  ],
                )

            ),
          ),
          GestureDetector(
            onTap:() {
              Navigator.pushReplacement(
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
            child: Container(
                height: StaticData.get_height(context) * .06,
                width:  StaticData.get_height(context) * .2,
                padding: EdgeInsets.all(5),
                alignment: FractionalOffset.center,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: primary_color)
                ),
                child: Row(
                  children: [
                    Icon(Icons.lock_outline,color: primary_color,),
                    SizedBox(width: 5,),
                    Text(
                      translator.translate( "Continue shopping"),
                      style: const TextStyle(
                        color: primary_color,
                        fontSize: ProdCardStoreFont.secondary_font_size,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    )
                  ],
                )

            ),
          )
        ],
      ),
    );
  }

   void couponBottomSheet({BuildContext context, }) {
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet<void>(
        context: context,
        shape: OutlineInputBorder(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return  Directionality(
              textDirection: translator.currentLanguage =='ar'?TextDirection.rtl : TextDirection.ltr,
              child: SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.only(top: 10),
                    child:  Column(
                      children: [
                        Container(
                          child: Image.asset('Assets/Images/fullqasema.png',
                            height: width * 0.2,width: width * 0.2,
                          fit: BoxFit.fill,),

                        ),
                        SizedBox(height: width*0.05,),
                        Padding(
                          padding: EdgeInsets.only(
                              right: StaticData.get_width(context) * 0.1,
                              left: StaticData.get_width(context) * 0.1),
                          child: CustomTextFieldWidget(
                            context: context,
                            color: gray_color,
                            hint: translator.translate("Email"),
                            onchange:(value){
                              coupon_value = value;
                            },
                            suffixIcon: null,
                            inputType: TextInputType.number,),
                        ),
                        SizedBox(height: width*0.1,),

                      BlocListener<CouponBloc, AppState>(
                          bloc: couponBloc,
                          listener: (context,state){
                            if(state is Loading){
                              _playAnimation();
                            }else if (state is Done){
                              _stopAnimation();
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation1, animation2) {
                                    return CustomCircleNavigationBar(page_index: 3,);
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
                            }else if(state is ErrorLoading){
                             var data = state.model as CouponModel;
                              _stopAnimation();
                              errorDialog(
                                context: context,
                                text: data.message
                              );
                            }
                          },
                        child:  GestureDetector(
                          onTap:() {

                            couponBloc.add(AddCouponEvent(value: coupon_value));
                          },
                          child: Container(
                              width: StaticData.get_width(context) * 0.9,
                              height: StaticData.get_height(context) * .08,
                              alignment: FractionalOffset.center,
                              decoration: BoxDecoration(
                                color: third_color,
                                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: Text(
                                translator.translate( "apply"),
                                style: const TextStyle(
                                  color: yellowColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 0.3,
                                ),
                              )

                          ),
                        ),
                      )
                      ],
                    )
                ),
              ));
        }

    );
  }

}