import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:on_boarding/services/databaseService.dart';
import 'package:on_boarding/shopping_cart/provider/shopping_provider.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../dash_board_page/widgets/top_selling_item_list_card.dart';
import '../../model/product.dart';
import '../../product_details/product_detail_screen/product_detail_page.dart';
import '../../provider/favourite_provider.dart';
import '../../provider/prodcut_provider.dart';

class CategoryWiseStreamViewBuilder extends StatelessWidget {
  final String uID;

  const CategoryWiseStreamViewBuilder({Key? key, required this.uID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseService services = DatabaseService();
    return SizedBox(
      height: 250,
      child: FutureBuilder(
        future: services.queryProduct(uID),
        builder: (context, AsyncSnapshot<List<Product>> fruitSnapshot) {
          if (fruitSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!fruitSnapshot.hasData) {
            return const Text("No Data");
          } else if (fruitSnapshot.hasError) {
            return const Text("Something Went Wrong");
          }

          /// List View of HomeScreen Fruit, Vegetables etc Products
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: fruitSnapshot.data?.length,
            itemBuilder: (context, index) {
              return Consumer<ShoppingProvider>(
                builder: (_, provider, __) {
                  return TopSellingItemListCard(
                    offerText:
                        "${fruitSnapshot.data?[index].productOffer ?? " "}% Off",
                    image: fruitSnapshot.data?[index].productImage ?? "",
                    productName: fruitSnapshot.data?[index].productName ?? "",
                    productQuantity:
                        fruitSnapshot.data?[index].productQuantity ?? "",
                    productPrice:
                        "Rs. ${fruitSnapshot.data?[index].productPrice} only",

                    /// favourite on Press
                    favouriteOnPress: () async {
                      final snapShot = await FirebaseFirestore.instance
                          .collection('favourite')
                          .doc(Constant.checkCurrentUser())
                          .collection("favourite_list")
                          .where("p_name",
                              isEqualTo: fruitSnapshot.data?[index].productName)
                          .get();
                      final provider =
                          Provider.of<ProductProvider>(context, listen: false);
                      final favProvider = Provider.of<FavouriteProvider>(
                          context,
                          listen: false);

                      /// toggle and update
                      provider.toggleFavourite(index);
                      provider.updateFavourite(
                          fruitSnapshot.data![index], index);

                      /// remove and adding Favourite
                      if (provider.checkFavourite[index] &&
                          snapShot.docs.isEmpty) {
                        favProvider
                            .addFavouriteProduct(fruitSnapshot.data?[index]);
                        Constant.showToast(
                            '${fruitSnapshot.data?[index].productName} Added to Favourite');
                      } else {
                        favProvider.deleteFavouriteProduct(
                            favProvider.favouriteList[index].id ?? "");
                        Constant.showToast(
                            '${fruitSnapshot.data?[index].productName} Removed from Favourite');
                      }
                    },

                    /// Heart Color
                    favouriteColor: Provider.of<ProductProvider>(context)
                            .checkFavourite[index]
                        ? Colors.green
                        : Colors.white,

                    /// Push to Product Details Screen
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                              products: fruitSnapshot.data?[index]),
                        ),
                      );
                    },

                    /// Adding to cart
                    onPress: () async {
                      Constant.onPressAddProductToCartWithExistingCheck(
                          products: fruitSnapshot.data![index],
                          provider: provider,
                          index: index);
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
