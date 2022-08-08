import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.00, vertical: 5.00),
      child: SizedBox(
        child: Shimmer.fromColors(
          baseColor: Colors.red.shade200,
          highlightColor: Colors.red.shade800,
          child: Container(
            width: 150,
            margin:
                const EdgeInsets.only(left: 16, top: 10, right: 8, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
