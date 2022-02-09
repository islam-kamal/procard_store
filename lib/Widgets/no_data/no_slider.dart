import 'package:flutter/material.dart';
import 'package:procard_store/fileExport.dart';

class NoSlider extends StatelessWidget {

  const NoSlider({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Center(
        child: Image.asset('Assets/Images/slide.png')
    );
  }
}
