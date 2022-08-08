import 'package:cloud_firestore/cloud_firestore.dart';

class CheckOut {
  final String? id;
  final String userId;
  final String productImage;
  final String productName;
  final String productPrice;
  final String productQuantity;
  int itemQuantity;

  CheckOut({
    this.id,
    this.userId = "",
    this.productImage = "",
    this.productName = "",
    this.productPrice = "",
    this.productQuantity = "",
    this.itemQuantity = 1,
  });

  factory CheckOut.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return CheckOut(
        id: doc.id,
        userId: doc.data()?["u_id"] ?? "",
        productImage: doc.data()?["p_img"] ?? "",
        productName: doc.data()?["p_name"] ?? "",
        productPrice: doc.data()?["p_price"] ?? "",
        productQuantity: doc.data()?["p_quantity"] ?? "",
        itemQuantity: doc.data()?["itemQuantity"] ?? 0);
  }

  Map<String, dynamic> toMap() {
    return {
      "u_id": userId,
      "p_img": productImage,
      "p_name": productName,
      "p_price": productPrice,
      "p_quantity": productQuantity,
      "itemQuantity": itemQuantity,
    };
  }
}
