import 'package:flutter/material.dart';
import 'package:procard_store/fileExport.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerChat extends StatefulWidget {
  @override
  _ShimmerChatState createState() => _ShimmerChatState();
}

class _ShimmerChatState extends State<ShimmerChat> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Row(
        children: [
          Shimmer.fromColors(
            baseColor: gray_color,
            highlightColor: Colors.grey[350],
            child: Container(
              margin: EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: whiteColor,
              ),
            ),
          ),
          Shimmer.fromColors(
              baseColor: gray_color,
              highlightColor: Colors.grey[350],
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('                 ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        Text(
                          '                      ',
                          style: TextStyle(fontSize: 14, color: gray_color),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      width: constrains.maxWidth * 0.7,
                      child: Text(
                        '                                             ',
                        style: TextStyle(fontSize: 12, color: gray_color),
                      ),
                    )
                  ],
                ),
              )
        ],
      );
    });
  }
}
