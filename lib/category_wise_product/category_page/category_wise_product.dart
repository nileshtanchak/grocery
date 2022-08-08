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
import '../../widgets/custom_text_field.dart';

class CategoryWiseProduct extends StatefulWidget {
  final bool isBeautyCare;
  final String uID;
  final String productName;

  const CategoryWiseProduct({
    this.isBeautyCare = false,
    required this.uID,
    required this.productName,
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryWiseProduct> createState() => _CategoryWiseProductState();
}

class _CategoryWiseProductState extends State<CategoryWiseProduct> {
  late TextEditingController searchController;
  DatabaseService service = DatabaseService();
  String name = "";
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBAr
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          widget.productName,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      /// SafeArea Starting
      body: SafeArea(
        child: Column(
          children: [
            /// Custom TextField
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              child: CustomTextField(
                filled: true,
                filledColor: Colors.green.shade50,
                hintText: "search products",
                priIcons: Icons.search,
                onPress: () {},
                obscureText: false,
                controller: searchController,
                border: InputBorder.none,
                priIconColor: Colors.black,
                onChange: (value) {
                  name = value;
                },
              ),
            ),

            /// Categories Wise ProductList FutureBuilder
            FutureBuilder(
              future: service.queryProduct(widget.uID),
              builder:
                  (context, AsyncSnapshot<List<Product>> categorySnapshot) {
                if (categorySnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!categorySnapshot.hasData) {
                  return const Text("No Data");
                }
                return Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: categorySnapshot.data?.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 250,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (_, index) {
                      return Consumer<ShoppingProvider>(
                        builder: (_, provider, __) {
                          return TopSellingItemListCard(
                            offerText:
                                "${categorySnapshot.data?[index].productOffer ?? " "}% Off",
                            image: categorySnapshot.data?[index].productImage ??
                                "",
                            productName:
                                categorySnapshot.data?[index].productName ?? "",
                            productQuantity:
                                categorySnapshot.data?[index].productQuantity ??
                                    "",
                            productPrice:
                                "Rs. ${categorySnapshot.data?[index].productPrice ?? ""} only",
                            isBeautyCare: true,
                            favouriteOnPress: () {
                              final provider = Provider.of<ProductProvider>(
                                  context,
                                  listen: false);
                              final favProvider =
                                  Provider.of<FavouriteProvider>(context,
                                      listen: false);

                              /// toggle and update
                              provider.toggleFavourite(index);
                              provider.updateFavourite(
                                  categorySnapshot.data![index], index);

                              /// remove and adding Favourite
                              if (provider.checkFavourite[index]) {
                                favProvider.addFavouriteProduct(
                                    categorySnapshot.data?[index]);
                                Constant.showToast(
                                    '${categorySnapshot.data?[index].productName} Added to Favourite');
                              } else {
                                favProvider.deleteFavouriteProduct(
                                    favProvider.favouriteList[index].id ?? "");
                                Constant.showToast(
                                    '${categorySnapshot.data?[index].productName} Removed from Favourite');
                              }
                            },

                            /// Heart Color
                            favouriteColor:
                                Provider.of<ProductProvider>(context)
                                        .checkFavourite[index]
                                    ? Colors.green
                                    : Colors.white,

                            /// Push to Product Details Screen
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(
                                    products: categorySnapshot.data?[index],
                                  ),
                                ),
                              );
                            },

                            /// Add Product
                            onPress: () async {
                              Constant.onPressAddProductToCartWithExistingCheck(
                                  products: categorySnapshot.data![index],
                                  provider: provider,
                                  index: index);
                            },
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
