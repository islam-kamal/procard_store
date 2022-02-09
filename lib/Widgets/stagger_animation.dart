import 'package:flutter/material.dart';
import 'package:procard_store/fileExport.dart';

class StaggerAnimation extends StatelessWidget {
  final VoidCallback onTap;
  final String titleButton;
  final Color btn_color;
  final Color text_color;
  final BuildContext context;
  StaggerAnimation({
    Key key,
    this.buttonController,
    this.onTap,
    this.titleButton = "Sign In",
    this.btn_color,
    this.text_color = primary_color,
    this.context
  })  : buttonSqueezeanimation = Tween(
    begin: StaticData.get_width(context) * 0.9,
    end: StaticData.get_width(context) * 0.2,
  ).animate(
    CurvedAnimation(
      parent: buttonController,
      curve: const Interval(
        0.0,
        0.150,
      ),
    ),
  ),
        containerCircleAnimation = EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 30.0),
          end: const EdgeInsets.only(bottom: 0.0),
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: const Interval(
              0.500,
              0.800,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final AnimationController buttonController;
  final Animation<EdgeInsets> containerCircleAnimation;
  final Animation buttonSqueezeanimation;

  Widget _buildAnimation(BuildContext context, Widget child) {
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width:buttonSqueezeanimation.value==null? StaticData.get_width(context) * 0.9:
        buttonSqueezeanimation.value,
        height: height * .08,

        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          color: btn_color,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: buttonSqueezeanimation.value > 75.0
            ? text_color == primary_color ?Text(
          translator.translate(titleButton),
          style: const TextStyle(
            color: primary_color,
            fontSize: 16.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3,
          ),
        ) : Text(
          translator.translate(titleButton),
          style: const TextStyle(
            color: whiteColor,
            fontSize: 16.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3,
          ),
        )
            : const CircularProgressIndicator(
          value: null,
          strokeWidth: 1.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController,
    );
  }
}
