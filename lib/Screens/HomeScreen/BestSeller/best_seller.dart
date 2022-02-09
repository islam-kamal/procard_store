import 'package:procard_store/fileExport.dart';

class BestSeller extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BestSellerState();
  }

}

class BestSellerState extends State<BestSeller>{

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(StaticData.get_width(context)  * 0.01),
                    child: Column(
                      children: [
                        CustomAppBar(
                          text: translator.translate("Best seller"),
                          page_name: 'BestSeller',
                        ),
                        Container(
                          padding: EdgeInsets.all(StaticData.get_width(context)  * 0.01),
                          height: StaticData.get_height(context) * 0.84,
                          child:  CardView(
                            type: 'best_seller',
                            view_type: 'gridView',
                          ),
                        )
                      ],

                    ),
                  ),
                ),
              )
            )));
  }

}