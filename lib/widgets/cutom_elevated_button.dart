import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.onPress,
    required this.buttonName,
  }) : super(key: key);

  final Function()? onPress;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
      ),
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 15),
        child: Text(
          buttonName,
        ),
      ),
    );
  }
}
