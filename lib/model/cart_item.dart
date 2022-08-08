import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_boarding/model/product.dart';

class CartItem {
  final String? id;
  final Product? product;
  int itemQuantity;

  CartItem({
    this.id,
    this.product,
    this.itemQuantity = 1,
  });

  factory CartItem.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return CartItem(
      id: doc.id,
      product: Product.fromDocumentSnapshot(doc),
      itemQuantity: doc.data()?["itemQuantity"] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "product": product?.toMap(),
      "itemQuantity": itemQuantity,
    };
  }
}
