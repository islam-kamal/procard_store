import 'package:procard_store/Bloc/CreditCard_Bloc/credit_card_bloc.dart';
import 'package:procard_store/Model/CreditCard_Model/credit_card_model.dart';
import 'package:procard_store/Widgets/Shimmer/shimmer_notification.dart';
import 'package:procard_store/Widgets/visitor_message.dart';
import 'package:procard_store/fileExport.dart';

class CreditCardsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CreditCardsScreenState();
  }

}

class CreditCardsScreenState extends State<CreditCardsScreen> with TickerProviderStateMixin{
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
                key: _drawerKey,
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
                          CustomAppBar(
                            text: translator.translate( "Credit Cards" ),
                            page_name: "Credit Cards",
                             second_image: 'Assets/Images/plusor.png',
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          saved_credit_cards(),
                          SizedBox(
                            height: height * .01,
                          ),
                          credit_card_list() ,
                        ],
                      ),
                    ),
                  ),
                ),
              )));
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
                    //  height: snapshot.data.data.length==1? null : width * 0.75,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.data.length,
                          itemBuilder: (context,index){
                            return   Padding(
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
                                            child:    Icon(
                                              Icons.settings,
                                              color: yellowColor,
                                            )
                                          ),

                                        ],
                                      ),
                                    )
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

  Widget saved_credit_cards(){
    double width = MediaQuery.of(context).size.width;
    return  Padding(
        padding: EdgeInsets.all(width * 0.05),
        child:   MyText(
          text: translator.translate( "Saved Credit Cards"),
          color: primary_color,
          weight: FontWeight.bold,
          size: ProdCardStoreFont.header_font_size,
        ), );
  }
}