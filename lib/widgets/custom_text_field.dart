import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.priIcons,
    this.suffixIcons,
    this.onPress,
    this.suffixColor,
    required this.obscureText,
    this.checkValidation,
    this.filled,
    this.filledColor,
    this.border,
    this.priIconColor,
    this.keyBoardType,
    this.onChange,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final IconData? priIcons;
  final IconData? suffixIcons;
  final Function()? onPress;
  final Color? suffixColor;
  final bool obscureText;
  final String? Function(String?)? checkValidation;
  final bool? filled;
  final Color? filledColor;
  final InputBorder? border;
  final Color? priIconColor;
  final TextInputType? keyBoardType;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyBoardType,
      validator: checkValidation,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        border: border,
        fillColor: filledColor,
        filled: filled,
        prefixIcon: Icon(priIcons, size: 20, color: priIconColor),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black26),
        suffixIcon: IconButton(
          onPressed: onPress,
          icon: Icon(suffixIcons, size: 16, color: suffixColor),
        ),
      ),
      onChanged: onChange,
    );
  }
}
