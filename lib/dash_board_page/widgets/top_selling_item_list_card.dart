import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TopSellingItemListCard extends StatelessWidget {
  const TopSellingItemListCard({
    required this.offerText,
    required this.image,
    required this.productName,
    required this.productQuantity,
    required this.productPrice,
    this.isBeautyCare = false,
    this.onPress,
    this.onTap,
    Key? key,
    this.favouriteOnPress,
    required this.favouriteColor,
    this.closeOnPress,
  }) : super(key: key);
  final String offerText;
  final String image;
  final String productName;
  final String productQuantity;
  final String productPrice;
  final bool isBeautyCare;
  final Function()? onPress;
  final Function()? onTap;
  final Function()? favouriteOnPress;
  final Color favouriteColor;
  final Function()? closeOnPress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 150,
            margin:
                const EdgeInsets.only(left: 16, top: 10, right: 8, bottom: 10),
            decoration: BoxDecoration(
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Align(
                  alignment:
                      isBeautyCare ? Alignment.topLeft : Alignment.topRight,
                  child: Container(
                    height: 25,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: isBeautyCare
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))
                          : const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                    ),
                    child: Center(
                      child: Text(
                        offerText,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: image,
                    // height: 200,
                    // width: 100,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              productName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Text(
                            productQuantity,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black87),
                          ),
                        ],
                      ),
                      Expanded(
                        child: isBeautyCare
                            ? const SizedBox()
                            : IconButton(
                                onPressed: favouriteOnPress,
                                icon: Icon(
                                  Icons.favorite,
                                  color: favouriteColor,
                                ),
                              ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      productPrice,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 39,
                      width: 39,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: isBeautyCare
                            ? BorderRadius.circular(20)
                            : BorderRadius.circular(2),
                      ),
                      child: IconButton(
                        onPressed: onPress,
                        icon: Center(
                          child: Icon(
                            isBeautyCare
                                ? Icons.add
                                : Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: isBeautyCare,
          child: Positioned(
            right: 50,
            left: 130,
            child: IconButton(
              onPressed: closeOnPress,
              icon: const Icon(
                Icons.close,
                color: Colors.black54,
                size: 25,
              ),
            ),
          ),
        )
      ],
    );
  }
}
