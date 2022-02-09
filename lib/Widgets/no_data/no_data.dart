import 'package:flutter/material.dart';
import 'package:procard_store/fileExport.dart';

class NoData extends StatelessWidget {
  final String message;

  const NoData({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.not_interested,
          size: height * 0.12,
          color: primary_color,
        ),
        Container(
          margin: EdgeInsets.only(top: height * 0.02),
          child: Text(
            message,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
          ),
        ),
      ],
    ));
  }
}
