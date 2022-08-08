import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_boarding/model/cart.dart';

import '../constant/constant.dart';

class CartDatabase {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void addPrice(Cart cart) async {
    await firebaseFirestore
        .collection("cart")
        .doc(Constant.checkCurrentUser())
        .collection("cart_price")
        .add(cart.toMap());
  }

  Future<List<Cart>> queryOfPrice() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("cart")
        .doc(Constant.checkCurrentUser())
        .collection("cart_price")
        .get();
    return snapshot.docs.map((e) => Cart.fromDocumentSnapshot(e)).toList();
  }

  void updatePrice(Cart cart) async {
    await firebaseFirestore
        .collection("cart")
        .doc(Constant.checkCurrentUser())
        .collection("cart_price")
        .doc(cart.id)
        .update(cart.toMap());
  }

  Future<void> deletePrice(String documentId) async {
    await firebaseFirestore
        .collection("cart")
        .doc(Constant.checkCurrentUser())
        .collection("cart_price")
        .doc(documentId)
        .delete();
  }
}
