import 'package:procard_store/Bloc/Wallet_Bloc/wallet_bloc.dart';
import 'package:procard_store/Model/Wallet_Model/wallet_model.dart';
import 'package:procard_store/Screens/Profile/Wallet/charge_wallet_screen.dart';
import 'package:procard_store/Widgets/Shimmer/shimmer_notification.dart';
import 'package:procard_store/Widgets/visitor_message.dart';
import 'package:procard_store/fileExport.dart';

class WalletScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WalletScreenState();
  }
}

class WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    walletBloc.add(getWalletHistoryEvent());
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
                body: Directionality(
              textDirection: translator.currentLanguage == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: (StaticData.vistor_value == 'visitor')
                  ? VistorMessage()
                  : Column(
                children: [
                  CustomAppBar(
                    text: translator.translate("Wallet"),
                    page_name: 'Wallet',
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  BlocBuilder(
                    bloc: walletBloc,
                    builder: (context, state) {
                      if (state is Loading) {
                        return ShimmerNotification();
                      } else if (state is Done) {
                        return StreamBuilder<WalletModel>(
                            stream: walletBloc.wallet_history_subject,
                            builder: (context, snapshot) {

                              if (snapshot.hasData) {
                                if (snapshot.data==null) {
                                  return NoData(
                                    message:  translator.translate("There is no Data"),
                                  );
                                } else {
                                  return Expanded(
                                    child: Column(
                                      children: [

                                        wallet_balance(
                                          balance: snapshot.data.balance,
                                        ),
                                        SizedBox(
                                          height: height * .01,
                                        ),
                                        wallet_operation_text(),
                                        SizedBox(
                                          height: height * .04,
                                        ),
                                        snapshot.data.operations.isEmpty ? NoData(
                                          message:  translator.translate("There is no Data"),
                                        )
                                            : Expanded(
                                          child: ListView.builder(
                                              itemCount: snapshot.data.operations.length,
                                              itemBuilder: (context, index) {
                                                return wallet_operation_element(
                                                  type: snapshot.data.operations[index].type,
                                                  amount: snapshot.data.operations[index].amount,
                                                  date: snapshot.data.operations[index].date,
                                                  payment_method: snapshot.data.operations[index].paymentMethod,
                                                );
                                              }),
                                        )
                                      ],
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
                  )
                ],
              )


          ,
            ))),
      ),
    );
  }

  Widget wallet_balance({String balance}) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: pink_color,
        ),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Image.asset("Assets/Images/myrseed.png"),
                    ),
                    Column(
                      children: [
                        MyText(
                          text: translator.translate("Current Wallet Balance"),
                          color: gray_color,
                          weight: FontWeight.normal,
                          size: ProdCardStoreFont.primary_font_size,
                        ),
                        MyText(
                          text: '${balance} ${translator.translate("SAR")}',
                          color: primary_color,
                          weight: FontWeight.bold,
                          size: ProdCardStoreFont.primary_font_size,
                        ),
                      ],
                    ),

                  ],
                )),
            Expanded(
              flex: 2,
              child: navigtor_to_charge_wallet_screen(),
            ),

          ],
        ),
      ),
    );
  }

  Widget navigtor_to_charge_wallet_screen() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
                return ChargeWalletScreen();
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
      },
      child: Container(
          height: StaticData.get_width(context) * .13,
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
            color: third_color,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Text(
            translator.translate("Recharge New Balance"),
            style: const TextStyle(
              color: whiteColor,
              fontSize: ProdCardStoreFont.primary_font_size,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.3,
            ),
          )),
    );
  }

  Widget wallet_operation_text() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: Image.asset("Assets/Images/time.png"),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              text: translator.translate( "Wallet Operations List"),
              color: black_color,
              weight: FontWeight.bold,
              size: ProdCardStoreFont.header_font_size,
            ),
            MyText(
              text: translator.translate("All the operations you have made from the wallet" ),
              color: gray_color,
              weight: FontWeight.normal,
              size: ProdCardStoreFont.secondary_font_size,
            ),
          ],
        ),

      ],
    );
  }

  Widget wallet_operation_element(
      {String type, String amount, String payment_method, String date}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Image.asset("Assets/Images/myrseed.png"),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: type,
                          color: black_color,
                          weight: FontWeight.bold,
                          size: ProdCardStoreFont.secondary_font_size,
                        ),
                        SizedBox(
                          height: StaticData.get_width(context) * 0.01,
                        ),
                        MyText(
                          text: '$amount ${translator.translate("SAR")}',
                          color: third_color,
                          weight: FontWeight.normal,
                          size: ProdCardStoreFont.primary_font_size,
                        ),
                        SizedBox(
                          height: StaticData.get_width(context) * 0.01,
                        ),
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
                              payment_method,
                              style: const TextStyle(
                                color: primary_color,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.3,
                              ),
                            ))
                      ],
                    ),

                  ],
                )),
            Expanded(
              flex: 1,
              child: MyText(
                text: date,
                color: gray_color,
                weight: FontWeight.normal,
                size: ProdCardStoreFont.secondary_font_size,
              ),
            ),
          ],
        ),
        Divider(
          color: primary_color,
          endIndent: 20,
          indent: 20,
        )
      ],
    );
  }
}
