import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/checkout.dart';

class CheckOutDatabase {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser!;

  void addCheckOutProduct(CheckOut checkOut) async {
    print(user.uid);
    await firebaseFirestore
        .collection("checkout")
        .doc(user.uid)
        .collection("checkout_products_list")
        .add(checkOut.toMap());
  }

  Future<List<CheckOut>>? queryCheckOutProduct() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("checkout")
        .doc(user.uid)
        .collection("checkout_products_list")
        .get();

    return snapshot.docs.map((e) => CheckOut.fromDocumentSnapshot(e)).toList();
  }

  void updateCheckOutProduct(CheckOut checkOut) async {
    await firebaseFirestore
        .collection("checkout")
        .doc(user.uid)
        .collection("checkout_products_list")
        .doc(checkOut.id)
        .update(checkOut.toMap());
  }

  void deleteCheckOutProduct(String id) async {
    await firebaseFirestore
        .collection("checkout")
        .doc(user.uid)
        .collection("checkout_products_list")
        .doc(id)
        .delete();
  }
}
