import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomPageIndicator extends StatelessWidget {
  const CustomPageIndicator(
      {Key? key, required this.controller, required this.activeDotColor})
      : super(key: key);

  final PageController controller;
  final Color activeDotColor;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      axisDirection: Axis.horizontal,
      effect: ExpandingDotsEffect(
        spacing: 8.0,
        radius: 5.0,
        dotWidth: 6.0,
        dotHeight: 6.0,
        paintStyle: PaintingStyle.fill,
        strokeWidth: 1,
        dotColor: Colors.green.shade300,
        activeDotColor: activeDotColor,
      ),
    );
  }
}
