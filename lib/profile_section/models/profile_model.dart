import 'package:flutter/material.dart';

class ProfileModel {
  IconData priIcon;
  String title;
  IconData trailingIcon;
  Widget? screenName;

  ProfileModel({
    this.title = "",
    required this.priIcon,
    this.trailingIcon = Icons.arrow_forward_ios_sharp,
    required this.screenName,
  });
}
