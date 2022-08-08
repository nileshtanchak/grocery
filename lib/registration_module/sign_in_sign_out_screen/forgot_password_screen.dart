import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:on_boarding/widgets/custom_text_field.dart';

import '../../constant/constant.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    Container(
      height: 50,
      width: 50,
      color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Navigator.pop(context);
      Constant.showToast("Email send for reset password");
    } on FirebaseAuthException catch (e) {
      Constant.showToast(e.message!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Text("Plz Enter Email beloved"),
              CustomTextField(
                controller: emailController,
                hintText: "Enter Email",
                obscureText: false,
              ),
              ElevatedButton(
                onPressed: resetPassword,
                child: const Text("Send Email"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
