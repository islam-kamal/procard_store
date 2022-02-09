import 'dart:typed_data';

import 'package:procard_store/Model/Orders_Model/orders_model.dart';
import 'package:procard_store/Repository/AuthenticationRepo/authentication_repository.dart';
import 'package:procard_store/Screens/SideBarMenu/AboutUs/about_us.dart';
import 'package:procard_store/Screens/SideBarMenu/BankAccounts/bank_accounts.dart';
import 'package:procard_store/Screens/SideBarMenu/Call_Us/call_us.dart';
import 'package:procard_store/Screens/SideBarMenu/CommonQuestions/common_questions.dart';
import 'package:procard_store/Screens/SideBarMenu/OffersAndDiscounts/offers_and_discounts.dart';
import 'package:procard_store/Screens/SideBarMenu/PrivacyPolicy/privacy_policy.dart';
import 'package:procard_store/Screens/SideBarMenu/Recommendations/recommendations.dart';
import 'package:procard_store/Screens/SideBarMenu/TermsAndConditions/terms_and_conditions.dart';
import 'package:procard_store/Widgets/customButton.dart';
import 'package:procard_store/Widgets/customText.dart';
import 'package:procard_store/fileExport.dart';
import 'package:procard_store/Screens/Profile/Orders_history/share_order_pdf.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:procard_store/Model/Orders_Model/orders_model.dart';
class CustomComponents {

