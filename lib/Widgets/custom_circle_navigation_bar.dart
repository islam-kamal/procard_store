import 'package:flutter/material.dart';
import 'package:procard_store/fileExport.dart';
import 'package:procard_store/fileExport.dart';
import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';



class CustomCircleNavigationBar extends StatefulWidget {
  final int page_index;
  CustomCircleNavigationBar({this.page_index});
  @override
  _CustomCircleNavigationBarState createState() => _CustomCircleNavigationBarState();
}

class _CustomCircleNavigationBarState extends State<CustomCircleNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    double barHeight;
    double barHeightWithNotch = 55;
    double arcHeightWithNotch = 55;

    if (size.height > 700) {
      barHeight = 55;
    } else {
      barHeight = size.height * 0.15;
    }

    if (viewPadding.bottom > 0) {
      barHeightWithNotch = (size.height * 0.07) + viewPadding.bottom;
      arcHeightWithNotch = (size.height * 0.075) + viewPadding.bottom;
    }

    return Material(
      child: CircleBottomNavigationBar(
        initialSelection: widget.page_index,
        barHeight: viewPadding.bottom > 0 ? barHeightWithNotch : barHeight,
        arcHeight: viewPadding.bottom > 0 ? arcHeightWithNotch : barHeight,
        itemTextOff: viewPadding.bottom > 0 ? 0 : 1,
        itemTextOn: viewPadding.bottom > 0 ? 0 : 1,
        circleOutline: 15.0,
        shadowAllowance: 0.0,
        circleSize: 50.0,
        blurShadowRadius: 50.0,
        circleColor: yellowColor,
        activeIconColor: primary_color,
        inactiveIconColor: secondary_text_color,
        tabs: getTabsData(),
        onTabChangedListener: (index) => setState((){
          switch(index){
            case 0:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return SearchPage();
                  },
                  transitionsBuilder:
                      (context, animation8, animation15, child) {
                    return FadeTransition(
                      opacity: animation8,
                      child: child,
                    );
                  },
                  transitionDuration: Duration(milliseconds: 3),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return CardDepartments();
                  },
                  transitionsBuilder:
                      (context, animation8, animation15, child) {
                    return FadeTransition(
                      opacity: animation8,
                      child: child,
                    );
                  },
                  transitionDuration: Duration(milliseconds: 3),
                ),
              );
              break;
            case 2:
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
                  transitionDuration: Duration(milliseconds: 3),
                ),
              );
              break;
            case 3:
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
                  transitionDuration: Duration(milliseconds: 3),
                ),
              );
              break;
            case 4:
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
                  transitionDuration: Duration(milliseconds: 3),
                ),
              );
              break;
          }
        }),
      ),
    );
  }
}

List<TabData> getTabsData() {
  return [
    TabData(
      icon: Icons.search,
      iconSize: 25,
      // title: 'Snapshot',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: Icons.widgets_outlined,
      iconSize: 25,
      // title: 'Settings',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
        icon: Icons.home,
        iconSize: 25.0,
        // title: 'Home',
        fontSize: 12,
        fontWeight: FontWeight.bold,
        onClick: (){

        }
    ),
    TabData(
      icon: Icons.shopping_cart,
      iconSize: 25,
     // title: 'Notifications',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: Icons.person_outline,
      iconSize: 25,
     // title: 'Favourite',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),




  ];
}
