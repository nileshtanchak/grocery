import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:on_boarding/profile_section/models/profile_details.dart';
import 'package:on_boarding/profile_section/profile_database/profile_database.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileDatabase profileDatabase = ProfileDatabase();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = "";
  String uId = "";

  Future<List<ProfileDetails>>? _futureProfileList;

  Future<List<ProfileDetails>>? get futureProfileList => _futureProfileList;
  late List<ProfileDetails> _profileList = [];

  List<ProfileDetails> get profileList => _profileList;

  Future<void> profileDetailsAdd(profile) async {
    await profileDatabase.addProfileDetails(profile);
    notifyListeners();
  }

  Future<List<ProfileDetails>?>
      fetchProfileDetailsOfLoggedInUserInFuture() async {
    _futureProfileList = profileDatabase.fetchProfileDetails();
    return _futureProfileList;
  }

  Future<List<ProfileDetails>?> fetchProfileDetailsOfLoggedInUser() async {
    _profileList = await profileDatabase.fetchProfileDetails();
    notifyListeners();
    return _profileList;
  }

  void updateProfileData(profile) {
    profileDatabase.updateProfileDetails(profile);
    notifyListeners();
  }

  Future<bool> deleteProfileOfUser(String id) async {
    await profileDatabase.deleteProfileDetails(id);
    _profileList.removeWhere((element) => element.id == id);
    notifyListeners();
    return true;
  }

  String checkCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        email = user.email!;
        uId = user.uid;
      }
    } catch (e) {
      print(e);
    }

    return email;
  }
}
