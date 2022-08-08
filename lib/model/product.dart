import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? id;
  final String categoryId;
  final String details;
  final String productImage;
  final String productName;
  final String productPrice;
  final String productQuantity;
  final String productOffer;
  int itemQuantity;
  bool isFavourite;

  Product({
    this.id,
    this.categoryId = "",
    this.details = "",
    this.productImage = "",
    this.productName = "",
    this.productPrice = "",
    this.productQuantity = "",
    this.productOffer = "",
    this.itemQuantity = 1,
    this.isFavourite = false,
  });

  factory Product.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return Product(
      id: doc.id,
      categoryId: doc.data()?["c_id"] ?? "",
      details: doc.data()?["p_details"] ?? "",
      productImage: doc.data()?["p_img"] ?? "",
      productName: doc.data()?["p_name"] ?? "",
      productPrice: doc.data()?["p_price"] ?? "",
      productQuantity: doc.data()?["p_quantity"] ?? "",
      productOffer: doc.data()?["p_offer"] ?? "",
      itemQuantity: doc.data()?["itemQuantity"] ?? 1,
      isFavourite: doc.data()?["isFavourite"] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "c_id": categoryId,
      "p_details": details,
      "p_img": productImage,
      "p_name": productName,
      "p_price": productPrice,
      "p_quantity": productQuantity,
      "p_offer": productOffer,
      "itemQuantity": itemQuantity,
      "isFavourite": isFavourite,
    };
  }
}
