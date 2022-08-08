import 'package:flutter/material.dart';

class RegistrationProvider extends ChangeNotifier {
  bool isShow = true;
  bool isLoading = false;
  int _currentUser = 0;
  int _currentIndex = 0;

  int get currentUser => _currentUser;

  int get currentIndex => _currentIndex;

  void getIndex(int index) {
    _currentUser = index;
    notifyListeners();
  }

  void findIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void toggleIsShow() {
    isShow = !isShow;
    notifyListeners();
  }

  void toggleIsLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  void toggleIsLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }
}
