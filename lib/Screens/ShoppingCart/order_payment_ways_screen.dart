import 'package:procard_store/Bloc/CreditCard_Bloc/credit_card_bloc.dart';
import 'package:procard_store/Bloc/Wallet_Bloc/wallet_bloc.dart';
import 'package:procard_store/Model/CreditCard_Model/credit_card_model.dart';
import 'package:procard_store/Screens/Profile/Wallet/wallet_screen.dart';
import 'package:procard_store/Widgets/Shimmer/shimmer_notification.dart';
import 'package:procard_store/Widgets/visitor_message.dart';
import 'package:procard_store/fileExport.dart';

class OrderPaymentWaysScreen extends StatefulWidget{
  String balance;
  OrderPaymentWaysScreen({this.balance});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderPaymentWaysScreenState();
  }

}

class OrderPaymentWaysScreenState extends State<OrderPaymentWaysScreen> with TickerProviderStateMixin{
  bool bank_transfer = false;
  int  payment_way ; // 1-----> credit card , 2------> bank transfer , 3 ----------> wallet
  bool bank_card = true;
  String wallet_balance;
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
    payment_way = 1;
    creditCardsBloc.add(GetCreditCardEvent());
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
      child: PageContainer(
          child: WillPopScope(
              onWillPop: () {
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
              child: Scaffold(
                key: _drawerKey,
                body: SingleChildScrollView(
                  child: Directionality(
                    textDirection: translator.currentLanguage == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: BlocListener<WalletBloc,AppState>(
                      bloc: walletBloc,
                      listener: (context, state){
                        if(state is Loading){
                          if(state.indicator == 'confirm charge'){
                            _playAnimation();
                          }else{

                          }

                        }
                        else if(state is Done) {
                          if(state.indicator == 'confirm charge'){
                            var data = state.model as GeneralResponseModel;
                            _stopAnimation();
                            errorDialog(
                                context: context,
                                text: data.message,
                                function: (){
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation1, animation2) {
                                        return WalletScreen();
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
                            );
                          }else{

                          }

                        }
                        else if(state is ErrorLoading){
                          if(state.indicator == 'confirm charge'){
                            var data = state.model as GeneralResponseModel;
                            _stopAnimation();
                            errorDialog(
                              context: context,
                              text: data.message,
                            );
                          }else{

                          }

                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomAppBar(
                            text: translator.translate( "Order Payment" ),
                            page_name: 'OrderPaymentWaysScreen',
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          payment_method(),
                          SizedBox(
                            height: height * .1,
                          ),

                          next_button(),
                          SizedBox(
                            height: height * .01,
                          ),
                        ],
                      ),
                    ),
                  )


                  ,
                ),
              ))),

    );
  }


  Widget payment_method() {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
     // height: width * 0.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
        Padding(
                padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                setState(() {
                 // bank_transfer = false;
                  payment_way = 1;
                  print("credit payment_way : ${payment_way}");

                });
              },
              child: Row(
                children: [
                  payment_way == 1
                      ? Icon(
                    Icons.check_box_outline_blank,
                    color: yellowColor,
                  )
                      : Icon(
                    Icons.check_box,
                    color: yellowColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(translator.translate("Credit Card"),
                      style: TextStyle(color:primary_color,fontWeight: FontWeight.bold,fontSize: ProdCardStoreFont.primary_font_size),),
                  ),

                ],
              ),
            ),
            ),
            SizedBox(height: 10,),
            Divider(
              height: 2,
              color: gray_color,
            ),
      Padding(
        padding: EdgeInsets.all(10),
        child: InkWell(
              onTap: () {
                setState(() {
                  payment_way = 2;
                  print("Transfer payment_way : ${payment_way}");

                });
              },
              child: Row(
                children: [
                  payment_way == 2
                      ? Icon(
                    Icons.check_box,
                    color: yellowColor,
                  )
                      : Icon(
                    Icons.check_box_outline_blank,
                    color: yellowColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(translator.translate("Bank Transfer"),
                      style: TextStyle(color:primary_color,fontWeight: FontWeight.bold,fontSize: ProdCardStoreFont.primary_font_size),
                    ),
                  ),
                ],
              ),
            ),
      ),

            SizedBox(height: 10,),
            Divider(
              height: 2,
              color: gray_color,
            ),
      Padding(
        padding: EdgeInsets.all(10),
        child: InkWell(
              onTap: () {
                setState(() {
                  payment_way = 3;
                  print("wallet payment_way : ${payment_way}");
                });
              },
              child: Row(
                children: [
                  payment_way == 3
                      ? Icon(
                    Icons.check_box,
                    color: yellowColor,
                  )
                      : Icon(
                    Icons.check_box_outline_blank,
                    color: yellowColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(translator.translate("wallet balance"),
                          style: TextStyle(color:primary_color,fontWeight: FontWeight.bold,fontSize: ProdCardStoreFont.primary_font_size),
                        ),
                        Text("${translator.translate("Your current balance")} : ${widget.balance}",
                          style: TextStyle(color:primary_color,fontWeight: FontWeight.normal,fontSize: ProdCardStoreFont.secondary_font_size),
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
      ),
          ],
        ),
      ),
    );
  }

