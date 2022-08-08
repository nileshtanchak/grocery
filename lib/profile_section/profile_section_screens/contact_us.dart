import 'package:flutter/material.dart';
import 'package:on_boarding/profile_section/models/contact_us_model.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ContactUsModel> contactList = [
      ContactUsModel(icons: Icons.mail, title: "nileshtanchak00@gmail.com"),
      ContactUsModel(icons: Icons.phone, title: "+91 8140141579"),
      ContactUsModel(icons: Icons.facebook, title: "nileshtanchak@ymail.com"),
      ContactUsModel(
          icons: Icons.location_on_outlined,
          title: "B-404, Shrinathji Residency, Variyav, Surat-395006"),
    ];
    return Scaffold(
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
          "Contact Us",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.all(16),
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return ListTile(
                  leading: Icon(contactList[index].icons, color: Colors.green),
                  title: Text(
                    contactList[index].title,
                    maxLines: 2,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
              separatorBuilder: (_, index) {
                return const Divider();
              },
              itemCount: contactList.length),
        ),
      ),
    );
  }
}
