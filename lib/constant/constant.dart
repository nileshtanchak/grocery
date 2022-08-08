import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:on_boarding/model/cart_item.dart';
import 'package:on_boarding/shopping_cart/provider/shopping_provider.dart';

import '../model/product.dart';

class Constant {
  static const kOnBoardHeaderTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 22);

  static const kOnBoardSubtitleTextStyle = TextStyle(color: Colors.black45);
  static const kSignupSignInContainerDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(1, 1),
        blurRadius: 20.0,
      ),
      BoxShadow(
        color: Colors.white,
        offset: Offset(0, 0),
        blurRadius: 5.0,
      ),
    ],
  );

  static late String uId;

  static String checkCurrentUser() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final user = auth.currentUser;
      if (user != null) {
        uId = user.uid;
      }
    } catch (e) {
      print(e);
    }
    return uId;
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void onPressAddProductToCartWithExistingCheck(
      {required Product products,
      required ShoppingProvider provider,
      required int index}) async {
    final snapShot = await FirebaseFirestore.instance
        .collection('cart')
        .doc(Constant.checkCurrentUser())
        .collection("user_cart")
        .where("p_name", isEqualTo: products.productName)
        .get();

    if (snapShot.docs.isEmpty) {
      provider.addProduct(products);
      Constant.showToast('${products.productName} Added to Cart');
    } else {
      CartItem cartItem = CartItem(
        id: provider.cartList[index].id,
        product: Product(
          id: provider.cartList[index].product!.id,
          productImage: provider.cartList[index].product!.productImage,
          productName: provider.cartList[index].product!.productImage,
          productQuantity: provider.cartList[index].product!.productImage,
          productPrice: provider.cartList[index].product!.productImage,
        ),
        itemQuantity: provider.cartList[index].itemQuantity + 1,
      );
      provider.updateCartProduct(cartItem);

      showToast('${products.productName} Products Quantity Increase in Cart');
    }
  }
}
