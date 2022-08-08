import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:on_boarding/model/cart_item.dart';
import 'package:on_boarding/provider/cart_provider.dart';
import 'package:on_boarding/services/databaseService.dart';
import 'package:provider/provider.dart';

import '../../model/cart.dart';

class ShoppingProvider extends ChangeNotifier {
  DatabaseService service = DatabaseService();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<List<CartItem>>? _futureCartList;

  Future<List<CartItem>>? get futureCartList => _futureCartList;
  List<CartItem> _cartList = [];

  List<CartItem> get cartList => _cartList;

  int _total = 0;

  int get total => _total;

  int _productTotalPrice = 0;

  int get productTotalPrice => _productTotalPrice;
  int _discount = 0;

  int get discount => _discount;

  bool isShow() {
    if (_cartList.isNotEmpty) {
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  Future<List<CartItem>?> cartData() async {
    _futureCartList = service.queryCart();
    notifyListeners();
    return _futureCartList;
  }

  Future<void> addProduct(cartItem) async {
    service.addCart(cartItem);
    notifyListeners();
  }

  Future<void> updateCartProduct(cartItem) async {
    service.updateProduct(cartItem);
    notifyListeners();
  }

  Future<List<CartItem>> cartQuery() async {
    _cartList = await service.queryCart();
    notifyListeners();
    return _cartList;
  }

  Future<bool> deleteData(String id) async {
    await service.deleteCart(id);
    cartList.removeWhere((element) => element.id == id);
    notifyListeners();
    return true;
  }

  int subTotal() {
    if (_cartList.isNotEmpty) {
      _total = 0;
      for (int i = 0; i < _cartList.length; i++) {
        _total = (int.parse(_cartList[i].product?.productPrice ?? "")) *
                _cartList[i].itemQuantity +
            _total;
      }
      notifyListeners();
      return _total;
    }
    return 0;
  }

  int totalPrice() {
    if (_cartList.isNotEmpty) {
      _productTotalPrice = subTotal() - discountOnOrder();
      notifyListeners();
      return _productTotalPrice;
    } else {
      _productTotalPrice = 0;
      notifyListeners();
      return _productTotalPrice;
    }
  }

  int discountOnOrder() {
    if (_cartList.isNotEmpty) {
      _discount = 0;
      for (int i = 0; i < _cartList.length; i++) {
        _discount = (int.parse(_cartList[i].product?.productPrice ?? "") *
                    int.parse(_cartList[i].product?.productOffer ?? "")) ~/
                100 +
            _discount;
      }
      notifyListeners();
      return _discount;
    } else {
      _discount = 0;
      notifyListeners();
      return _discount;
    }
  }

  void increment(int index) {
    CartItem cartItem = CartItem(
      itemQuantity: _cartList[index].itemQuantity++,
    );
    service.updateCart(cartItem);
    notifyListeners();
  }

  void decrement(int index) {
    if (_cartList.isNotEmpty) {
      CartItem cartItem = CartItem(
        itemQuantity: _cartList[index].itemQuantity--,
      );
      service.updateCart(cartItem);
    }
    notifyListeners();
  }

  void priceUpdate(context) {
    Cart cart = Cart(
      id: "gmI7kjp2hGf2UZYI1U58",
      subTotal: subTotal(),
      discountOnOrder: discountOnOrder(),
      deliveryCharges: 0,
      total: totalPrice(),
      couponDiscount: 0,
    );
    Provider.of<CartProvider>(context, listen: false)
        .updatePriceOfProduct(cart);
    notifyListeners();
  }
}
