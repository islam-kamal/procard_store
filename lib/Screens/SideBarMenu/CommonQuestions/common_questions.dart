
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procard_store/Bloc/CommonQuestion_Bloc/common_questions_bloc.dart';
import 'package:procard_store/Model/Common_Questions_Model/common_questions_model.dart';
import 'package:procard_store/Screens/SideBarMenu/CommonQuestions/question_answer.dart';
import 'package:procard_store/Widgets/Shimmer/shimmer_notification.dart';
import 'package:procard_store/fileExport.dart';
class CommonQuestions extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CommonQuestionsState();
  }

}

class CommonQuestionsState extends State<CommonQuestions>{
  List questions_list;
  @override
  void initState() {
    commonQuestionsBloc.add(GetCommonQuestionsEvent());
    super.initState();

    questions_list = [
      'ما الذي يقدمه بروكارد ستور ؟',
      'ما الذي يقدمه بروكارد ستور ؟',
      'ما الذي يقدمه بروكارد ستور ؟',
      'ما الذي يقدمه بروكارد ستور ؟',
    'ما الذي يقدمه بروكارد ستور ؟',
    'ما الذي يقدمه بروكارد ستور ؟'
    ];
  }
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(StaticData.get_width(context) * 0.01),
            child: Column(
              children: [
                //AppBar
                CustomAppBar(
                  frist_image: 'Assets/Images/menu.png',
                  second_image: 'Assets/Images/notifi.png',
                  text: translator.translate("Common Questions"),

                ),
                Padding(
                    padding: EdgeInsets.all( StaticData.get_width(context) * 0.03),
                    child: BlocBuilder(
                      bloc: commonQuestionsBloc,
                      builder: (context, state) {
                        if (state is Loading) {
                          return ShimmerNotification(
                          );
                        } else if (state is Done) {
                          return StreamBuilder<CommonQuestionsModel>(
                              stream: commonQuestionsBloc.common_questions_subject,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.data.isEmpty) {
                                    return NoData(
                                      message: "No Questions",
                                    );
                                  } else {
                                    return  ListView.builder(
                                        itemCount: snapshot.data.data.length,
                                        shrinkWrap: true,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons.arrow_back_ios),
                                                    onPressed: (){
                                                      Navigator.push(
                                                        context,
                                                        PageRouteBuilder(
                                                          pageBuilder: (context, animation1, animation2) {
                                                            return QuestionAnswer(
                                                              question:  snapshot.data.data[index].title ,
                                                              answer: snapshot.data.data[index].content ,
                                                            );
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
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        child: MyText(
                                                            text: snapshot.data.data[index].title,
                                                            size: ProdCardStoreFont.header_font_size,
                                                            color: primary_color,
                                                            weight: FontWeight.bold,

                                                          ),
                                                        width: StaticData.get_width(context) * 0.6,
                                                      ),

                                                      Container(
                                                        alignment:Alignment.center,
                                                        decoration: BoxDecoration(
                                                          color: yellowColor,
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                        child: Text("${index+1}",textAlign: TextAlign.center,style: TextStyle(color: primary_color),),
                                                        width: StaticData.get_width(context) * 0.09,
                                                        height: StaticData.get_width(context) * 0.09,
                                                      ),

                                                    ],
                                                  ),

                                                ],
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              ),
                                              Divider(color: primary_color,thickness: 0.3,)
                                            ],
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
                    ),

                  /* ListView.builder(
                      shrinkWrap: true,
                        itemCount: questions_list.length,
                        itemBuilder: (context , index){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1, animation2) {
                                            return QuestionAnswer(
                                              question: questions_list[index] ,
                                            );
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
                                  ),
                                  Row(
                                    children: [
                                      MyText(
                                        text: questions_list[index],
                                        size: ProdCardStoreFont.header_font_size,
                                        color: primary_color,
                                        weight: FontWeight.bold,
                                      ),
                                      Container(
                                        alignment:Alignment.center,
                                        decoration: BoxDecoration(
                                          color: yellowColor,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Text("${index+1}",textAlign: TextAlign.center,style: TextStyle(color: primary_color),),
                                        width: StaticData.get_width(context) * 0.09,
                                        height: StaticData.get_width(context) * 0.09,
                                      ),

                                    ],
                                  ),

                                ],
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              ),
                              Divider(color: primary_color,thickness: 0.3,)
                            ],
                          );
                        }
                    )*/
                ),

              ],
            ),
          ),
          endDrawer: CustomComponents.sideBarMenu(context),
        ),
      ),
    );
  }

}