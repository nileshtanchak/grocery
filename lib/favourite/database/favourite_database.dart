import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constant/constant.dart';
import '../../model/product.dart';

class FavouriteDatabase {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void addFavourite(Product product) async {
    await firebaseFirestore
        .collection("favourite")
        .doc(Constant.checkCurrentUser())
        .collection("favourite_list")
        .add(product.toMap());
  }

  Future<List<Product>> queryFavourite() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("favourite")
        .doc(Constant.checkCurrentUser())
        .collection("favourite_list")
        .get();
    return snapshot.docs.map((e) => Product.fromDocumentSnapshot(e)).toList();
  }

  void updateFavourite(Product product) async {
    await firebaseFirestore
        .collection("favourite")
        .doc(Constant.checkCurrentUser())
        .collection("favourite_list")
        .doc(product.id)
        .update(product.toMap());
  }

  Future<void> deleteFavourite(String documentId) async {
    await firebaseFirestore
        .collection("favourite")
        .doc(Constant.checkCurrentUser())
        .collection("favourite_list")
        .doc(documentId)
        .delete();
  }

  Future<List<Product>> isFavouriteQuery() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("products")
        .where("isFavourite", isEqualTo: true)
        .get();
    return snapshot.docs.map((e) => Product.fromDocumentSnapshot(e)).toList();
  }
}
