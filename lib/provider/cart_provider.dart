import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/cart.dart';
import '../services/cart_database.dart';

class CartProvider extends ChangeNotifier {
  CartDatabase service = CartDatabase();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // int _total = 0;
  //
  // int get total => _total;
  //
  // int _productTotalPrice = 0;
  //
  // int get productTotalPrice => _productTotalPrice;
  // int _discount = 0;
  //
  // int get discount => _discount;
  Future<List<Cart>>? _futurePriceList;

  Future<List<Cart>>? get futurePriceList => _futurePriceList;
  List<Cart> _priceList = [];

  List<Cart> get priceList => _priceList;

  Future<List<Cart>?> priceData() async {
    _futurePriceList = service.queryOfPrice();
    notifyListeners();
    return _futurePriceList;
  }

  Future<void> addPrice(cart) async {
    service.addPrice(cart);
    notifyListeners();
  }

  Future<void> updatePriceOfProduct(cart) async {
    service.updatePrice(cart);
    notifyListeners();
  }

  Future<List<Cart>> priceQuery() async {
    _priceList = await service.queryOfPrice();
    notifyListeners();
    return _priceList;
  }

  Future<bool> deletePriceData(String id) async {
    await service.deletePrice(id);
    _priceList.removeWhere((element) => element.id == id);
    notifyListeners();
    return true;
  }
}
