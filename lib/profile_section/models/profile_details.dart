import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileDetails {
  String? id;
  String name;
  String address;
  String number;
  String image;

  ProfileDetails({
    this.id,
    this.name = "",
    this.address = "",
    this.number = "",
    this.image = "",
  });

  factory ProfileDetails.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> docs) {
    return ProfileDetails(
      id: docs.id,
      name: docs.data()!["name"],
      address: docs.data()!["address"],
      number: docs.data()!["number"],
      image: docs.data()?["image"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "address": address,
      "number": number,
      "image": image,
    };
  }
}
