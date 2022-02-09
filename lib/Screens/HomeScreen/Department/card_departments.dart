import 'package:procard_store/Widgets/custom_circle_navigation_bar.dart';
import 'package:procard_store/fileExport.dart';

class CardDepartments extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CardDepartmentsState();
  }

}

class CardDepartmentsState extends State<CardDepartments>{
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
        child: PageContainer(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(StaticData.get_width(context)  * 0.02),
        child: Column(
          children: [
            CustomAppBar(
              text: translator.translate("sign in"),
              page_name: 'HomeScreen',
              frist_image: 'Assets/Images/menu.png',
              second_image: 'Assets/Images/notifi.png',
              logo: 'Assets/Images/tlogo.png',
            ),
            Container(
              padding: EdgeInsets.all(StaticData.get_width(context)  * 0.01),
              height: StaticData.get_height(context) * 0.74,
              child:  DepartmentView(
                view_type: 'gridView',
              ),
            )
          ],

        ),
      ),

          bottomNavigationBar: CustomCircleNavigationBar(
            page_index: 1,
          ),
          endDrawer: CustomComponents.sideBarMenu(context),
    )));
  }

}