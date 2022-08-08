import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:on_boarding/favourite/database/favourite_database.dart';

import '../model/product.dart';

class FavouriteProvider extends ChangeNotifier {
  FavouriteDatabase service = FavouriteDatabase();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool isFavourite = false;
  Future<List<Product>>? _futureFavouriteList;

  Future<List<Product>>? get futureFavouriteList => _futureFavouriteList;
  List<Product> _favouriteList = [];

  List<Product> get favouriteList => _favouriteList;

  Future<List<Product>?> fetchFavouriteProduct() async {
    _futureFavouriteList = service.queryFavourite();
    _favouriteList = await service.queryFavourite();
    notifyListeners();
    return _futureFavouriteList;
  }

  void addFavouriteProduct(product) {
    service.addFavourite(product);
    notifyListeners();
  }

  Future<void> updateFavouriteProduct(product) async {
    service.updateFavourite(product);
    notifyListeners();
  }

  Future<List<Product>> favouriteQuery() async {
    _favouriteList = await service.queryFavourite();
    notifyListeners();
    return _favouriteList;
  }

  Future<bool> deleteFavouriteProduct(String id) async {
    await service.deleteFavourite(id);
    _favouriteList.removeWhere((element) => element.id == id);
    notifyListeners();
    return true;
  }
}
