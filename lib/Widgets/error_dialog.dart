import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procard_store/fileExport.dart';

void errorDialog({BuildContext context, String text, Function function}) {
  print("function : ${function}");
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
        child: CupertinoAlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.width / 2,
            width: MediaQuery.of(context).size.width / 2,
            child: Center(
              child: Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: StaticData.get_width(context) * 0.01),
                    child: Image.asset('Assets/Images/done.png'),
                  ),
                  SizedBox(
                    height:  MediaQuery.of(context).size.width * 0.05,
                  ),
                  Text(
                    text ?? "",
                    style: TextStyle(
                        color: primary_color,
                        fontFamily: ProdCardStoreFont.font_family,
                        fontSize:  16),
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                translator.translate("ok"),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Cairo",
                  color: yellowColor,
                ),
              ),
              onPressed: function ?? () => Navigator.pop(context),
            )
          ],
        ));
      });
}
