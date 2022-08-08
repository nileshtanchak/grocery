import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  final String? id;
  final int subTotal;
  final int discountOnOrder;
  final int couponDiscount;
  final int deliveryCharges;
  final int total;

  // List<CartItem> cartItemList;

  Cart({
    this.id,
    this.subTotal = 0,
    this.discountOnOrder = 0,
    this.couponDiscount = 0,
    this.deliveryCharges = 0,
    this.total = 0,
    // this.cartItemList = const [],
  });

  factory Cart.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return Cart(
      id: doc.id,
      subTotal: doc.data()?["subTotal"] ?? "",
      discountOnOrder: doc.data()?["discountOnOrder"] ?? "",
      deliveryCharges: doc.data()?["deliveryCharges"] ?? "",
      total: doc.data()?["total"] ?? "",
      couponDiscount: doc.data()?["couponDiscount"] ?? 0,
      // cartItemList: List<CartItem>.from(doc
      //     .data()?["cartItemList"]
      //     .map((x) => CartItem.fromDocumentSnapshot(x))).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "subTotal": subTotal,
      "discountOnOrder": discountOnOrder,
      "deliveryCharges": deliveryCharges,
      "total": total,
      "couponDiscount": couponDiscount,
      // "cartItemList": List<CartItem>.from(cartItemList.map((x) => x.toMap())),
    };
  }
}
