import 'package:flutter/material.dart';
import 'package:on_boarding/model/cart_item.dart';
import 'package:on_boarding/model/product.dart';
import 'package:on_boarding/provider/cart_provider.dart';
import 'package:on_boarding/services/databaseService.dart';
import 'package:provider/provider.dart';

import '../../check_out/screen/check_out_page.dart';
import '../../model/cart.dart';
import '../provider/shopping_provider.dart';
import '../widgets/cart_product_list.dart';
import '../widgets/price_total_container.dart';
import '../widgets/promo_code_container.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  DatabaseService service = DatabaseService();
  Future<List<Product>>? futureCartList;

  @override
  void initState() {
    priceUpdate();
    context.read<ShoppingProvider>().cartData();
    context.read<ShoppingProvider>().cartQuery();
    context.read<CartProvider>().priceData();
    context.read<CartProvider>().priceQuery();
    super.initState();
  }

  void priceUpdate() {
    Cart cart = Cart(
      id: "bZeX7oInWULDlL3A2Ral",
      subTotal: context.read<ShoppingProvider>().subTotal(),
      discountOnOrder: context.read<ShoppingProvider>().discountOnOrder(),
      deliveryCharges: 0,
      total: context.read<ShoppingProvider>().totalPrice(),
      couponDiscount: 0,
      // cartItemList:
      //     Provider.of<ShoppingProvider>(context, listen: false).cartList,
    );
    context.read<CartProvider>().updatePriceOfProduct(cart);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text(
          "Shopping Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      /// Scaffold
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Consumer<ShoppingProvider>(
                  builder: (_, provider, __) {
                    return FutureBuilder(
                      future: provider.futureCartList,
                      builder: (context,
                          AsyncSnapshot<List<CartItem>> fruitSnapshot) {
                        if (fruitSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (!fruitSnapshot.hasData) {
                          return const Text("No Data");
                        } else if (fruitSnapshot.hasError) {
                          return const Text("Something Went Wrong");
                        }
                        {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.cartList.length,
                            itemBuilder: (_, index) {
                              return CartProductList(
                                count: provider.cartList[index].itemQuantity
                                    .toString(),
                                onDecrementPress: () {
                                  provider.decrement(index);
                                },
                                onIncrementPress: () {
                                  provider.increment(index);
                                },
                                direction: DismissDirection.endToStart,
                                onDismiss: (direction) {
                                  provider.deleteData(
                                    provider.cartList[index].id ?? "",
                                  );
                                  // priceUpdate();
                                },
                                image: provider
                                    .cartList[index].product!.productImage,
                                title: provider
                                    .cartList[index].product!.productName,
                                quantity: provider
                                    .cartList[index].product!.productQuantity,
                                price:
                                    "Rs. ${provider.cartList[index].product?.productPrice}",
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
                // const SizedBox(
                //   height: 5,
                // ),
                Visibility(
                    visible: Provider.of<ShoppingProvider>(context).isShow(),
                    child: const PromoCodeContainer()),
                const SizedBox(
                  height: 5,
                ),
                Consumer<CartProvider>(
                  builder: (_, provider, __) {
                    return Visibility(
                      visible: Provider.of<ShoppingProvider>(context).isShow(),
                      child: FutureBuilder<Object>(
                        future: provider.futurePriceList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (!snapshot.hasData) {
                            return const Text("No Data");
                          } else if (snapshot.hasError) {
                            return const Text("Something Went Wrong");
                          }
                          {
                            return ListView.builder(
                              itemCount: provider.priceList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return PriceTotalContainer(
                                  total: provider.priceList[index].total
                                      .toString(),
                                  subTotal: provider.priceList[index].subTotal
                                      .toString(),
                                  discount: provider
                                      .priceList[index].discountOnOrder
                                      .toString(),
                                );
                              },
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
                // SizedBox(
                //   height: 30,
                // ),
                Consumer<ShoppingProvider>(
                  builder: (_, provider, __) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 97),
                          ),
                        ),
                        onPressed: () {
                          provider.isShow()
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CheckOutPage(),
                                  ),
                                )
                              : Navigator.pop(context);
                        },
                        child: Text(provider.isShow()
                            ? "Proceed to Checkout"
                            : "Add Product"),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
