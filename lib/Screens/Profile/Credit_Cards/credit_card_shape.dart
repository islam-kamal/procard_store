import 'package:procard_store/Bloc/CreditCard_Bloc/credit_card_bloc.dart';
import 'package:procard_store/Screens/Profile/Credit_Cards/credit_cards_screen.dart';
import 'package:procard_store/Widgets/customButton.dart';
import 'package:procard_store/Widgets/date_picker.dart';
import 'package:procard_store/fileExport.dart';

class CreditCardWidget {

  static void credit_card_shape({BuildContext context, }) {
    double width = MediaQuery.of(context).size.width ;
    showModalBottomSheet<void>(
        context: context,
        shape: OutlineInputBorder(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return  Directionality(
              textDirection: translator.currentLanguage =='ar'?TextDirection.rtl : TextDirection.ltr,
              child:Container(
                height: width * 1.2,
                child:  Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: width * .075, right: width * .075,top: width * .05 ),
                        alignment: Alignment.center ,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(translator.translate("New Card Credit"),
                              style: TextStyle( fontSize:  ProdCardStoreFont.header_font_size,color:  primary_color,
                                fontWeight: FontWeight.bold,),),
                            Text(translator.translate("add new card credit"),
                              style: TextStyle( fontSize: ProdCardStoreFont.secondary_font_size,color:  primary_color,
                                fontWeight: FontWeight.normal,),),
                          ],
                        )
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(left: width * .075, right: width * .075, ),
                        child: Column(
                          children: [
                            card_number_textfield( context),
                            SizedBox(height: width * 0.05,),
                            card_name_textfield( context),
                            SizedBox(height: width * 0.05,),
                            Row(
                              children: [
                              card_expire_date_textfield( context),
                              card_cvv_textfield( context),
                            ],
                            )
                          ],
                        )
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: add_credit_card_button(context),
                    ),
                  ],
                ),
              ));
        }

    );
  }

 static Widget card_number_textfield(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    return  Container(
      width: width ,
      child: StreamBuilder<String>(
          stream: creditCardsBloc.card_number,
          builder: (context, snapshot) {
            return  Padding(
              padding: EdgeInsets.only(left:width * 0.05,right: width*0.05),
              child: CustomTextFieldWidget(
                context: context,
                hint: translator.translate("Card Number"),
                color: gray_color,
                onchange: creditCardsBloc.card_number_change,
                errorText: snapshot.error,
                inputType: TextInputType.text,
              ),
            );


          }),
    );
  }

  static Widget card_name_textfield(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    return  Container(
        width: width ,
        child:StreamBuilder<String>(
        stream: creditCardsBloc.card_name,
        builder: (context, snapshot) {
          return  Padding(
            padding: EdgeInsets.only(left:width * 0.05,right: width*0.05),
            child: CustomTextFieldWidget(
              context: context,
              hint: translator.translate("Bank Name"),
              color: gray_color,
              onchange: creditCardsBloc.card_name_change,
              errorText: snapshot.error,
              inputType: TextInputType.text,
            ),
          );


        }));
  }

  static Widget card_cvv_textfield(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    return  Container(
        width: width * 0.3,
        child:StreamBuilder<String>(
        stream: creditCardsBloc.card_cvv,
        builder: (context, snapshot) {
          return  Padding(
            padding: EdgeInsets.only(left:width * 0.05,right: width*0.05),
            child: CustomTextFieldWidget(
              context: context,
              hint: "cvv",
              color: gray_color,
              onchange: creditCardsBloc.card_cvv_change,
              errorText: snapshot.error,
              inputType: TextInputType.text,
            ),
          );

        }));
  }

  static Widget card_expire_date_textfield(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    return  Container(
        width: width * 0.5,
        child:StreamBuilder<String>(
        stream: creditCardsBloc.card_expire_date,
        builder: (context, snapshot) {
          return  Padding(
            padding: EdgeInsets.only(left:width * 0.05,right: width*0.05),
            child: Date_Picker(
              hint: translator.translate( "expire date"),
              start_date: false,
              type: 'iqema_expire',
            ),

          );


        }));
  }

  static  Widget add_credit_card_button(BuildContext context){

    return  BlocListener(
      bloc: creditCardsBloc,
      listener: (context,state){
        if(state is Loading){

        }else if(state is Done){
          var data = state.model as GeneralResponseModel;

          errorDialog(
          context: context,
          text: data.message,
          function: (){
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=> CreditCardsScreen()
            ));
          }
        );

        }else if (state is ErrorLoading){
          var data = state.model as GeneralResponseModel;

          errorDialog(
            context: context,
            text: data.message,
          );
        }
      },
      child: GestureDetector(
        onTap:() {
          creditCardsBloc.add(AddCreditCardEvent());
        },
        child: Column(
          children: [
            Container(
                width: StaticData.get_width(context) * 0.9,
                height: StaticData.get_width(context) * 0.15,
                alignment: FractionalOffset.center,
                decoration: BoxDecoration(
                  color: third_color,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Text(
                  translator.translate(  "Add Credit Card" ),
                  style: const TextStyle(
                    color: whiteColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.3,
                  ),
                )

            ),
          ],
        ),
      ),
    );

  }

}
