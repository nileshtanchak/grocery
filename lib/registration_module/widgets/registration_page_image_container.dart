import 'package:flutter/material.dart';

class RegistrationPageImageContainer extends StatelessWidget {
  const RegistrationPageImageContainer({
    required this.image,
    Key? key,
  }) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 170, bottom: 10),
      height: 200,
      width: double.infinity,
      child: Image(
        image: AssetImage(image),
      ),
    );
  }
}
