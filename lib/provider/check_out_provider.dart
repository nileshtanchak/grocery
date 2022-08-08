import 'package:flutter/material.dart';
import 'package:on_boarding/check_out/database/check_out_database.dart';
import 'package:on_boarding/check_out/model/payment_method.dart';

import '../model/checkout.dart';

class CheckOutProvider extends ChangeNotifier {
  CheckOutDatabase services = CheckOutDatabase();
  PaymentMethod pay = PaymentMethod();
  List<CheckOut>? _checkOutList = [];
  bool isPickUp = false;
  bool isOnDelivery = false;

  List<CheckOut>? get checkOutList => _checkOutList;
  Future<List<CheckOut>?>? _futureCheckOutList;

  Future<List<CheckOut>?>? get futureCheckOutList => _futureCheckOutList;

  void addCartProductForCheckOut(CheckOut checkOut) {
    services.addCheckOutProduct(checkOut);
    notifyListeners();
  }

  Future<List<CheckOut>?> getCartProductForCheckOut() async {
    _checkOutList = await services.queryCheckOutProduct();
    notifyListeners();
    return _checkOutList;
  }

  Future<List<CheckOut>?> getCartProductForCheckOutFuture() async {
    _futureCheckOutList = services.queryCheckOutProduct();
    notifyListeners();
    return _futureCheckOutList;
  }

  void updateCartProductForCheckOut(product) {
    services.updateCheckOutProduct(product);
    notifyListeners();
  }

  void deleteCartProductForCheckOut(id) {
    services.deleteCheckOutProduct(id);
    checkOutList?.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void togglePickUp(bool value) {
    isPickUp = value;
    notifyListeners();
  }

  void toggleDelivery(bool value) {
    isOnDelivery = value;
    notifyListeners();
  }

// void onExpansionChangeValue(bool value, int index) {
//   pay.paymentCardList[index].isPressed = value;
//   notifyListeners();
// }
//
// void togglePaymentMethod(int index) {
//   pay.paymentCardList[index].isPressed =
//       !pay.paymentCardList[index].isPressed;
//   notifyListeners();
// }
}
