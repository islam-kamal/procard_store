import 'package:flutter/material.dart';
import 'package:procard_store/Widgets/Shimmer/shimmer_ad.dart';
import 'package:procard_store/fileExport.dart';


class ListShimmer extends StatefulWidget {
  final String type;
  ListShimmer({this.type});

  @override
  _ListShimmerState createState() => _ListShimmerState();
}

class _ListShimmerState extends State<ListShimmer> {
  @override
  Widget build(BuildContext context) {
    return widget.type == 'horizontal'? ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return  Shimmer.fromColors(
          baseColor: gray_color,
          highlightColor: Colors.grey[350],
          child: Padding(
            padding: EdgeInsets.only(right: 5,left: 5),
            child: Container(
              height: StaticData.get_width(context) * 0.50,
              width: StaticData.get_width(context) * 0.25,
              decoration: BoxDecoration(
                  color: gray_color, borderRadius: BorderRadius.circular(10.0)),
            ),
          )
        );
      },

    )

    : GridView.builder(
        itemCount: 10,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .9000,
        ),
        itemBuilder: (BuildContext context, int index) {
          return  Shimmer.fromColors(
              baseColor: gray_color,
              highlightColor: Colors.grey[350],
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: StaticData.get_width(context) * 0.25,
                  width: StaticData.get_width(context) * 0.25,
                  decoration: BoxDecoration(
                      color: gray_color, borderRadius: BorderRadius.circular(10.0)),
                ),
              )
          );
        });
  }
}
