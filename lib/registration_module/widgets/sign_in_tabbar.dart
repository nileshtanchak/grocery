import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:on_boarding/registration_module/sign_in_sign_out_screen/forgot_password_screen.dart';

import '../../widgets/custom_text_field.dart';

class SignInTabBar extends StatelessWidget {
  const SignInTabBar({
    Key? key,
    required this.userNameController,
    required this.passwordController,
    required this.obscureText,
    this.onPress,
    required this.suffixColor,
  }) : super(key: key);

  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final bool obscureText;
  final Color suffixColor;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomTextField(
          controller: userNameController,
          priIcons: FontAwesomeIcons.user,
          hintText: "username",
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
          controller: passwordController,
          priIcons: FontAwesomeIcons.lock,
          hintText: "password",
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
            const Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ),
                  );
                },
                child: const Text("Forgot Password")),
          ],
        ),
        Row(
          children: const [
            Expanded(
              child: Divider(),
            ),
            Text(
              "   OR   ",
              style: TextStyle(color: Colors.black26, fontSize: 10),
            ),
            Expanded(child: Divider()),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              FontAwesomeIcons.twitter,
              color: Colors.lightBlueAccent,
            ),
            const Icon(
              FontAwesomeIcons.facebook,
              color: Colors.blue,
            ),
            Icon(
              Icons.mail_outline,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ],
    );
  }
}