  static Widget rowWithTwoItems(
      BuildContext context, var frist_text, var second_text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MyText(
          text: frist_text,
          color: black_color,
          weight: FontWeight.bold,
          size: ProdCardStoreFont.primary_font_size,
        ),
        MyText(
          text: second_text,
          color: gray_color,
          weight: FontWeight.normal,
          size: ProdCardStoreFont.primary_font_size,
        ),
      ],
    );
  }

  static Widget homeTitleRow(
      BuildContext context, var frist_text, var second_text) {
    return Column(
      crossAxisAlignment:  CrossAxisAlignment.start,
      children: [
        MyText(
          text: frist_text,
          color: black_color,
          weight: FontWeight.bold,
          size: ProdCardStoreFont.header_font_size,
        ),
        MyText(
          text: second_text,
          color: gray_color,
          weight: FontWeight.normal,
          size: ProdCardStoreFont.primary_font_size,
        ),
      ],
    );
  }

  static Widget seeAll({BuildContext context, StatefulWidget page}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: translator.translate("See all"),
          color: yellowColor,
          weight: FontWeight.normal,
          size: ProdCardStoreFont.primary_font_size,
        ),
          SizedBox(
    width: 10,
    ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return page;
                },
                transitionsBuilder: (context, animation8, animation15, child) {
                  return FadeTransition(
                    opacity: animation8,
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 10),
              ),
            );
          },
          child: Image.asset(
            translator.currentLanguage=='ar' ?'Assets/Images/all.png' : 'Assets/Images/skip.png',
            color: yellowColor,
          ),
        )

      ],
    );
  }

  static Widget sideBarMenu(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(color: primary_text_color),
              child: Image.asset(
                'Assets/Images/sidetop.png',
                fit: BoxFit.cover,
              )),
          ListTile(
            onTap: () {
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
                  transitionDuration: Duration(milliseconds: 10),
                ),
              );
            },
            trailing: Image.asset(
              'Assets/Images/shome.png',
            ),
            title: Text(
              translator.translate("Home"),
              style: TextStyle(
                color: primary_color,
                fontSize: ProdCardStoreFont.primary_font_size,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return RecommendationsPage();
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
            trailing: Image.asset(
              'Assets/Images/srec.png',
            ),
            title: Text(
              translator.translate("Recommendations"),
              style: TextStyle(
                color: primary_color,
                fontSize: ProdCardStoreFont.primary_font_size,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return OffersAndDiscounts();
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
            trailing: Image.asset(
              'Assets/Images/soffers.png',
            ),
            title: Text(
              translator.translate("Offers and discounts"),
              style: TextStyle(
                color: primary_color,
                fontSize: ProdCardStoreFont.primary_font_size,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return AboutUs();
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
            trailing: Image.asset(
              'Assets/Images/sabout.png',
            ),
            title: Text(
              translator.translate("About Us"),
              style: TextStyle(
                color: primary_color,
                fontSize: ProdCardStoreFont.primary_font_size,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return TermsAndConditions();
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
            trailing: Image.asset(
              'Assets/Images/sshrot.png',
            ),
            title: Text(
              translator.translate("Terms and Conditions"),
              style: TextStyle(
                color: primary_color,
                fontSize: ProdCardStoreFont.primary_font_size,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return PrivacyPolicy();
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
            trailing: Image.asset(
              'Assets/Images/sprivacy.png',
            ),
            title: Text(
              translator.translate("Privacy Policy"),
              style: TextStyle(
                color: primary_color,
                fontSize: ProdCardStoreFont.primary_font_size,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return CommonQuestions();
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
            trailing: Image.asset(
              'Assets/Images/squestion.png',
            ),
            title: Text(
              translator.translate("Common Questions"),
              style: TextStyle(
                color: primary_color,
                fontSize: ProdCardStoreFont.primary_font_size,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return BankAccounts();
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
            trailing: Image.asset(
              'Assets/Images/saccounts.png',
            ),
            title: Text(
              translator.translate("Bank Accounts"),
              style: TextStyle(
                color: primary_color,
                fontSize: ProdCardStoreFont.primary_font_size,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return CallUs();
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
            trailing: Image.asset(
              'Assets/Images/scall.png',
            ),
            title: Text(
              translator.translate("Call Us"),
              style: TextStyle(
                color: primary_color,
                fontSize: ProdCardStoreFont.primary_font_size,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          ListTile(
            onTap: () async {
              print("visitor : ${StaticData.vistor_value}");
              if (StaticData.vistor_value == 'visitor') {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return SignInScreen();
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
              } else {
                var response = await AuthenticationRepository.logout();
                if (response.status == 200) {
                  StaticData.vistor_value == 'visitor';
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return SignInScreen();
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
                } else {
                  Flushbar(
                    messageText: Row(
                      children: [
                        Text(
                          '${response.message}',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: whiteColor),
                        ),
                        Spacer(),
                        Text(
                          translator.translate("Try Again"),
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: whiteColor),
                        ),
                      ],
                    ),
                    flushbarPosition: FlushbarPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    flushbarStyle: FlushbarStyle.FLOATING,
                    duration: Duration(seconds: 6),
                  )..show(context);
                }
              }
            },
            trailing: Image.asset(
              'Assets/Images/sout.png',
            ),
            title: Text(
              translator.translate("LogOut"),
              style: TextStyle(
                color: primary_color,
                fontSize: ProdCardStoreFont.primary_font_size,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }

  static void filterByStatusBottomSheet({
    BuildContext context,
    List data,
  }) {
    showModalBottomSheet<void>(
        context: context,
        shape: OutlineInputBorder(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return StreamBuilder<String>(
            stream: ordersBloc.radio_value,
            builder: (context, snapshot) {
              return Directionality(
                  textDirection: translator.currentLanguage == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: Container(
                      height: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 10),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                RadioListTile(
                                  value: data[index],
                                  groupValue:
                                      ordersBloc.radio_choosed_value.value,
                                  onChanged: (value) {
                                    print("value : $value");
                                    if (value == "All") {
                                      ordersBloc.selectRadioValue(null);
                                    } else {
                                      ordersBloc.selectRadioValue(value);
                                    }

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrdersHistoryPage()));
                                  },
                                  title: Text(
                                    "${data[index]}",
                                    textDirection: TextDirection.rtl,
                                  ),
                                  activeColor: greenColor,
                                ),
                                Divider(
                                  color: Color(0xFFDADADA),
                                )
                              ],
                            );
                          })));
            },
          );
        });
  }

  static void order_procedures({BuildContext context ,int order_number,String status,String date,List<Products> products,String price }) {
    showModalBottomSheet<void>(
        context: context,
        shape: OutlineInputBorder(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return Directionality(
              textDirection: translator.currentLanguage == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Container(
                  height: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.only(top: 10),
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            share_order(
                              order_number: order_number,
                              products: products,
                              price: price,
                              date:date,
                              status: status,
                              context: context
                            );
                          },
                          child: Row(
                            children: [
                              Image.asset('Assets/Images/shnow.png'),
                              SizedBox(
                                width: 20,
                              ),
                              MyText(
                                text: translator.translate("Share Order"),
                                size: ProdCardStoreFont.primary_font_size,
                                color: black_color,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Image.asset('Assets/Images/print.png'),
                                SizedBox(
                                  width: 20,
                                ),
                                MyText(
                                  text: translator.translate("Print Order"),
                                  size: ProdCardStoreFont.primary_font_size,
                                  color: black_color,
                                ),
                              ],
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                              cancel_order(
                                context: context,
                                 order_id: order_number
                              );
                            },
                            child: Row(
                              children: [
                                Image.asset('Assets/Images/cancel.png'),
                                SizedBox(
                                  width: 20,
                                ),
                                MyText(
                                    text: translator.translate("Cancel Order"),
                                    color: black_color,
                                    size: ProdCardStoreFont.primary_font_size)
                              ],
                            ),
                          ))
                    ],
                  )));
        });
  }

  static void cancel_order({BuildContext context , int order_id}){
    var width = MediaQuery.of(context).size.width;
    Navigator.pop(context);
    showModalBottomSheet<void>(
        context: context,
        shape: OutlineInputBorder(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return BlocListener<OrdersBloc,AppState>(
            bloc: ordersBloc,
              listener: (context , state){
                if(state is Loading){

                }else if(state is Done){
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return OrdersHistoryPage();
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
                }else if(state is ErrorLoading){
                  var data = state.model as GeneralResponseModel;

                  errorDialog(
                    context: context,
                     text: data.message
                  );
                }
              },
            child: Directionality(
              textDirection: translator.currentLanguage == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Container(
                  height: MediaQuery.of(context).size.width /1.5 ,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center ,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset('Assets/Images/popcancel.png'),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: MyText(
                            text: translator.translate("Cancel Order"),
                            color: black_color,
                            size: ProdCardStoreFont.header_font_size,
                            weight: FontWeight.bold,
                          )),
                      MyText(
                        text: translator.translate("Do you really want to confirm canceling your order" + "  #${order_id}"),
                        color: black_color,
                        size: ProdCardStoreFont.primary_font_size,
                        weight: FontWeight.normal,
                      ),
                      SizedBox(height: width * 0.1,),
                      Padding(
                          padding: EdgeInsets.only(right: width* 0.05,left: width*0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomButton(
                                givenHeight: width * 0.15,
                                givenWidth: width * 0.4,
                                borderColor : primary_color,
                                onTapFunction: (){
                                  Navigator.pop(context);
                                },
                                text: translator.translate("Cancel"),
                                fontSize: ProdCardStoreFont.primary_font_size,
                                textColor: primary_color,
                                buttonColor: whiteColor,
                              ),
                              CustomButton(
                                givenHeight: width * 0.15,
                                givenWidth: width * 0.4,
                                fontSize: ProdCardStoreFont.primary_font_size,

                                onTapFunction: (){
                                  ordersBloc.add(CancelOrderEvent(
                                    order_id: order_id
                                  ));
                                },
                                text: translator.translate("Confirm"),
                                textColor: whiteColor,
                                buttonColor: primary_color,
                              ),

                            ],
                          ))
                    ],
                  ))),);
        });
  }


  static void share_order({BuildContext context ,int order_number,String status,String date,List<Products> products,String price}){
    var width = MediaQuery.of(context).size.width;
  //  Navigator.pop(context);
    showModalBottomSheet<void>(
        context: context,
        shape: OutlineInputBorder(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return BlocListener<OrdersBloc,AppState>(
            bloc: ordersBloc,
            listener: (context , state){
              if(state is Loading){

              }else if(state is Done){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return OrdersHistoryPage();
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
              }else if(state is ErrorLoading){
                var data = state.model as GeneralResponseModel;

                errorDialog(
                    context: context,
                    text: data.message
                );
              }
            },
            child: Directionality(
                textDirection: translator.currentLanguage == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Container(
                    height: MediaQuery.of(context).size.width /2 ,
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                         Navigator.pushReplacement(context, MaterialPageRoute(
                           builder: (context)=>     PdfPreview(
                               build: (format) => generatePdf(
                                   format: format,
                                   status: status,
                                   date: date,
                                   price: price,
                                   products: products,
                                   order_number: order_number.toString()
                               )
                           )
                         ));
                            },
                            child: Row(
                              children: [
                                Image.asset('Assets/Images/pdf.png'),
                                SizedBox(
                                  width: 20,
                                ),
                                MyText(
                                  text: translator.translate("PDF"),
                                  size: ProdCardStoreFont.primary_font_size,
                                  color: black_color,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Image.asset('Assets/Images/excel.png'),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  MyText(
                                    text: translator.translate("EXCEL"),
                                    size: ProdCardStoreFont.primary_font_size,
                                    color: black_color,
                                  ),
                                ],
                              ),
                            )),

                      ],
                    )
                )),);
        });
  }

 static Future<Uint8List> generatePdf({PdfPageFormat format, String order_number, String price, String status, String date,List<Products> products }) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.ListView(
            children: [
              pw.SizedBox(
                width: double.infinity,
                child: pw.Text('#$order_number', style: pw.TextStyle(font: font)),),

              pw.SizedBox(height: 20),
              pw.Text('Price :  ${price}', style: pw.TextStyle(font: font)),
              pw.SizedBox(height: 20),
              pw.Text('products', style: pw.TextStyle(font: font)),
              pw.ListView.builder(
                itemCount: products.length,
                itemBuilder: (context , index){
                  return    pw.Text('${products[index].name}', style: pw.TextStyle(font: font));
                },
              ),
              pw.SizedBox(height: 20),
              pw.Text('status   :  ${status}', style: pw.TextStyle(font: font)),
              pw.SizedBox(height: 20),
            pw.Text('date   :  ${date}', style: pw.TextStyle(font: font)),

            ],
          );
        },
      ),
    );

    return pdf.save();
  }





}
