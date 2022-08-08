import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PromoCodeContainer extends StatelessWidget {
  const PromoCodeContainer({
    Key? key,
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
            offset: Offset(400, 20),
            color: Colors.black12,
            blurRadius: 50,
          ),
          BoxShadow(
            offset: Offset(1, 1),
            color: Colors.white,
            blurRadius: 1,
          ),
        ],
      ),
      child: ListTile(
        title: const Text(
          "Add Your Promo Code",
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
        trailing: Icon(
          FontAwesomeIcons.tag,
          color: Theme.of(context).primaryColor,
          size: 30,
        ),
      ),
    );
  }
}
