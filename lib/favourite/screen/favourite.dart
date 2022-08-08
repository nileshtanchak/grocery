import 'package:flutter/material.dart';
import 'package:on_boarding/provider/favourite_provider.dart';
import 'package:on_boarding/shopping_cart/provider/shopping_provider.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../dash_board_page/widgets/top_selling_item_list_card.dart';
import '../../model/product.dart';
import '../../product_details/product_detail_screen/product_detail_page.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  void initState() {
    context.read<FavouriteProvider>().favouriteQuery();
    context.read<FavouriteProvider>().fetchFavouriteProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Favourite",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Provider.of<FavouriteProvider>(context).futureFavouriteList,
          builder: (context, AsyncSnapshot<List<Product>> favouriteSnapshot) {
            if (favouriteSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!favouriteSnapshot.hasData) {
              return const Text("No Data");
            } else if (favouriteSnapshot.hasError) {
              return const Text("Something Went Wrong");
            }
            return GridView.builder(
              shrinkWrap: true,
              itemCount: favouriteSnapshot.data?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 250,
                crossAxisCount: 2,
              ),
              itemBuilder: (_, index) {
                return Consumer<FavouriteProvider>(
                  builder: (_, provider, __) {
                    /// Category Wise Product Grid View
                    return TopSellingItemListCard(
                      offerText:
                          "${favouriteSnapshot.data?[index].productOffer ?? ""}% Off",
                      image: favouriteSnapshot.data?[index].productImage ?? "",
                      productName:
                          favouriteSnapshot.data?[index].productName ?? "",
                      productQuantity:
                          favouriteSnapshot.data?[index].productQuantity ?? "",
                      productPrice:
                          "Rs. ${favouriteSnapshot.data?[index].productPrice.toString() ?? 0} only",
                      isBeautyCare: true,
                      favouriteColor: Colors.white,
                      closeOnPress: () {
                        provider.deleteFavouriteProduct(
                            favouriteSnapshot.data?[index].id ?? "");
                      },

                      /// Add Product
                      onPress: () async {
                        Constant.onPressAddProductToCartWithExistingCheck(
                            products: favouriteSnapshot.data![index],
                            provider: Provider.of<ShoppingProvider>(context),
                            index: index);
                      },

                      /// Navigate to Details Page
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                              products: favouriteSnapshot.data![index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
