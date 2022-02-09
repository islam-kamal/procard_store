import 'package:procard_store/fileExport.dart';

class NewCards extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewCardsState();
  }

}

class NewCardsState extends State<NewCards>{
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
                  text: translator.translate("New Cards"),
                  page_name: 'NewCards',
                ),
               Container(
                 padding: EdgeInsets.all(StaticData.get_width(context)  * 0.01),
                 height: StaticData.get_height(context) * 0.84,
                 child:  CardView(
                   view_type: 'gridView',
                   type: 'latest_cards',
                 ),
               )
              ],

            ),
          ),
    )) )));
  }

}