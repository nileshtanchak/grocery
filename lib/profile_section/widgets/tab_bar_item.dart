import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shopping_cart/provider/shopping_provider.dart';
import 'list_view_of_my_order.dart';

class TabBarItem extends StatelessWidget {
  const TabBarItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      elevation: 5,
      child: Consumer<ShoppingProvider>(
        builder: (_, provider, __) {
          return Column(
            children: [
              const ListViewOfMyOrder(
                title: "Order ID",
                details: "#1122331223",
              ),
              const Divider(),
              ListViewOfMyOrder(
                title: "Order List",
                details: "${provider.cartList.length.toString()} items",
              ),
              const Divider(),
              ListViewOfMyOrder(
                title: "Total Bill",
                details: provider.totalPrice().toString(),
              ),
              const Divider(),
              const ListViewOfMyOrder(
                title: "Status",
                details: "pending",
              ),
            ],
          );
        },
      ),
    );
  }
}
