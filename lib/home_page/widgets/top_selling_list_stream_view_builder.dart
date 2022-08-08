import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:on_boarding/provider/prodcut_provider.dart';
import 'package:on_boarding/shopping_cart/provider/shopping_provider.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../dash_board_page/widgets/top_selling_item_list_card.dart';
import '../../main.dart';
import '../../model/product.dart';
import '../../product_details/product_detail_screen/product_detail_page.dart';
import '../../provider/favourite_provider.dart';

class TopSellingListStreamViewBuilder extends StatefulWidget {
  const TopSellingListStreamViewBuilder({
    Key? key,
    this.isFavourite = false,
  }) : super(key: key);

  final bool isFavourite;

  @override
  State<TopSellingListStreamViewBuilder> createState() =>
      _TopSellingListStreamViewBuilderState();
}

class _TopSellingListStreamViewBuilderState
    extends State<TopSellingListStreamViewBuilder> {
  @override
  void initState() {
    context.read<FavouriteProvider>().favouriteQuery();
    context.read<ProductProvider>().fetchProduct();
    setState(() {
      context.read<ProductProvider>().productQuery();
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.blue,
              playSound: true,
              icon: 'logo',
            ),
          ),
        );
      }
    });
    //Message for Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.d('A new message open app event was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
    super.initState();
  }

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
        0,
        "Congratulations",
        "You Add a Grocery app Product to Cart",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: 'logo')));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: FutureBuilder(
        future: Provider.of<ProductProvider>(context).futureProductList,
        builder: (context, AsyncSnapshot<List<Product>> topSellingSnapshot) {
          if (topSellingSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!topSellingSnapshot.hasData) {
            return const Text("No Data");
          } else if (topSellingSnapshot.hasError) {
            return const Text("Something Went Wrong");
          }

          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) {
              return Consumer<ShoppingProvider>(
                builder: (_, provider, __) {
                  /// Top Selling Product of HomeScreen
                  return TopSellingItemListCard(
                    offerText:
                        "${topSellingSnapshot.data?[index].productOffer ?? ""}% Off",
                    image: topSellingSnapshot.data?[index].productImage ?? "",
                    productName:
                        topSellingSnapshot.data?[index].productName ?? "",
                    productQuantity:
                        topSellingSnapshot.data?[index].productQuantity ?? "",
                    productPrice:
                        "Rs. ${topSellingSnapshot.data?[index].productPrice.toString() ?? ""} only",

                    /// Favourite onPress
                    favouriteOnPress: () {
                      final provider =
                          Provider.of<ProductProvider>(context, listen: false);
                      final favProvider = Provider.of<FavouriteProvider>(
                          context,
                          listen: false);

                      /// toggle and update
                      provider.toggleFavourite(index);
                      provider.updateFavourite(
                          topSellingSnapshot.data![index], index);

                      /// remove and adding Favourite
                      if (provider.checkFavourite[index]) {
                        favProvider.addFavouriteProduct(
                            topSellingSnapshot.data?[index]);
                        Constant.showToast(
                            '${topSellingSnapshot.data?[index].productName} Added to Favourite');
                      } else {
                        favProvider.deleteFavouriteProduct(
                            favProvider.favouriteList[index].id ?? "");
                        Constant.showToast(
                            '${topSellingSnapshot.data?[index].productName} Removed from Favourite');
                      }
                    },

                    /// Heart Color
                    favouriteColor: Provider.of<ProductProvider>(context)
                            .checkFavourite[index]
                        ? Colors.green
                        : Colors.white,

                    /// Navigate to Details Screen
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                              products: topSellingSnapshot.data![index]),
                        ),
                      );
                    },

                    /// Add Product
                    onPress: () async {
                      // showNotification();
                      Constant.onPressAddProductToCartWithExistingCheck(
                          products: topSellingSnapshot.data![index],
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
