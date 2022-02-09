import 'package:procard_store/Bloc/Home_Bloc/latest_cards_bloc.dart';
import 'package:procard_store/Bloc/Settings_Bloc/settings_bloc.dart';
import 'package:procard_store/Bloc/Wallet_Bloc/wallet_bloc.dart';
import 'package:procard_store/Widgets/custom_circle_navigation_bar.dart';
import 'package:procard_store/fileExport.dart';


class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }

}

class HomeScreenState extends State<HomeScreen>{

  @override
  void initState() {
      walletBloc.add(getWalletHistoryEvent());
    settingsBloc.add(AppSettingsEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return  NetworkIndicator(
        child: PageContainer(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Directionality(
        textDirection: translator.currentLanguage =='ar'? TextDirection.rtl : TextDirection.ltr,
        child: Container(
            padding: EdgeInsets.all(StaticData.get_width(context)  * 0.01),
            child: Column(
              children: [
                //AppBar
                CustomAppBar(
                  text: translator.translate("sign in"),
                  page_name: 'HomeScreen',
                  frist_image: 'Assets/Images/menu.png',
                  second_image: 'Assets/Images/notifi.png',
                  logo: 'Assets/Images/tlogo.png',
                ),
                //Offer Slider
                Padding(
                  padding: EdgeInsets.all(StaticData.get_width(context)  * 0.02),
                  child:      OfferSlider(
                   // data: ['Assets/Images/slide.png','Assets/Images/slide.png','Assets/Images/slide.png'],
                    viewportFraction: 1.0,
                    aspect_ratio: 3.0,
                    border_radius: 15.0,
                    indicator: false,
                  ),
                ),
                //Latest CARDS
                Padding(
                    padding: EdgeInsets.all(StaticData.get_width(context)  * 0.02),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomComponents.homeTitleRow(
                            context, translator.translate("New Cards"),
                            translator.translate( "Recently added cards")),
                        CustomComponents.seeAll(
                            context :context
                            ,page:NewCards()
                        ),
                      ],
                    )
                ),
                Container(
                    padding: EdgeInsets.all(StaticData.get_width(context)  * 0.01),
                    height: StaticData.get_width(context) * 0.5,
                    child: CardView(
                      type: 'latest_cards',
                      view_type: 'horizontal_ListView',
                    )
                ),


                // BROWSE DEPARTMENT
                Padding(
                    padding: EdgeInsets.all(StaticData.get_width(context)  * 0.02),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start ,
                      children: [
                        CustomComponents.homeTitleRow(context,
                            translator.translate("Browse the Departments" ),
                            translator.translate("Gift the cards according to the department"))
                      ],
                    )
                ),
                Container(
                    padding: EdgeInsets.all(StaticData.get_width(context)  * 0.01),
                    height: StaticData.get_width(context) * 0.3,
                    child: DepartmentView(
                      view_type: 'horizontal_ListView' ,
                    )
                ),

                //BEST SELLER
                Padding(
                    padding: EdgeInsets.all(StaticData.get_width(context)  * 0.02),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomComponents.homeTitleRow(context, translator.translate("Best seller"), translator.translate( "Best selling cards")),
                        CustomComponents.seeAll(
                            context :context,
                            page: BestSeller()),
                      ],
                    )
                ),
                Container(
                    padding: EdgeInsets.all(StaticData.get_width(context)  * 0.01),
                    height: StaticData.get_width(context) * 0.5,
                    child: CardView(
                      type: 'best_seller',
                      view_type: 'horizontal_ListView',
                    )
                )
              ],
            ),
          ),)

      ),

      bottomNavigationBar: CustomCircleNavigationBar(
              page_index: 2,
            ),



      endDrawer: CustomComponents.sideBarMenu(context),
    )));
  }

}