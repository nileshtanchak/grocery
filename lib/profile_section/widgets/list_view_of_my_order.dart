import 'package:flutter/material.dart';

class ListViewOfMyOrder extends StatelessWidget {
  final String title;
  final String details;

  const ListViewOfMyOrder({
    Key? key,
    required this.title,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Text(details),
    );
  }
}
