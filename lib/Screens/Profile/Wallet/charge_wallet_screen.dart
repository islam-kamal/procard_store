import 'package:procard_store/Bloc/CreditCard_Bloc/credit_card_bloc.dart';
import 'package:procard_store/Bloc/Wallet_Bloc/wallet_bloc.dart';
import 'package:procard_store/Model/CreditCard_Model/credit_card_model.dart';
import 'package:procard_store/Screens/Profile/Wallet/wallet_screen.dart';
import 'package:procard_store/Widgets/Shimmer/shimmer_notification.dart';
import 'package:procard_store/Widgets/visitor_message.dart';
import 'package:procard_store/fileExport.dart';

class ChargeWalletScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChargeWalletScreenState();
  }

}

class ChargeWalletScreenState extends State<ChargeWalletScreen> with TickerProviderStateMixin{
  bool bank_transfer = false;
  int  credit_card;
  bool bank_card = true;
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
            },
            child: Scaffold(
                key: _drawerKey,
                body: SingleChildScrollView(
                  child: Directionality(
                  textDirection: translator.currentLanguage == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: (StaticData.vistor_value == 'visitor')
                      ? VistorMessage()
                      :BlocListener<WalletBloc,AppState>(
                    bloc: walletBloc,
                    listener: (context, state){
                      if(state is Loading){
                        if(state.indicator == 'confirm charge'){
                          _playAnimation();
                        }else{

                        }

                      }else if(state is Done){
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

                      }else if(state is ErrorLoading){
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
                          text: translator.translate( "Charge Wallet" ),
                          page_name: 'ChargeWalletScreen',
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        recharge_amount_textfield(),
                        SizedBox(
                          height: height * .01,
                        ),
                        recharge_method(),
                        SizedBox(
                          height: height * .01,
                        ),
                        payment_method(),
                        SizedBox(
                          height: height * .01,
                        ),
                        bank_transfer ? bank_transfer_widget() : credit_card_list() ,
                        SizedBox(
                          height: height * .01,
                        ),
                        add_new_credit_card(),
                        SizedBox(
                          height: height * .01,
                        ),
                        confirm_recharge_Button(),
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
  Widget recharge_amount_textfield(){
    double width = MediaQuery.of(context).size.width;

    return  StreamBuilder<String>(
        stream: walletBloc.recharge_amount,
        builder: (context, snapshot) {
          return  Padding(
            padding: EdgeInsets.only(left:width * 0.05,right: width*0.05),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("enter recharge amount"),
              color: primary_color,
              onchange: walletBloc.recharge_amount_change,
              suffixIcon: Text(translator.translate("SAR"),style: TextStyle(color: primary_color),textAlign: TextAlign.center,),
              errorText: snapshot.error,
              inputType: TextInputType.number,
            ),
          );


        });
  }

  Widget recharge_method(){
    double width = MediaQuery.of(context).size.width;
    return  Padding(
        padding: EdgeInsets.only(right: width * 0.05,left: width*0.05),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: translator.translate( "Recharge Method"),
          color: black_color,
          weight: FontWeight.bold,
          size: ProdCardStoreFont.header_font_size,
        ),
        MyText(
          text: translator.translate("Select Recharge Method" ),
          color: gray_color,
          weight: FontWeight.normal,
          size: ProdCardStoreFont.secondary_font_size,
        ),
      ],
    ) );
  }

  Widget payment_method() {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: width * 0.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  bank_transfer = false;
                 credit_card = 1;
                });
              },
              child: Row(
                children: [
                  bank_transfer == true
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
            SizedBox(width: 20,),
            InkWell(
              onTap: () {
                setState(() {
                  bank_transfer = true;
                 credit_card = 0;
                });
              },
              child: Row(
                children: [
                  bank_transfer == true
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

  Widget confirm_recharge_Button() {
    return Center(
      child: StaggerAnimation(
        context: context,
        titleButton:  translator.translate("Confrim charge"),
        buttonController: _loginButtonController.view,
        btn_color: yellowColor,
        text_color: primary_color,
        onTap: () {
          walletBloc.add(RechargeWalletBankTransferEvent());
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