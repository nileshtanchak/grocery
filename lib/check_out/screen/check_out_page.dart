import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import 'package:on_boarding/profile_section/Provider/profile_provider.dart';
import 'package:on_boarding/provider/check_out_provider.dart';
import 'package:on_boarding/shopping_cart/provider/shopping_provider.dart';
import 'package:provider/provider.dart';

import '../../model/product.dart';
import '../model/payment_method.dart';

class CheckOutPage extends StatelessWidget {
  final Product? product;

  const CheckOutPage({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void dialog() {
      showDialog(
          context: context,
          builder: (context) {
            final provider = Provider.of<ShoppingProvider>(context);
            return AlertDialog(
              title: const Image(
                image: AssetImage("images/celebration_emoji.png"),
              ),
              // titlePadding: EdgeInsets.zero,
              content: const SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    "Order Successful",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              actions: [
                Text(
                  "Your order id ${product?.id} has been placed successfully",
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Track my order"),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Go Back"),
                  ),
                )
              ],
            );
          });
    }

    List<PaymentMethod> paymentCardList = [
      PaymentMethod(
        icons: Icons.credit_card,
        title: "Credit card/ Debit card",
        isPressed: false,
      ),
      PaymentMethod(
        icons: FontAwesomeIcons.googlePay,
        title: "UPI",
        isPressed: false,
      ),
      PaymentMethod(
        icons: Icons.account_balance_wallet_outlined,
        title: "Wallet",
        isPressed: false,
      ),
      PaymentMethod(
        title: "Net Banking",
        isPressed: false,
      ),
      PaymentMethod(
        icons: Icons.attach_money,
        title: "Cash on Delivery",
        isPressed: false,
      ),
    ];
    context.read<ProfileProvider>().fetchProfileDetailsOfLoggedInUser();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      /// SafeArea
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Delivery Address
                Consumer<ProfileProvider>(
                  builder: (_, provider, __) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.profileList.length,
                      itemBuilder: (_, index) {
                        return Container(
                          width: double.infinity,
                          // margin: const EdgeInsets.symmetric(
                          //     horizontal: 16, vertical: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(1, 1),
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(1, 1),
                                  blurRadius: 2)
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Delivery Address",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(provider.profileList[index].address),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Add more",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                  "Mobile: ${provider.profileList[index].number}"),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 36,
                ),

                /// Header
                const Text(
                  "Delivery Date",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                /// Date Picker
                HorizontalCalendar(
                  date: DateTime.now(),
                  lastDate: DateTime.now().add(
                    const Duration(days: 30),
                  ),
                  showMonth: true,
                  textColor: Colors.black45,
                  backgroundColor: Colors.white12,
                  selectedColor: Colors.green,
                  onDateSelected: (date) => print(
                    date.toString(),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),

                /// Header
                const Text(
                  "Time Slot",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 36,
                ),

                /// Time Slot
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      // height: 10,
                      // width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black54),
                      ),
                      child: const Text("09:00 am"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 36,
                ),

                /// Header
                const Text(
                  "Delivery Method",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 36,
                ),

                /// delivery method
                Consumer<CheckOutProvider>(
                  builder: (_, provider, __) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Checkbox(
                              checkColor: Colors.white,
                              value: provider.isOnDelivery,
                              shape: const CircleBorder(),
                              onChanged: (bool? value) {
                                provider.toggleDelivery(value!);
                              },
                            ),
                            title: const Text(
                              "Door Delivery",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(),

                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Checkbox(
                              checkColor: Colors.white,
                              value: provider.isPickUp,
                              shape: const CircleBorder(),
                              onChanged: (value) {
                                provider.togglePickUp(value!);
                              },
                            ),
                            title: const Text(
                              "Pick Up",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )

                          /// SizedBox
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 36,
                ),

                /// Card method
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Payment",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.zero,
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Add New",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 36.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: paymentCardList.length,
                          itemBuilder: (_, index) {
                            // final provider =
                            //     Provider.of<CheckOutProvider>(context);
                            return ExpansionTile(
                              onExpansionChanged: (value) {
                                // provider.onExpansionChangeValue(value, index);
                              },
                              title: Text(paymentCardList[index].title),
                              leading: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  paymentCardList[index].icons,
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  // provider.togglePaymentMethod(index);
                                },
                                icon: Icon(
                                  paymentCardList[index].isPressed
                                      ? FontAwesomeIcons.angleUp
                                      : FontAwesomeIcons.angleDown,
                                  size: 15,
                                ),
                              ),
                              children: <Widget>[
                                ListTile(
                                  leading: Checkbox(
                                    checkColor: Colors.white,
                                    value: true,
                                    shape: const CircleBorder(),
                                    onChanged: (bool? value) {},
                                  ),
                                  title: const Text("Google Pay"),
                                  trailing:
                                      const Icon(FontAwesomeIcons.googlePay),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                /// Term and Condition
                const Text(
                  "By placing an order you agree to our",
                  style: TextStyle(color: Colors.black45),
                ),
                Row(
                  children: const [
                    Text(
                      "Terms ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "and ",
                      style: TextStyle(color: Colors.black45),
                    ),
                    Text(
                      "Condition",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 36,
                ),

                /// Final Button to Continue

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total:",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                          Text(
                            "Rs. ${Provider.of<ShoppingProvider>(context).totalPrice().toString()}",
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 36,
                      ),
                      Consumer<CheckOutProvider>(
                        builder: (_, provider, __) {
                          return Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 20),
                                ),
                              ),
                              onPressed: () {
                                // CheckOut checkOut = CheckOut(
                                //   productName: "",
                                //   productQuantity: "1",
                                //   productPrice: "20",
                                //   productImage: "",
                                //   itemQuantity: 5,
                                // );
                                // provider.addCartProductForCheckOut(checkOut);
                                dialog();
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=> ))
                              },
                              child: const Text("Continue"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
