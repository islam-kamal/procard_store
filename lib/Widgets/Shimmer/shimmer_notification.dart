import 'package:flutter/material.dart';
import 'package:procard_store/fileExport.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerNotification extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

         Shimmer.fromColors(
                baseColor: gray_color,
                highlightColor: Colors.grey[350],
                child
              : Container(
                  decoration: BoxDecoration(
                      color: gray_color,
              borderRadius: BorderRadius.circular(5.0)),
          
                height: 50,
                width: width * 0.65,
              
              )
    
              ),
        Shimmer.fromColors(
          baseColor: gray_color,
          highlightColor: Colors.grey[300],
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width *0.04),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: gray_color, borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
     
      ],
    );
  }
}
