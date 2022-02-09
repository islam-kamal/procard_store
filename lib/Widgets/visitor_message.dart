import 'package:flutter/material.dart';

import 'package:procard_store/fileExport.dart';

class VistorMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VistorMessageState();
  }
}

class VistorMessageState extends State<VistorMessage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        Padding(
        padding: EdgeInsets.only(bottom: StaticData.get_width(context)*0.1),
      child:Image(
              image: AssetImage('Assets/Images/tlogo.png'),
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.width / 2,
      ) ),
            Container(
              padding: EdgeInsets.only(top: StaticData.get_width(context)*0.1),
              child: Text(
                ' قم بالتسجيل حتى تتمكن من الاستمتاع\n                   بخدمات التطبيق',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: ProdCardStoreFont.font_family),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: StaticData.get_width(context)*0.1),
              child:RaisedButton(
                color: primary_color,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'الدخول الى صفحة التسجيل',
                    style: TextStyle(color: Colors.yellow.shade600,  fontSize: 14,
                        fontFamily: ProdCardStoreFont.font_family),
                  ),
                ),
                onPressed: () {
                  StaticData.vistor_value='';
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                },
              ) ,
            )

          ],
        ),
      ),

    );
  }
}
