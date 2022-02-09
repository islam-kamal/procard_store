
import 'package:procard_store/Model/Orders_Model/order_details_model.dart';
import 'package:procard_store/fileExport.dart';
import 'package:clipboard/clipboard.dart';

class OrderCodes extends StatefulWidget{
  final int order_id;
  OrderCodes({this.order_id});
  @override
  State<StatefulWidget> createState() {
    return OrderCodesState();
  }

}

class OrderCodesState extends State<OrderCodes>{
  @override
  void initState() {
    ordersBloc.add(OrderDetailsEvent(
      order_id: 22
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          body: Directionality(
            textDirection: translator.currentLanguage =='ar'? TextDirection.rtl : TextDirection.ltr,
            child: Column(
              children: [
                CustomAppBar(
                  text: translator.translate("Card Codes"),
                  page_name: 'OrderCodes',
                ),
                SizedBox(
                  height: height * .01,
                ),
                BlocBuilder(
                    bloc: ordersBloc,
                    builder: (context,state){
                      if(state is Loading){
                        return Center(child: SpinKitFadingCircle(
                          itemBuilder: (BuildContext context, int index) {
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                color: index.isEven ? primary_color : whiteColor,
                              ),
                            );
                          },
                        ));
                      }else if(state is Done){
                        var data = state.model as OrderDetailsModel;
                        return Column(
                          children: [
                            order_products_details(
                              product: data.data[0].product
                            ),
                            codes_text(),
                            serial_number(
                              code: data.data[0].code,
                              serial: data.data[0].serial,
                              vaild: data.data[0].validUntil
                            )
                          ],
                        );
                      }else if(state is ErrorLoading){
                        return NoData(
                          message: translator.translate("There is no Data"),
                        );
                      }
                    }
                    ),
              ],
            ),

          ),
        ),
      ),
    );
  }
  Widget order_products_details({Product product}){
    double width = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: translator.currentLanguage =='ar'? TextDirection.rtl : TextDirection.ltr,
        child:Padding(padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(product.logo),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: product.name,
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
                                  text: "${product.country.name}  : ${translator.translate("Country")}",
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
                                        text: "${translator.translate("SAR")} ${product.priceAfterDiscount}  :",
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
                                text: "${translator.translate("Quantity")}  :  ${product.country.id}",
                                size: ProdCardStoreFont.primary_font_size,
                                color: black_color,
                                weight: FontWeight.normal,),

                            ],
                          ),
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
          ),)
    );
  }

  Widget codes_text(){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Directionality(
        textDirection: translator.currentLanguage =='ar'? TextDirection.rtl : TextDirection.ltr,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: translator.translate( "Card Codes"),
                  size: ProdCardStoreFont.header_font_size,
                  weight: FontWeight.bold,
                  color: primary_color,),
                MyText(
                  text: translator.translate("your Card codes"),
                  size: ProdCardStoreFont.secondary_font_size,
                  color: gray_color,),
              ],
            )

          ],
        ),
      ),
    );
  }

  Widget serial_number({String serial , String code , String vaild}){
    return Padding(
        padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                  text: code,
                  size: ProdCardStoreFont.header_font_size,
                color: primary_color,
                weight: FontWeight.bold,
              ),
              SizedBox(height: 10,),
              MyText(
                text: " ${serial} :  ${translator.translate("Serial Number")} ",
                size: ProdCardStoreFont.primary_font_size,
                color: primary_color,
                weight: FontWeight.normal,
              ),
              SizedBox(height: 10,),
              MyText(
                text: " ${vaild}  :  ${translator.translate("Valid Until")} " ,
                size: ProdCardStoreFont.secondary_font_size,
                color: gray_color,
                weight: FontWeight.normal,
              ),
            ],
          ),

          Row(
            children: [
              InkWell(
                onTap: (){
                  WidgetsBinding.instance.addPostFrameCallback((_) async{
                    Clipboard.setData(
                        ClipboardData(
                            text: code)).then((value) {
                      final snackBar = SnackBar(
                        content: Text(
                            translator.translate("Copied to Clipboard")),
                        backgroundColor: greenColor,

                      );
                      print("111111111111");
                      Scaffold.of(context).showSnackBar(snackBar);
                    });
                  });

                },
                child:    MyText(
                  text: translator.translate("Copy"),
                  size: ProdCardStoreFont.primary_font_size,
                  color: primary_color,),
              ),
              SizedBox(width: 10,),
              Icon(Icons.insert_drive_file,color: gray_color,)
            ],
          )
        ],
      ),
    );
  }

}