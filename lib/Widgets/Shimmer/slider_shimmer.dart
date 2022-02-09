import 'package:flutter/material.dart';
import 'package:procard_store/fileExport.dart';


class SliderSimmer extends StatefulWidget {
  @override
  _SliderSimmerState createState() => _SliderSimmerState();
}

class _SliderSimmerState extends State<SliderSimmer> {
  @override
  Widget build(BuildContext context) {
    return   Shimmer.fromColors(
      baseColor: gray_color,
      highlightColor: Colors.grey[350],
      child: Container(
        height:  StaticData.get_height(context)/4.5,
        width: StaticData.get_width(context) * 0.9,
        decoration: BoxDecoration(
            color: gray_color, borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}
