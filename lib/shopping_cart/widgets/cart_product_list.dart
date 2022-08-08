import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../product_details/widgets/product_count.dart';

class CartProductList extends StatelessWidget {
  const CartProductList({
    Key? key,
    required this.image,
    required this.title,
    required this.quantity,
    required this.price,
    this.onDismiss,
    required this.direction,
    required this.count,
    this.onDecrementPress,
    this.onIncrementPress,
  }) : super(key: key);
  final String image;
  final String title;
  final String quantity;
  final String price;
  final Function(DismissDirection)? onDismiss;
  final DismissDirection direction;
  final String count;
  final Function()? onDecrementPress;
  final Function()? onIncrementPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Dismissible(
          onDismissed: onDismiss,
          key: UniqueKey(),
          direction: direction,
          background: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete_outline_outlined,
                color: Colors.white,
                size: 90,
              ),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(16),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(400, 20),
                  color: Colors.black12,
                  blurRadius: 50,
                ),
                BoxShadow(
                  offset: Offset(1, 1),
                  color: Colors.white,
                  blurRadius: 1,
                ),
              ],
            ),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: image,
                  height: 200,
                  width: 100,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      quantity,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProductCount(
                          count: count,
                          onDecreasePress: onDecrementPress,
                          onIncreasePress: onIncrementPress,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          price,
                          style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
