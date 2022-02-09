import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procard_store/Bloc/Home_Bloc/slider__bloc.dart';
import 'package:procard_store/Widgets/Shimmer/slider_shimmer.dart';
import 'package:procard_store/fileExport.dart';
import 'package:rxdart/rxdart.dart';
class OfferSlider extends StatefulWidget {
  List<String> data;
  bool indicator;
  var aspect_ratio;
  var border_radius;
  var viewportFraction;
  var details_page;
  var slider_width;
  var slider_height;
  OfferSlider(
      {this.data,
      this.indicator,
      this.aspect_ratio,
      this.border_radius,
      this.viewportFraction,
      this.details_page = false,
      this.slider_width,
      this.slider_height})
      : super();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OfferSliderState();
  }
}

class _OfferSliderState extends State<OfferSlider> {
  int _current = 0;
  bool full_screen = false;

  @override
  void initState() {
    sliderBloc.add(GetHomeSliderEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder(
      bloc: sliderBloc,
      builder: (context, state) {
        if (state is Loading) {
            return SliderSimmer();
        } else if (state is Done) {
          if(state.indicator == 'slider'){
            return StreamBuilder<SliderModel>(
                stream: sliderBloc.home_slider_subject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.data.isEmpty) {
                      return NoSlider();
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(height * .015)),
                        ),
                        child: CarouselSlider(
                          items: snapshot.data.data
                              .map((item) => ClipRRect(
                            borderRadius:
                            BorderRadius.circular(widget.border_radius ?? 15),
                            child:   Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(height * .015)),
                              ),
                              child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(height * .015)),
                                  child: Image.network(
                                    item.image,
                                    fit: BoxFit.fill,
                                  )),
                              height: height ,
                              width: width ,
                            ),

                          ))
                              .toList(),
                          options: CarouselOptions(
                            autoPlay: true,
                            height:  widget.slider_height??=MediaQuery.of(context).size.height/4.5,
                            enlargeCenterPage: true,
                            aspectRatio: widget.aspect_ratio ?? 2,
                            viewportFraction: widget.viewportFraction ?? 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            },
                          ),
                        ),

                      );
                    }
                  } else {
                    return NoSlider();
                  }
                });
          }
        } else if (state is ErrorLoading) {
          if(state.indicator == 'slider'){
            return NoSlider();
          }

        }else{
          return Container();
        }
      },
    );

  }
}
