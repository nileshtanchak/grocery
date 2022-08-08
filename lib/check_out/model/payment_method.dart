import 'package:flutter/material.dart';

class PaymentMethod {
  IconData? icons;
  String title;
  bool isPressed;

  PaymentMethod({
    this.icons,
    this.title = "",
    this.isPressed = false,
  });
}
