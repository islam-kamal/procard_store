import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procard_store/Bloc/Discount_Bloc/discount_bloc.dart';
import 'package:procard_store/Model/Discount_Model/discount_model.dart';
import 'package:procard_store/Widgets/Shimmer/list_shimmer.dart';
import 'package:procard_store/fileExport.dart';
class OffersAndDiscounts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return OffersAndDiscountsState();
  }

}

class OffersAndDiscountsState extends State<OffersAndDiscounts>{
  @override
  void initState() {

    discountBloc.add(GetAllDiscountsEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(StaticData.get_width(context)  * 0.01),
        child: Column(
          children: [
            //AppBar
            Padding(
              padding: EdgeInsets.only(top: StaticData.get_width(context)  * 0.05),
              child:  CustomAppBar(
                page_name: 'RecommendationsPage',
                frist_image: 'Assets/Images/menu.png',
                second_image: 'Assets/Images/notifi.png',
                logo: 'Assets/Images/tlogo.png',
              ),
            ),
     /*       Container(
              height: StaticData.get_height(context) * 0.85,
              child: GridView.builder(

                  itemCount: offer_list.length,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .9000,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xfff7f7f7),
                          borderRadius: BorderRadius.all(
                            Radius.circular(0),
                          ),
                        ),
                        child:  CardShape(
                         // cardModel: offer_list[index],
                          discount: 25.toString(),
                        )
                    );
                  })
            )*/

     Container(
       height: StaticData.get_height(context) * 0.85,
       child: BlocBuilder(
         bloc: discountBloc,
         builder: (context, state) {
           if (state is Loading) {
             return ListShimmer(
               type: 'grid_view',
             );
           } else if (state is Done) {
               return StreamBuilder<DiscountModel>(
                   stream: discountBloc.discount_subject,
                   builder: (context, snapshot) {
                     if (snapshot.hasData) {
                       if (snapshot.data.data.isEmpty) {
                         return ListShimmer(
                           type: 'grid_view',
                         );
                       } else {
                         return  GridView.builder(
                             itemCount: snapshot.data.data.length,
                             gridDelegate:
                             SliverGridDelegateWithFixedCrossAxisCount(
                               crossAxisCount: 2,
                               childAspectRatio: .9000,
                             ),
                             itemBuilder: (BuildContext context, int index) {
                               return Container(
                                   margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                   alignment: Alignment.center,
                                   decoration: BoxDecoration(
                                     color: Color(0xfff7f7f7),
                                     borderRadius: BorderRadius.all(
                                       Radius.circular(0),
                                     ),
                                   ),
                                   child:  DiscountCardShape(
                                     discountModel: snapshot.data.data[index],
                                   )
                               );
                             });
                       }
                     } else {
                       return ListShimmer(
                         type: 'grid_view',
                       );
                     }
                   });

           } else if (state is ErrorLoading) {
               return ListShimmer(
                 type: 'grid_view',
               );

           }else{
             return Container();
           }
         },
       ),
     )

          ],
        ),
      ),
      endDrawer: CustomComponents.sideBarMenu(context),

    );
  }

}