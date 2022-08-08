import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:on_boarding/services/databaseService.dart';

import '../model/product.dart';

class ProductProvider extends ChangeNotifier {
  DatabaseService service = DatabaseService();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<List<Product>>? _futureProductList;
  bool favourite = false;
  List<bool> checkFavourite = [false, false, false, false, false, false, false];

  Future<List<Product>>? get futureProductList => _futureProductList;
  List<Product> _productList = [];

  List<Product> get productList => _productList;

  Future<List<Product>?> fetchProduct() async {
    _futureProductList = service.getProduct();
    _productList = await service.getProduct();
    notifyListeners();
    return _productList;
  }

  void addProduct(product) {
    service.addProduct(product);
    notifyListeners();
  }

  Future<void> updateProduct(product) async {
    service.updateProduct(product);
    notifyListeners();
  }

  Future<List<Product>> productQuery() async {
    _productList = await service.getProduct();
    notifyListeners();
    return _productList;
  }

  Future<bool> deleteProduct(String id) async {
    await service.deleteProduct(id);
    _productList.removeWhere((element) => element.id == id);
    notifyListeners();
    return true;
  }

  void toggleFavourite(i) {
    checkFavourite[i] = !checkFavourite[i];
    // favourite = _productList[i].isFavourite;
    // favourite = !favourite;
    notifyListeners();
  }

  updateFavourite(Product products, int index) {
    Product product = Product(
      productImage: products.productImage,
      productPrice: products.productPrice,
      productQuantity: products.productQuantity,
      productOffer: products.productOffer,
      productName: products.productName,
      details: products.details,
      categoryId: products.categoryId,
      id: products.id,
      isFavourite: checkFavourite[index],
    );
    updateProduct(product);
    notifyListeners();
  }
}
