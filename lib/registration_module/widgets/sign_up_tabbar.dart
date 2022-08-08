import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/custom_text_field.dart';

class SignUpTabBar extends StatelessWidget {
  const SignUpTabBar({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.signUpPasswordController,
    required this.obscureText,
    required this.suffixColor,
    this.onPress,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController signUpPasswordController;
  final bool obscureText;
  final Color suffixColor;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomTextField(
          controller: nameController,
          hintText: "name",
          priIcons: FontAwesomeIcons.user,
          obscureText: false,
          priIconColor: Colors.black26,
          checkValidation: (value) {
            if (value != null) {
              if (value.isEmpty) {
                return "username can't be empty";
              }
              return null;
            }
            return null;
          },
        ),
        CustomTextField(
          controller: emailController,
          keyBoardType: TextInputType.emailAddress,
          hintText: "Email",
          priIcons: Icons.mail_outline,
          obscureText: false,
          priIconColor: Colors.black26,
          checkValidation: (value) {
            if (value != null) {
              if (value.isEmpty) {
                return "username can't be empty";
              }
              return null;
            }
            return null;
          },
        ),
        CustomTextField(
          controller: phoneNumberController,
          keyBoardType: TextInputType.number,
          hintText: "Phone number",
          priIcons: FontAwesomeIcons.phone,
          obscureText: false,
          priIconColor: Colors.black26,
          checkValidation: (value) {
            if (value != null) {
              if (value.isEmpty) {
                return "username can't be empty";
              }
              return null;
            }
            return null;
          },
        ),
        CustomTextField(
          controller: signUpPasswordController,
          hintText: "Password",
          priIcons: FontAwesomeIcons.lock,
          obscureText: obscureText,
          suffixIcons: FontAwesomeIcons.eye,
          suffixColor: suffixColor,
          priIconColor: Colors.black26,
          onPress: onPress,
          checkValidation: (value) {
            if (value != null) {
              if (value.isEmpty) {
                return "username can't be empty";
              }
              return null;
            }
            return null;
          },
        ),
        Row(
          children: [
            Checkbox(
              value: true,
              onChanged: (value) {},
            ),
            const Text("Remember me"),
          ],
        ),
      ],
    );
  }
}
