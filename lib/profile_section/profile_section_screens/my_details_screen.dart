import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:on_boarding/profile_section/Provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../models/profile_details.dart';
import 'edit_page.dart';

class MyDetailsScreen extends StatefulWidget {
  const MyDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MyDetailsScreen> createState() => _MyDetailsScreenState();
}

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  late TextEditingController editAddressController;

  @override
  initState() {
    super.initState();
    editAddressController = TextEditingController();
    context.read<ProfileProvider>().fetchProfileDetailsOfLoggedInUser();
    context.read<ProfileProvider>().fetchProfileDetailsOfLoggedInUserInFuture();
  }

  @override
  dispose() {
    super.dispose();
    editAddressController.dispose();
  }

  // void getProfileUserList() {
  //   userProfileDetails = context.read<ProfileProvider>().profileList;
  // }

  // Future<Widget> popUpDialog() async {
  //   return await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text("Add Address"),
  //           content: CustomTextField(
  //             hintText: 'edit Address',
  //             obscureText: false,
  //             controller: editAddressController,
  //           ),
  //           actions: [
  //             ElevatedButton(
  //                 onPressed: () {}, child: const Text("Edit Address"))
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    /// AppBar
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
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditPage(),
                    ),
                  );
                },
                child: const Text(
                  "Edit",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          )
        ],
      ),

      /// Scaffold Column Start
      body: SafeArea(
        child: Consumer<ProfileProvider>(
          builder: (_, provider, __) {
            return FutureBuilder(
              future: provider.futureProfileList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProfileDetails>> snapshot) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.profileList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 60,
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
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data?[index].name ?? "",
                          style: Constant.kOnBoardHeaderTextStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        ///Profile Details
                        Container(
                          width: double.infinity,
                          // height: 200,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 36),
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
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              Text(provider.checkCurrentUser()),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Address",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              Text(snapshot.data?[index].address ?? ""),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Number",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              Text(snapshot.data?[index].number ?? ""),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 36),
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
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Address",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const EditPage(),
                                        ),
                                      );
                                    },
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
                              ListTile(
                                leading: Icon(
                                  Icons.location_on_outlined,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title:
                                    Text(snapshot.data?[index].address ?? ""),
                                // title: Text(widget.address),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
