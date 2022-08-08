import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String? id;
  final String image;
  final String name;

  Category({
    this.id,
    required this.image,
    required this.name,
  });

  factory Category.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return Category(
        id: doc.id, image: doc.data()!["c_img"], name: doc.data()!["c_name"]);
  }

  Map<String, dynamic> toMap() {
    return {"c_img": image, "c_name": name};
  }
}
