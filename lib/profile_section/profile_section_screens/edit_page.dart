import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_text_field.dart';
import '../Provider/profile_provider.dart';
import '../models/profile_details.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController numberController;
  String name = "";
  String email = "";
  String address = "";
  String number = "";
  String image = "";
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    numberController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    numberController.dispose();
  }

  addProfile() {
    ProfileDetails profileDetails = ProfileDetails(
        name: name, address: address, number: number, image: image);
    context.read<ProfileProvider>().profileDetailsAdd(profileDetails);
  }

  updateProfile() {
    ProfileDetails profileDetails = ProfileDetails(
      id: context.read<ProfileProvider>().profileList.first.id,
      address: address,
      number: number,
      image: image,
    );
    context.read<ProfileProvider>().updateProfileData(profileDetails);
  }

  @override
  Widget build(BuildContext context) {
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
          "Add Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      /// bottom Navigation bar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 20),
            ),
          ),
          onPressed: () async {
            if (name.isNotEmpty || number.isNotEmpty || address.isNotEmpty) {
              await firebaseFirestore.collection("User").get().then(
                    (snapshot) => {
                      if (snapshot.size != 0)
                        {
                          updateProfile(),
                        }
                      else
                        {
                          addProfile(),
                        }
                    },
                  );
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
            }
          },
          child: const Text("Add Details"),
        ),
      ),

      /// body of Scaffold
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image picker of User
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 30),
                child: Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        child: Icon(
                          Icons.account_circle,
                          size: 80,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            withData: true,
                          );
                          if (result != null) {
                            File file = File(result.files.single.path!);
                            print(file.path);
                            Image.file(file);
                            // CircleAvatar(
                            //   child: Image.file(file),
                            // );
                          } else {
                            // User canceled the picker
                          }
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.edit_outlined,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// TextField of User
              Row(
                children: const [
                  Text("Enter Your Name"),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              CustomTextField(
                controller: nameController,
                filled: true,
                filledColor: Colors.green.shade100,
                border: InputBorder.none,
                hintText: "Name",
                obscureText: false,
                onChange: (value) {
                  name = value;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: const [
                  Text("Enter Your Email"),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              CustomTextField(
                controller: emailController,
                filled: true,
                filledColor: Colors.green.shade100,
                border: InputBorder.none,
                hintText: "Email",
                obscureText: false,
                onChange: (value) {
                  email = value;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: const [
                  Text("Enter Your Address"),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              CustomTextField(
                controller: addressController,
                filled: true,
                filledColor: Colors.green.shade100,
                border: InputBorder.none,
                hintText: "Address",
                obscureText: false,
                onChange: (value) {
                  address = value;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: const [
                  Text("Enter Your Number"),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              CustomTextField(
                controller: numberController,
                filled: true,
                filledColor: Colors.green.shade100,
                border: InputBorder.none,
                hintText: "Number",
                obscureText: false,
                onChange: (value) {
                  number = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
