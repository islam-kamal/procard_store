import 'package:flutter/material.dart';

import 'package:procard_store/fileExport.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAd extends StatefulWidget {
  @override
  _ShimmerAdState createState() => _ShimmerAdState();
}

class _ShimmerAdState extends State<ShimmerAd> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: gray_color,
          highlightColor: Colors.grey[350],
          child: Container(
            margin: EdgeInsets.only(right: 20),
            height: 95,
            width: 95,
            decoration: BoxDecoration(
                color: gray_color, borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: gray_color,
                highlightColor: Colors.grey[350],
                child: ChipDesign(
                  color: gray_color,
                  label: '                                                  ',
                  txtColor: primary_color,
                ),
              ),
              Row(children: [
                Shimmer.fromColors(
                  baseColor: gray_color,
                  highlightColor: Colors.grey[350],
                  child: ChipDesign(
                    color: gray_color,
                    label: '                  ',
                    txtColor: primary_color,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Shimmer.fromColors(
                    baseColor: gray_color,
                    highlightColor: Colors.grey[350],
                    child: ChipDesign(
                      color: gray_color,
                      label: '                 ',
                      txtColor: primary_color,
                    ),
                  ),
                )
              ])
            ],
          ),
        )
      ],
    );
  }
}
