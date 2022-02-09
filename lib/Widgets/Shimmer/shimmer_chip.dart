import 'package:flutter/material.dart';
import 'package:procard_store/fileExport.dart';

import 'package:shimmer/shimmer.dart';

class ShimmerChip extends StatefulWidget {
  @override
  _ShimmerChipState createState() => _ShimmerChipState();
}

class _ShimmerChipState extends State<ShimmerChip> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: gray_color,
      highlightColor: Colors.grey[350],
      child: ChipDesign(
        color: gray_color,
        label: '                  ',
        txtColor: primary_color,
      ),
    );
  }
}
