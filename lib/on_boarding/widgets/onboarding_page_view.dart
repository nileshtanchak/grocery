import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../on_boarding_model/on_boarding_model.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({
    Key? key,
    required this.onBoardingList,
  }) : super(key: key);

  final OnBoardingModel onBoardingList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.elliptical(180, 130),
                  bottomRight: Radius.elliptical(180, 130)),
              color: Colors.green.shade50,
            ),
            child: Image.asset(
              onBoardingList.image,
            ),
          ),
          Text(
            onBoardingList.title,
            // maxLines: 2,
            textAlign: TextAlign.center,
            style: Constant.kOnBoardHeaderTextStyle,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55.0),
            child: Text(
              onBoardingList.description,
              textAlign: TextAlign.center,
              style: Constant.kOnBoardSubtitleTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
