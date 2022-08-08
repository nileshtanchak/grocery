import 'package:flutter/material.dart';

class ProductCount extends StatelessWidget {
  final Function()? onDecreasePress;
  final Function()? onIncreasePress;
  final String count;

  const ProductCount({
    Key? key,
    this.onDecreasePress,
    this.onIncreasePress,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: onDecreasePress,
            icon: const Icon(
              Icons.remove,
              color: Colors.green,
            ),
          ),
          Text(
            count,
            style: const TextStyle(
                color: Colors.green, decoration: TextDecoration.underline),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: onIncreasePress,
            icon: const Icon(
              Icons.add,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
