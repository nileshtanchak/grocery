import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:on_boarding/constant/constant.dart';
import 'package:on_boarding/on_boarding/screens/on_boarding_screen.dart';
import 'package:on_boarding/profile_section/profile_section_screens/contact_us.dart';

import '../../utils/preference_utils.dart';
import '../models/profile_model.dart';
import 'my_details_screen.dart';
import 'order_screen.dart';

class ProfileBottomBarPage extends StatelessWidget {
  const ProfileBottomBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void dialog() {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Are you sure you want to Log Out"),
            content: Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Go Back"),
                ),
                TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    await SharedPrefUtils.clearPrefStr("initScreen");
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OnBoardingScreen()),
                        (route) => false);
                  },
                  child: const Text("Log Out"),
                ),
              ],
            ),
          );
        },
      );
    }

    /// Profile-selection List
    List<ProfileModel> profileSectionList = [
      ProfileModel(
        priIcon: Icons.card_travel,
        title: "Order",
        screenName: const OrderScreen(),
      ),
      ProfileModel(
        priIcon: Icons.account_box,
        title: "My Details",
        screenName: const MyDetailsScreen(),
      ),
      ProfileModel(
        priIcon: Icons.credit_card,
        title: "Payment Methods",
        screenName: Container(),
      ),
      ProfileModel(
        priIcon: Icons.location_on_outlined,
        title: "Delivery Address",
        screenName: Container(),
      ),
      ProfileModel(
        priIcon: Icons.qr_code_scanner,
        title: "Promo Cards",
        screenName: Container(),
      ),
      ProfileModel(
        priIcon: Icons.notification_important_outlined,
        title: "Notifications",
        screenName: Container(),
      ),
      ProfileModel(
        priIcon: Icons.help_outline,
        title: "Helps",
        screenName: Container(),
      ),
      ProfileModel(
        priIcon: Icons.contact_mail_rounded,
        title: "Contact Us",
        screenName: const ContactUs(),
      ),
      ProfileModel(
        priIcon: Icons.logout,
        title: "Log Out",
        screenName: Container(),
      ),
    ];

    /// AppBar
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      /// Scaffold Column
      body: Column(
        children: [
          const CircleAvatar(
            radius: 30,
            child: Icon(
              Icons.account_circle,
              size: 60,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Nilesh Tanchak",
            style: Constant.kOnBoardHeaderTextStyle,
          ),
          const SizedBox(
            height: 10,
          ),

          /// Profile ListView Separator
          Expanded(
            child: ListView.separated(
              itemCount: profileSectionList.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemBuilder: (_, index) {
                return ListTile(
                  onTap: () {
                    if (profileSectionList[index].title == "Log Out") {
                      dialog();
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                profileSectionList[index].screenName!),
                      );
                    }
                  },
                  leading: Icon(
                    profileSectionList[index].priIcon,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    profileSectionList[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    profileSectionList[index].trailingIcon,
                    size: 15,
                    color: Colors.black,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
