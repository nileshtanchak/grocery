import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:on_boarding/constant/constant.dart';
import 'package:on_boarding/provider/registration_provider.dart';
import 'package:on_boarding/widgets/cutom_elevated_button.dart';
import 'package:provider/provider.dart';

import '../../dash_board_page/dash_board_screens/dash_board_screen.dart';
import '../widgets/registration_page_image_container.dart';
import '../widgets/sign_in_tabbar.dart';
import '../widgets/sign_up_tabbar.dart';

late String uId;

class SignInAndSignOutPage extends StatefulWidget {
  const SignInAndSignOutPage({Key? key}) : super(key: key);

  @override
  State<SignInAndSignOutPage> createState() => _SignInAndSignOutPageState();
}

class _SignInAndSignOutPageState extends State<SignInAndSignOutPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController signUpPasswordController;
  late TextEditingController otpController;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    userNameController = TextEditingController(
      text: "bhaveshtanchak@gmail.com",
    );
    passwordController = TextEditingController(
      text: "justinil140",
    );
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    signUpPasswordController = TextEditingController();
    otpController = TextEditingController();
    //dialogue();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    signUpPasswordController.dispose();
    otpController.dispose();
  }

  // void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async {
  //   try {
  //     final authCred = await _auth.signInWithCredential(phoneAuthCredential);
  //
  //     if (authCred.user != null) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const DashBoardScreen(),
  //         ),
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message);
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text('Some Error Occurred. Try Again Later')));
  //   }
  // }

  // void dialogue() async {
  //   await showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text("OTP verification"),
  //       content: CustomTextField(
  //         controller: otpController,
  //         hintText: "otp",
  //         obscureText: false,
  //         checkValidation: (value) {
  //           if (value!.isEmpty && value == null) {
  //             return "username can't be empty";
  //           }
  //           return null;
  //         },
  //       ),
  //       actions: [
  //         CustomElevatedButton(
  //           buttonName: "Verify",
  //           onPress: () {
  //             AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
  //                 verificationId: verificationID, smsCode: otpController.text);
  //             signInWithPhoneAuthCred(phoneAuthCredential);
  //             otpController.text = "";
  //             Navigator.pop(context);
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Consumer<RegistrationProvider>(
          builder: (_, provider, __) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const RegistrationPageImageContainer(
                          image: "images/images.png"),
                      Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(10),
                        height: 400,
                        width: double.infinity,
                        decoration: Constant.kSignupSignInContainerDecoration,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TabBar(
                                onTap: (index) {
                                  provider.findIndex(index);
                                },
                                controller: tabController,
                                labelColor: Colors.black,
                                labelStyle: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                                unselectedLabelColor: Colors.black54,
                                indicatorSize: TabBarIndicatorSize.label,
                                tabs: const [
                                  Tab(
                                    text: "Sign in",
                                  ),
                                  Tab(
                                    text: "Sign up",
                                  ),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: tabController,
                                  children: [
                                    SignInTabBar(
                                      userNameController: userNameController,
                                      passwordController: passwordController,
                                      obscureText: provider.isShow,
                                      suffixColor: provider.isShow
                                          ? Theme.of(context).primaryColor
                                          : Colors.black26,
                                      onPress: () {
                                        provider.toggleIsShow();
                                      },
                                    ),
                                    SignUpTabBar(
                                      nameController: nameController,
                                      emailController: emailController,
                                      phoneNumberController:
                                          phoneNumberController,
                                      signUpPasswordController:
                                          signUpPasswordController,
                                      suffixColor: provider.isShow
                                          ? Theme.of(context).primaryColor
                                          : Colors.black26,
                                      obscureText: provider.isShow,
                                      onPress: () {
                                        provider.toggleIsShow();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// Elevated Button of Sign in
                      CustomElevatedButton(
                        buttonName:
                            provider.currentIndex == 0 ? "SignIn" : "SignUp",
                        onPress: provider.currentIndex == 0
                            ? () async {
                                if (_formKey.currentState!.validate()) {
                                  provider.toggleIsLoadingTrue();

                                  try {
                                    UserCredential existingUser =
                                        await _auth.signInWithEmailAndPassword(
                                      email: userNameController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                    if (existingUser != null) {
                                      provider.toggleIsLoadingFalse();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DashBoardScreen(),
                                        ),
                                        (_) => false,
                                      );
                                    }
                                    provider.toggleIsLoadingFalse();
                                  } on FirebaseAuthException catch (e) {
                                    provider.toggleIsLoadingFalse();
                                    if (e.code == "user-not-found") {
                                      Constant.showToast(
                                          "no user found for this email and password");
                                    } else if (e.code == "wrong-password") {
                                      Constant.showToast(
                                          "please enter valid password");
                                    }
                                  } catch (e) {
                                    provider.toggleIsLoadingFalse();
                                    Constant.showToast("Invalid");
                                  }

                                  // await _auth.verifyPhoneNumber(
                                  //     phoneNumber:
                                  //     "+91${phoneNumberController.text.trim()}",
                                  //     verificationCompleted:
                                  //         (phoneAuthCredential) async {},
                                  //     verificationFailed: (verificationFailed) {
                                  //       print(verificationFailed);
                                  //     },
                                  //     codeSent: (verificationID, resendingToken) async {
                                  //       dialogue();
                                  //       this.verificationID = verificationID;
                                  //     },
                                  //     codeAutoRetrievalTimeout:
                                  //         (verificationID) async {});
                                }
                              }
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  provider.toggleIsLoadingTrue();
                                  try {
                                    UserCredential? newUser = await _auth
                                        .createUserWithEmailAndPassword(
                                      email: emailController.text.trim(),
                                      password:
                                          signUpPasswordController.text.trim(),
                                    );
                                    if (newUser != null) {
                                      provider.toggleIsLoadingFalse();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DashBoardScreen(),
                                        ),
                                        (_) => false,
                                      );
                                    }
                                    provider.toggleIsLoadingFalse();
                                  } on FirebaseAuthException catch (e) {
                                    provider.toggleIsLoadingFalse();
                                    if (e.code == "weak-password") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "password should have at-least 6 character"),
                                        ),
                                      );
                                    } else if (e.code ==
                                        "email-already-in-use") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "this user account is already exists"),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    print(e);
                                  }

                                  // await _auth.verifyPhoneNumber(
                                  //     phoneNumber:
                                  //     "+91${phoneNumberController.text.trim()}",
                                  //     verificationCompleted:
                                  //         (phoneAuthCredential) async {},
                                  //     verificationFailed: (verificationFailed) {
                                  //       print(verificationFailed);
                                  //     },
                                  //     codeSent: (verificationID, resendingToken) async {
                                  //       dialogue();
                                  //       this.verificationID = verificationID;
                                  //     },
                                  //     codeAutoRetrievalTimeout:
                                  //         (verificationID) async {});
                                }
                              },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.black45),
                          ),
                          TextButton(
                            onPressed: () {
                              tabController
                                  .animateTo((tabController.index + 1));
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                if (provider.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
