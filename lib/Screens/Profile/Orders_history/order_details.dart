import 'package:procard_store/Base/network-mappers.dart';
import 'package:procard_store/Model/Orders_Model/orders_model.dart';
import 'package:procard_store/Screens/Profile/Orders_history/order_codes.dart';
import 'package:procard_store/Screens/SideBarMenu/BankAccounts/bank_accounts.dart';
import 'package:procard_store/Widgets/customButton.dart';
import 'package:procard_store/Widgets/visitor_message.dart';
import 'package:procard_store/fileExport.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
class OrderDetails extends StatefulWidget{
  final String route;
  OrdersModel order_details;
  OrderDetails({this.order_details,this.route});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderDetailsState();
  }
}
class OrderDetailsState extends State<OrderDetails>{

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
      child: PageContainer(
        child: Directionality(
          textDirection: translator.currentLanguage =='ar'? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            body:  (StaticData.vistor_value == 'visitor')
                ? VistorMessage()
                : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    page_appbar(),
                    details_text(),
                    order_detials_widget(),
                    order_text(),
                    order_products_details(),

                    (widget.order_details.status == "Waiting"
                        || widget.order_details.status == "Done"
                        || widget.order_details.status ==  "Cancelled")? Container() : bank_accounts(),

                     SizedBox(height: width * 0.1,),

                    ( widget.order_details.status == "Done"
                        || widget.order_details.status ==  "Cancelled")? Container() : cancel_order_btn()

                  ],
                ),
              ),
            )
          ),
        ),
      ),
    );
  }

  Widget page_appbar(){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return      Padding(
        padding: EdgeInsets.only(
            left: width * .045, right: width * .045, top: height * .02,bottom: height * .02),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
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
                    transitionDuration: Duration(milliseconds: 10),
                  ),
                );
              },
              child: Icon(Icons.close_outlined),
            ),
            MyText(
              text: 'Order Details',
              size: ProdCardStoreFont.header_font_size,
              color: black_color,
              weight: FontWeight.bold,),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context)=>     PdfPreview(
                            build: (format) =>CustomComponents.generatePdf(
                                format: format,
                                status: widget.order_details.status,
                                date: widget.order_details.createdAt,
                                price: widget.order_details.totalPrice,
                                products: widget.order_details.products,
                                order_number: widget.order_details.id.toString()
                            )
                        )
                    ));
                  },
                  child: Icon(Icons.print,color: yellowColor,),
                ),
                SizedBox(
                  width: width * 0.06,
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Icon(
                    Icons.ios_share,
                    color: primary_color,
                  ),
                ),
              ],
            )
          ],
        ));
  }

  Widget details_text(){
    return Padding(
      padding: EdgeInsets.all(20),
      child: Directionality(
        textDirection: translator.currentLanguage =='ar'? TextDirection.rtl : TextDirection.ltr,
        child: Row(
          children: [
            Icon(
              Icons.drive_file_rename_outline,
              color: primary_color,
              size: 30,
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: translator.translate("Order Details"),
                  size: ProdCardStoreFont.header_font_size,
                  color: primary_color,),
                MyText(
                  text: translator.translate( "you order details"),
                  size: ProdCardStoreFont.secondary_font_size,
                  color: gray_color,),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget order_detials_widget(){
    print("status : ${widget.order_details.status}");
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: translator.translate("Order Number"),
                  size: ProdCardStoreFont.primary_font_size,
                  weight: FontWeight.normal,
                  color: black_color,),
                MyText(
                  text: translator.translate("${widget.order_details.id}"),
                  size: ProdCardStoreFont.primary_font_size,
                  weight: FontWeight.normal,
                  color: black_color,),
              ],
            ) ,
          ),
    Padding(
    padding: EdgeInsets.all(10),
    child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: translator.translate("Order Date"),
                size: ProdCardStoreFont.primary_font_size,
                weight: FontWeight.normal,
                color: black_color,),
              MyText(
                text: translator.translate("${widget.order_details.createdAt.substring(0,10)}"),
                size: ProdCardStoreFont.primary_font_size,
                weight: FontWeight.normal,
                color: black_color,),
            ],
    ) ),
    Padding(
    padding: EdgeInsets.all(10),
    child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: translator.translate("Order Status"),
                size: ProdCardStoreFont.primary_font_size,
                weight: FontWeight.normal,
                color: black_color,),
              MyText(
                text: "${widget.order_details.status}",
                size: ProdCardStoreFont.primary_font_size,
                weight: FontWeight.normal,
                color: black_color,),
            ],
    ) ),
    Padding(
    padding: EdgeInsets.all(10),
    child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: translator.translate("SubTotal"),
                size: ProdCardStoreFont.primary_font_size,
                weight: FontWeight.normal,
                color: black_color,),
              MyText(
                text: translator.translate("${widget.order_details.totalPrice} ${translator.translate("SAR")}" ),
                size: ProdCardStoreFont.primary_font_size,
                weight: FontWeight.normal,
                color: black_color,),
            ],
    )),
    Padding(
    padding: EdgeInsets.all(10),
    child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: translator.translate("International administrative fee"),
                size: ProdCardStoreFont.primary_font_size,
                weight: FontWeight.normal,
                color: black_color,),
              MyText(
                text: translator.translate("${10} ${translator.translate("SAR")}"),
                size: ProdCardStoreFont.primary_font_size,
                weight: FontWeight.normal,
                color: black_color,),
            ],
          )),
          Padding(
          padding: EdgeInsets.all(10),
    child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: translator.translate("Order Total"),
                size: ProdCardStoreFont.primary_font_size,
                weight: FontWeight.normal,
                color: black_color,),
              MyText(
                text: translator.translate("${double.parse(widget.order_details.totalPrice) + 10}  ${translator.translate("SAR")}"),
                size: ProdCardStoreFont.primary_font_size,
                weight: FontWeight.normal,
                color: black_color,),
            ],
          )),
    Padding(
    padding: EdgeInsets.all(10),
    child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: translator.translate("Payment method"),
                size: ProdCardStoreFont.primary_font_size,
                weight: FontWeight.normal,
                color: black_color,),
              MyText(
                text: translator.translate("${widget.order_details.paymentType}"),
                size: ProdCardStoreFont.primary_font_size,
                weight: FontWeight.normal,
                color: black_color,),
            ],
    ) ),
        ],
      )
    );
  }

  Widget order_text(){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Directionality(
        textDirection: translator.currentLanguage =='ar'? TextDirection.rtl : TextDirection.ltr,
        child: Row(
          children: [
            Icon(
              Icons.drive_file_rename_outline,
              color: primary_color,
              size: 30,
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: translator.translate("Your Order"),
                  size: ProdCardStoreFont.header_font_size,
                  color: primary_color,),
                MyText(
                  text: translator.translate("What you have added to Cart"),
                  size: ProdCardStoreFont.secondary_font_size,
                  color: gray_color,),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget order_products_details(){
    double width = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: translator.currentLanguage =='ar'? TextDirection.rtl : TextDirection.ltr,
        child:Padding(
        padding: EdgeInsets.all(10),
      child: ListView.builder(
        shrinkWrap: true,
          itemCount: widget.order_details.products.length,
          itemBuilder: (context,index){
           return Padding(padding: EdgeInsets.all(5),
           child: Column(
             children: [
               Row(
                 children: [
                   Expanded(
                     flex: 1,
                     child: Image.network(widget.order_details.products[index].logo),
                   ),
                   Expanded(
                     flex: 3,
                     child: Padding(
                       padding: EdgeInsets.all(10),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           MyText(
                             text: widget.order_details.products[index].name,
                             size: ProdCardStoreFont.header_font_size,
                             color: black_color,
                             weight: FontWeight.bold,
                           ),
                           SizedBox(height: 10,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Container(
                                 decoration: BoxDecoration(
                                     color: pink_color
                                 ),
                                 child:  MyText(
                                 text: "${widget.order_details.products[index].country.name}  : ${translator.translate("Country")}",
                                 size: ProdCardStoreFont.primary_font_size,
                                 color: black_color,
                                 weight: FontWeight.normal,),),
                               Container(
                                 decoration: BoxDecoration(
                                     color: pink_color
                                 ),
                                 child:  Row(
                                   children: [
                                     MyText(
                                       text: " ${translator.translate("Value")}",
                                       size: ProdCardStoreFont.primary_font_size,
                                       color: black_color,
                                       weight: FontWeight.normal,),
                                     MyText(
                                       text: "${translator.translate("SAR")} ${widget.order_details.products[index].priceAfterDiscount}  :",
                                       size: ProdCardStoreFont.primary_font_size,
                                       color: black_color,
                                       weight: FontWeight.normal,)

                                   ],
                                 )),
                             ],
                           ),
                           SizedBox(height: 10,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               MyText(
                                 text: "${translator.translate("Quantity")}  :  ${widget.order_details.products[index].country.id}",
                                 size: ProdCardStoreFont.primary_font_size,
                                 color: black_color,
                                 weight: FontWeight.normal,),
                               SizedBox(width: width * 0.2,),
                               MyText(
                                 text: " ${double.parse(widget.order_details.products[index].priceAfterDiscount) * 2} ${translator.translate("SAR")}",
                                 size: ProdCardStoreFont.header_font_size,
                                 color: black_color,
                                 weight: FontWeight.bold,),
                             ],
                           ),
                        widget.order_details.status == "Done" ?   CustomButton(
                               givenHeight: width * 0.1, 
                               givenWidth: width * 0.5,
                               borderColor: primary_color,
                               buttonColor: whiteColor,
                               fontSize: ProdCardStoreFont.primary_font_size,
                               textColor: primary_color,
                               text: translator.translate("Show Code"),
                               onTapFunction: (){
                                 Navigator.push(
                                   context,
                                   PageRouteBuilder(
                                     pageBuilder: (context, animation1, animation2) {
                                       return OrderCodes(
                                        order_id: widget.order_details.id,
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
                               }) : Container(),
                         ],
                       ),
                     ),
                   ),

                 ],
               ),
               Divider(
                 color: black_color,
                 height: 2,
               )
             ],
           ),);
          }
      )  )
    );
  }

  Widget bank_accounts(){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Directionality(
        textDirection: translator.currentLanguage =='ar'? TextDirection.rtl : TextDirection.ltr,
        child: InkWell(
          onTap: (){
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
          child: Container(
            decoration: BoxDecoration(
                color: pink_color
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.description_outlined,
                      color: primary_color,
                      size: 30,
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: translator.translate("Bank Accounts"),
                          size: ProdCardStoreFont.header_font_size,
                          color: primary_color,),
                        MyText(
                          text: translator.translate("you order details"),
                          size: ProdCardStoreFont.secondary_font_size,
                          color: gray_color,),
                      ],
                    )
                  ],
                ),
                Icon(
                    Icons.arrow_forward_ios
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cancel_order_btn(){
    return  Padding(
      padding: EdgeInsets.all(10),
      child:GestureDetector(
        onTap:() {
          CustomComponents.cancel_order(
              context: context,
              order_id: widget.order_details.id
          );
        },
        child: Container(
            width: StaticData.get_width(context) * 0.9,
            height: 40,
            alignment: FractionalOffset.center,
            decoration: BoxDecoration(
              color: third_color,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: yellowColor),
                  ),
                  child: Icon(Icons.close,color: yellowColor,),
                ),
                SizedBox(width: 10,),
                Text(
                  translator.translate(  "Cancel Order"),
                  style: const TextStyle(
                    color: whiteColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.3,
                  ),
                )
              ],
            )

        ),
      ),
    );

  }
}