  Widget credit_card_list (){
    double width = MediaQuery.of(context).size.width;
    return   BlocBuilder(
      bloc: creditCardsBloc,
      builder: (context, state) {
        if (state is Loading) {
          return ShimmerNotification();
        } else if (state is Done) {
          return StreamBuilder<CreditCardModel>(
              stream: creditCardsBloc.credit_cards_subject,
              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  if (snapshot.data==null) {
                    return NoData(
                      message:  translator.translate("There is no Data"),
                    );
                  } else {
                    return   Container(
                      width: double.infinity,
                      height: snapshot.data.data.length==1? null : width * 0.75,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.data.length,
                          itemBuilder: (context,index){
                            return  InkWell(
                              onTap: () {
                                setState(() {
                                  bank_card = false;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(width *0.02),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: primary_color,width: 1)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(width * 0.02),
                                      child:  Row(
                                        children: [

                                          Expanded(
                                            flex: 1,
                                            child: snapshot.data.data[index].image.isEmpty? Image.asset("Assets/Images/visaop.png") :
                                            Image.network(snapshot.data.data[index].image),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child:  Padding(
                                              padding: EdgeInsets.only(right: 5,left: 5),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  MyText(
                                                    text: snapshot.data.data[index].cardOwner,
                                                    color: primary_color,
                                                    weight: FontWeight.bold,
                                                    size: ProdCardStoreFont.primary_font_size,
                                                  ),

                                                  MyText(
                                                    text: " ${snapshot.data.data[index].expireDate.substring(0,10)}    : ${translator.translate("end at")}",
                                                    color: primary_color,
                                                    weight: FontWeight.normal,
                                                    size: ProdCardStoreFont.secondary_font_size,
                                                  ),

                                                ],
                                              ),
                                            ),

                                          ),
                                          Expanded(
                                            flex: 1,
                                            child:    bank_card == true
                                                ? Icon(
                                              Icons.check_box_outline_blank,
                                              color: yellowColor,
                                            ) : Icon(
                                              Icons.check_box,
                                              color: yellowColor,
                                            ),
                                          ),

                                        ],
                                      ),
                                    )
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                } else {
                  return ShimmerNotification(

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

  Widget add_new_credit_card(){
    return Padding(
      padding: EdgeInsets.all( StaticData.get_width(context) * 0.05),
      child:  InkWell(
        onTap: (){
          StaticData.vistor_value = 'visitor';
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('Assets/Images/addcard.png',
              color: primary_color,),
            SizedBox(width: 5,),
            Container(
              child: Text(translator.translate(  "Add new credit card" ),
                style: TextStyle(color: primary_color ),),
            ),
          ],
        ),),
    );
  }

  Widget next_button() {
    return Center(
      child: StaggerAnimation(
        context: context,
        titleButton:  translator.translate("Next"),
        buttonController: _loginButtonController.view,
        btn_color: yellowColor,
        text_color: primary_color,
        onTap: () {
          switch(payment_way){
            case 1 :
              break;
            case 2 :
              break;
            case 3 :
              break;
          }
        },
      ),
    );

  }


  Widget bank_transfer_widget(){
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        bank_transfer_bank_name_textfield(),
        SizedBox(
          height: width * .03,
        ),
        bank_transfer_account_name_textfield(),
        SizedBox(
          height: width * .03,
        ),
        bank_transfer_account_number_textfield(),
        SizedBox(
          height: width * .03,
        ),
        bank_transfer_iban_number_textfield(),

      ],
    );
  }


  Widget bank_transfer_account_name_textfield(){
    double width = MediaQuery.of(context).size.width;
    return  StreamBuilder<String>(
        stream: walletBloc.account_name,
        builder: (context, snapshot) {
          return  Padding(
            padding: EdgeInsets.only(left:width * 0.05,right: width*0.05),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate( "Owner Name"),
              color: gray_color,
              onchange: walletBloc.account_name_change,
              errorText: snapshot.error,
              inputType: TextInputType.text,
            ),
          );


        });
  }

  Widget bank_transfer_account_number_textfield(){
    double width = MediaQuery.of(context).size.width;
    return  StreamBuilder<String>(
        stream: walletBloc.account_number,
        builder: (context, snapshot) {
          return  Padding(
            padding: EdgeInsets.only(left:width * 0.05,right: width*0.05),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("Account Number"),
              color: gray_color,
              onchange: walletBloc.account_number_change,
              errorText: snapshot.error,
              inputType: TextInputType.number,
            ),
          );


        });
  }


  Widget bank_transfer_iban_number_textfield(){
    double width = MediaQuery.of(context).size.width;
    return  StreamBuilder<String>(
        stream: walletBloc.iban_number,
        builder: (context, snapshot) {
          return  Padding(
            padding: EdgeInsets.only(left:width * 0.05,right: width*0.05),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("Bank Iban"),
              color: gray_color,
              onchange: walletBloc.iban_number_change,
              errorText: snapshot.error,
              inputType: TextInputType.text,
            ),
          );


        });
  }

  Widget bank_transfer_bank_name_textfield(){
    double width = MediaQuery.of(context).size.width;
    return  StreamBuilder<String>(
        stream: walletBloc.bank_name,
        builder: (context, snapshot) {
          return  Padding(
            padding: EdgeInsets.only(left:width * 0.05,right: width*0.05),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("Bank Name"),
              color: gray_color,
              onchange: walletBloc.bank_name_change,
              errorText: snapshot.error,
              inputType: TextInputType.text,
            ),
          );


        });
  }
}