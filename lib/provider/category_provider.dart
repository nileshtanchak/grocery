import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/category.dart';
import '../services/databaseService.dart';

class CategoryProvider extends ChangeNotifier {
  DatabaseService service = DatabaseService();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<List<Category>>? _futureCategoryList;

  Future<List<Category>>? get futureCategoryList => _futureCategoryList;
  List<Category> _categoryList = [];

  List<Category> get categoryList => _categoryList;

  Future<List<Category>?> fetchCategory() async {
    _futureCategoryList = service.getCategory();
    _categoryList = await service.getCategory();
    notifyListeners();
    return _categoryList;
  }

  void addCategory(category) {
    service.addCategory(category);
    notifyListeners();
  }

  Future<void> updateCategory(category) async {
    service.updateCategory(category);
    notifyListeners();
  }

  Future<List<Category>> categoryQuery() async {
    _categoryList = await service.getCategory();
    notifyListeners();
    return _categoryList;
  }

  Future<bool> deleteCategory(String id) async {
    await service.deleteCategory(id);
    _categoryList.removeWhere((element) => element.id == id);
    notifyListeners();
    return true;
  }

// void toggleIsFavourite(int index) {
//   if (_productList.isNotEmpty) {
//     Product product = Product();
//     // _productList[index].isFavourite = !_productList[index].isFavourite;
//   }
// }
}
