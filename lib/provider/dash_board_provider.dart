import 'package:flutter/material.dart';

class DashBoardProvider extends ChangeNotifier {
  int selectedIndex = 0;

  void onSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
