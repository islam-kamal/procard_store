
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procard_store/Bloc/Bank_Bloc/bank_bloc.dart';
import 'package:procard_store/Model/Bank_Model/bank_model.dart';
import 'package:procard_store/Screens/SideBarMenu/BankAccounts/bank_account_shape.dart';
import 'package:procard_store/Widgets/Shimmer/list_shimmer.dart';
import 'package:procard_store/Widgets/Shimmer/shimmer_notification.dart';
import 'package:procard_store/fileExport.dart';
class BankAccounts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return BankAccountsState();
  }

}

class BankAccountsState extends State<BankAccounts>{
  @override
  void initState() {
    bankBloc.add(GetBanksEvent());
    super.initState();
  }
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
                //AppBar
                CustomAppBar(
                  page_name: 'RecommendationsPage',
                  frist_image: 'Assets/Images/menu.png',
                  second_image: 'Assets/Images/notifi.png',
                  logo: 'Assets/Images/tlogo.png',

                ),
                Container(
                    padding: EdgeInsets.only(top: StaticData.get_width(context) *0.01),
                    height: StaticData.get_height(context) * 0.84,
                    child:       BlocBuilder(
                      bloc: bankBloc,
                      builder: (context, state) {
                        if (state is Loading) {
                          return ShimmerNotification(
                          );
                        } else if (state is Done) {
                          return StreamBuilder<BankModel>(
                              stream: bankBloc.bank_subject,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.data.isEmpty) {
                                    return ShimmerNotification(
                                    );
                                  } else {
                                    return  ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: snapshot.data.data.length,
                                        itemBuilder: (context,index){
                                          return BankAccountShape(
                                            bank_image: snapshot.data.data[index].logo,
                                            bank_name: snapshot.data.data[index].title,
                                            account_number: snapshot.data.data[index].accountNumber,
                                            iban_number: snapshot.data.data[index].iban,
                                          );
                                        });
                                  }
                                } else {
                                  return ShimmerNotification(
                                  );
                                }
                              });
                        } else if (state is ErrorLoading) {

                          return ShimmerNotification(
                          );

                        }else{
                          return Container();
                        }
                      },
                    )

                )



              ],
            ),
          ),
        ),
      ),
      endDrawer: CustomComponents.sideBarMenu(context),

    )));
  }

}