import 'package:flutter/material.dart';

import '../../constant/constant.dart';

class SeeAllHeaderRow extends StatelessWidget {
  const SeeAllHeaderRow({
    required this.header,
    required this.description,
    this.onPress,
    Key? key,
  }) : super(key: key);
  final String header;
  final String description;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            header,
            style: Constant.kOnBoardHeaderTextStyle,
          ),
          TextButton(
            onPressed: onPress,
            child: Text(description),
          ),
        ],
      ),
    );
  }
}
