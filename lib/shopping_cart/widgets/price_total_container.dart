import 'package:flutter/material.dart';

class PriceTotalContainer extends StatelessWidget {
  final String total;
  final String subTotal;
  final String discount;

  const PriceTotalContainer({
    Key? key,
    required this.total,
    required this.subTotal,
    required this.discount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            offset: Offset(400, 0),
            color: Colors.black12,
            blurRadius: 0,
          ),
          BoxShadow(
            offset: Offset(1, 1),
            color: Colors.white,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Subtotal",
                style: TextStyle(color: Colors.black54),
              ),
              Text(
                subTotal,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Discount on Order",
                style: TextStyle(color: Colors.black54),
              ),
              Text(discount, style: const TextStyle(color: Colors.green)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Coupon Discount",
                style: TextStyle(color: Colors.black54),
              ),
              Text("Rs. 0",
                  style: TextStyle(color: Colors.green.withOpacity(0.5))),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Delivery Charges",
                style: TextStyle(color: Colors.black54),
              ),
              Text("Free", style: TextStyle(color: Colors.red)),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Text(total,
                  style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ],
          ),
        ],
      ),
    );
  }
}
