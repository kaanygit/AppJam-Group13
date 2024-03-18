import 'package:GezginAt/database/firebase.dart';
import 'package:GezginAt/screens/authscreen.dart';
import 'package:GezginAt/widgets/fonts.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseOperations _firestoreMethods = FirebaseOperations();

  Map<String, dynamic> userProfile = {};
  bool loadingProfile = true;
  bool editingScreen = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeUserProfile();
  }

  @override
  void dispose() {
    nameController.dispose();
    educationController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _initializeUserProfile() async {
    Map<String, dynamic> user = await _firestoreMethods.getProfileBio();
    setState(() {
      userProfile = user;
      loadingProfile = false;
      nameController.text = userProfile['displayName'] ?? '';
      educationController.text = userProfile['educationLevel'] ?? '';
      addressController.text = userProfile['address'] ?? '';
      phoneNumberController.text = userProfile['phoneNumber'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !loadingProfile &&
                      userProfile['profilePhoto'] != "" &&
                      userProfile['profilePhoto'] != null
                  ? Container(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(userProfile['profilePhoto']),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage("assets/images/placeholder.png"),
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Personal Information",
                        style: fontStyle(20, Colors.black, FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Name",
                            style: fontStyle(
                                17, Colors.grey.shade800, FontWeight.normal)),
                        !editingScreen
                            ? Text(
                                !loadingProfile &&
                                        userProfile['displayName'] != null
                                    ? userProfile['displayName']
                                    : "Null",
                                style: fontStyle(
                                    17, Colors.black, FontWeight.bold),
                              )
                            : Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 90.0),
                                  child: TextField(
                                    controller: nameController,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Education Level",
                            style: fontStyle(
                                17, Colors.grey.shade800, FontWeight.normal)),
                        !editingScreen
                            ? Text(
                                !loadingProfile &&
                                        userProfile['educationLevel'] != null
                                    ? userProfile['educationLevel']
                                    : "Null",
                                style: fontStyle(
                                    17, Colors.black, FontWeight.bold),
                              )
                            : Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: TextField(
                                    controller: educationController,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Address",
                          style: fontStyle(
                              17, Colors.grey.shade800, FontWeight.normal),
                        ),
                        !editingScreen
                            ? Text(
                                !loadingProfile &&
                                        userProfile['address'] != null
                                    ? userProfile['address']
                                    : "Null",
                                style: fontStyle(
                                    17, Colors.black, FontWeight.bold),
                              )
                            : Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 75.0),
                                  child: TextField(
                                    controller: addressController,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Contact Information",
                        style: fontStyle(20, Colors.black, FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Phone",
                            style: fontStyle(
                                17, Colors.grey.shade800, FontWeight.normal)),
                        !editingScreen
                            ? Text(
                                !loadingProfile &&
                                        userProfile['phoneNumber'] != null
                                    ? userProfile['phoneNumber']
                                    : "Null",
                                style: fontStyle(
                                    17, Colors.black, FontWeight.bold),
                              )
                            : Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: TextField(
                                    controller: phoneNumberController,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("E-Mail",
                            style: fontStyle(
                                17, Colors.grey.shade800, FontWeight.normal)),
                        Text(
                            !loadingProfile && userProfile['email'] != null
                                ? /*userProfile['email']*/ "test@test.com"
                                : "Null",
                            style:
                                fontStyle(17, Colors.black, FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          if (editingScreen) {
                            _saveProfileChanges();
                          }
                          setState(() {
                            editingScreen = !editingScreen;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: Text(
                          editingScreen ? "Save" : "Edit",
                          style: fontStyle(17, Colors.white, FontWeight.normal),
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          print("Signing Out");
                          FirebaseOperations().signOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AuthScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: Text(
                          "Sign Out",
                          style: fontStyle(17, Colors.white, FontWeight.normal),
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          print("Deleting Account");
                          await FirebaseOperations().deleteAccount();
                          FirebaseOperations().signOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AuthScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: Text(
                          "Delete Account",
                          style: fontStyle(17, Colors.white, FontWeight.normal),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProfileChanges() {
    FirebaseOperations().setEditProfileBio(
      addressController.text,
      nameController.text,
      educationController.text,
      phoneNumberController.text,
    );
    _initializeUserProfile(); // Reload updated data
  }
}
