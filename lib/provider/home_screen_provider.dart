import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier {
  String name = "Banana";


  void onChange(String value) {
    name = value;
    notifyListeners();
  }


}
