import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_boarding/constant/constant.dart';
import 'package:on_boarding/profile_section/models/profile_details.dart';

class ProfileDatabase {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addProfileDetails(ProfileDetails profile) async {
    await firebaseFirestore
        .collection("User")
        .doc(Constant.checkCurrentUser())
        .collection("list of user")
        .add(profile.toMap());
  }

  void updateProfileDetails(ProfileDetails profile) async {
    await firebaseFirestore
        .collection("User")
        .doc(Constant.checkCurrentUser())
        .collection("list of user")
        .doc(profile.id)
        .update(profile.toMap());
  }

  Future<void> deleteProfileDetails(String documentId) async {
    await firebaseFirestore
        .collection("User")
        .doc(Constant.checkCurrentUser())
        .collection("list of user")
        .doc(documentId)
        .delete();
  }

  Future<List<ProfileDetails>> fetchProfileDetails() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("User")
        .doc(Constant.checkCurrentUser())
        .collection("list of user")
        .get();

    return snapshot.docs
        .map((e) => ProfileDetails.fromDocumentSnapshot(e))
        .toList();
  }
}
