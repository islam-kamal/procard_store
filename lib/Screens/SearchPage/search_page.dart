import 'package:procard_store/Bloc/Search_Bloc/search_bloc.dart';
import 'package:procard_store/Model/Home_Models/latest_card_model.dart';
import 'package:procard_store/Widgets/Shimmer/list_shimmer.dart';
import 'package:procard_store/Widgets/custom_circle_navigation_bar.dart';
import 'package:procard_store/fileExport.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SearchPageState();
  }

}

class SearchPageState extends State<SearchPage>{
  TextEditingController controller ;
  String search_text='';
  @override
  void initState() {
    controller = TextEditingController();
    search_bloc.add(SearchEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child:    search_textfield(),
                    ),
                    Container(
                        padding: EdgeInsets.all(StaticData.get_width(context)  * 0.01),
                        height: StaticData.get_height(context) * 0.77,
                        child:  BlocBuilder(
                          bloc: search_bloc,
                          builder: (context, state) {
                            if (state is Loading) {
                              return ListShimmer(
                                type: 'grid_view',
                              );
                            } else if (state is Done) {
                              return StreamBuilder<LatestCardsModel>(
                                  stream: search_bloc.search_subject,
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
                                                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Color(0xfff7f7f7),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(0),
                                                  ),
                                                ),
                                                child: snapshot.data.data[index].name.contains(search_text)?
                                                CardShape(
                                                  cardModel: snapshot.data.data[index],
                                                ): Container(),
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
                        )
                    )
                  ],
                ),
              ),
            ),
          ),

          bottomNavigationBar: CustomCircleNavigationBar(
            page_index: 0,
          ),

        ),
      ),
    );
  }

  Widget search_textfield() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  Container(width: width*.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: width * .83,
              height: height * .07,
              child: Container(
                child: TextField(
                  controller: controller,
                  style: TextStyle(color: primary_color, fontSize: height * .016),
                  cursorColor: primary_color,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          search_text = controller.value.text;
                          print("search_text :${search_text}");
                        });
                      },
                      icon: Icon(Icons.search),
                      ),
                  suffixIcon: InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context)=>super.widget
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: yellowColor)
                      ),
                      child: Icon(Icons.close,color: yellowColor,),
                    ),
                  ),

                    hintText: translator.translate("Search By Order Id"),
                    hintStyle:
                    TextStyle(color: Colors.grey, fontSize: height * .013),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: greenColor)),
                  ),
                ),
              )),
        ],
      ),
    );
/*    return StreamBuilder<String>(
        stream: search_bloc.search,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(
                right: StaticData.get_width(context) * 0.02,
                left: StaticData.get_width(context) * 0.02),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("Search By Name"),
              iconData: Icons.search,
              color: primary_color,
              onchange: search_bloc.search_change,
              suffixIcon: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: yellowColor)
                ),
                child: Icon(Icons.close),
              ),
              errorText: snapshot.error,
              inputType: TextInputType.emailAddress,
            ),
          );
        });*/
  }

}