import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:on_boarding/constant/constant.dart';
import 'package:on_boarding/shopping_cart/provider/shopping_provider.dart';
import 'package:provider/provider.dart';

import '../../model/cart.dart';
import '../../model/product.dart';
import '../../shopping_cart/screens/shopping_cart_page.dart';
import '../widgets/product_count.dart';

class ProductDetailPage extends StatelessWidget {
  final Product? products;

  const ProductDetailPage({this.products, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Scaffold Start
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Main Image of Product Container
              Container(
                padding: const EdgeInsets.all(5),
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back)),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ShoppingCartPage(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 25,
                          ),
                        ),
                      ],
                    ),

                    /// Catch Network Image in Container
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: products?.productImage ?? "",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ],
                ),
              ),

              /// After Container ner Column Start
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Product Name And Count
                    Row(
                      children: [
                        Text(
                          products?.productName ?? "",
                          style: Constant.kOnBoardHeaderTextStyle,
                        ),
                        const Spacer(),
                        Consumer<ShoppingProvider>(
                          builder: (_, provider, __) {
                            return ProductCount(
                              count: products!.toString(),
                              onDecreasePress: () {
                                // provider.decrement(index);
                              },
                              onIncreasePress: () {
                                // provider.increment();
                              },
                            );
                          },
                        ),
                      ],
                    ),

                    /// Quantity
                    Text(products?.productQuantity ?? ""),
                    const SizedBox(
                      height: 10,
                    ),

                    /// Rating and Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            Text(rating.toString());
                          },
                        ),
                        Text(
                          " Rs. ${products?.productPrice ?? " "}.00",
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    /// Chip Widget
                    const Chip(
                      backgroundColor: Colors.green,
                      label: Text("Free Ship"),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    /// Details of Products
                    const Text(
                      "Details:",
                      style: Constant.kOnBoardHeaderTextStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      products?.details ?? "",
                      style: const TextStyle(
                          textBaseline: TextBaseline.ideographic,
                          color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      /// Add Cart Bottom Navigation Bar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ShoppingProvider>(
          builder: (_, provider, __) {
            return Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 82, vertical: 12),
                    ),
                  ),
                  onPressed: () async {
                    final snapShot = await FirebaseFirestore.instance
                        .collection('cart')
                        .doc(Constant.checkCurrentUser())
                        .collection("user_cart")
                        .where("p_name", isEqualTo: products?.productName)
                        .get();

                    if (snapShot.docs.isEmpty) {
                      provider.addProduct(products);
                      Constant.showToast(
                          '${products?.productName} Added to Cart');
                    } else {
                      // provider.cartList?[index].itemQuantity =
                      //     provider.cartList![index].itemQuantity + 1;
                      Cart cart = Cart(
                          // itemQuantity: provider.cartList![index].itemQuantity + 1,
                          );
                      provider.updateCartProduct(cart);

                      Constant.showToast(
                          '${products?.productName} Products Quantity Increase in Cart');
                    }
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.shopping_cart_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Add to Cart"),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      Icons.favorite_border_rounded,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
