import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_boarding/constant/constant.dart';
import 'package:on_boarding/model/cart_item.dart';

import '../model/category.dart';
import '../model/product.dart';

class DatabaseService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  /// Category Database
  void addCategory(Category category) async {
    await firebaseFirestore.collection("categories").add(category.toMap());
  }

  Future<List<Category>> getCategory() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firebaseFirestore.collection("categories").get();
    return snapshot.docs.map((e) => Category.fromDocumentSnapshot(e)).toList();
  }

  void updateCategory(Category category) async {
    await firebaseFirestore
        .collection("categories")
        .doc(category.id)
        .update(category.toMap());
  }

  Future<void> deleteCategory(String documentId) async {
    await firebaseFirestore.collection("categories").doc(documentId).delete();
  }

  /// Product Database
  void addProduct(Product product) async {
    await firebaseFirestore.collection("products").add(product.toMap());
  }

  Future<List<Product>> getProduct() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firebaseFirestore.collection("products").get();
    return snapshot.docs.map((e) => Product.fromDocumentSnapshot(e)).toList();
  }

  void updateProduct(Product product) async {
    await firebaseFirestore
        .collection("products")
        .doc(product.id)
        .update(product.toMap());
  }

  Future<void> deleteProduct(String documentId) async {
    await firebaseFirestore.collection("products").doc(documentId).delete();
  }

  /// Cart Database
  void addCart(Product product) async {
    await firebaseFirestore
        .collection("cart")
        .doc(Constant.checkCurrentUser())
        .collection("user_cart")
        .add(product.toMap());
  }

  Future<List<CartItem>> queryCart() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("cart")
        .doc(Constant.checkCurrentUser())
        .collection("user_cart")
        .get();
    return snapshot.docs.map((e) => CartItem.fromDocumentSnapshot(e)).toList();
  }

  void updateCart(CartItem cartItem) async {
    await firebaseFirestore
        .collection("cart")
        .doc(Constant.checkCurrentUser())
        .collection("user_cart")
        .doc(cartItem.id)
        .update(cartItem.toMap());
  }

  Future<void> deleteCart(String documentId) async {
    await firebaseFirestore
        .collection("cart")
        .doc(Constant.checkCurrentUser())
        .collection("user_cart")
        .doc(documentId)
        .delete();
  }

  /// Filter For Category Wise List
  Future<List<Product>> queryProduct(String id) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("products")
        .where("c_id", isEqualTo: id)
        .get();
    return snapshot.docs.map((e) => Product.fromDocumentSnapshot(e)).toList();
  }
}
