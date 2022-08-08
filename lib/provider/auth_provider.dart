import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  // String email = "";
  String? name;
  String? email;
  String? number;

  String? photoUrl;
  String? uId;

  bool? emailVerified;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> resetPassword(email) async {
    await _auth.sendPasswordResetEmail(email: email);
    notifyListeners();
  }

  void updateProfile() {
    final user = _auth.currentUser;
    if (user != null) {
      user.updateDisplayName("Nilesh Tanchak");
      user.updatePhotoURL("");

      PhoneAuthCredential phoneCredential = PhoneAuthProvider.credential(
          verificationId: "verificationId", smsCode: "5256");
      number = user.updatePhoneNumber(phoneCredential) as String?;
    }
    notifyListeners();
  }
}
