import 'dart:typed_data';

import 'package:finalyearproject/screens/utills/edit.dart';
import 'package:finalyearproject/screens/utills/utills.dart';
import 'package:finalyearproject/welcomestuff/readylog.dart';
import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  Uint8List? _image;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    if (auth.currentUser != null) {
      user = auth.currentUser;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Profile'),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              _buildProfileInfo(),
              SizedBox(height: 30),
              _buildListTile(
                icon: Icons.settings,
                text: 'Edit Profile',
                onTap: () {
                  Get.to(const EditPage());
                },
              ),
              _buildListTile(
                icon: Icons.delete,
                text: 'Delete Account',
                onTap: () {
                  // Handle delete account
                },
              ),
              _buildListTile(
                icon: Icons.logout,
                text: 'Sign Out',
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.to(const LoginStuff());
                },
              ),
              SizedBox(height: 20),
              Text('School ID: ${user?.photoURL}'),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProfileImage(),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user?.displayName}',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text('${user?.email}', style: const TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return _image != null
        ? Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(image: MemoryImage(_image!)),
              borderRadius: BorderRadius.circular(200),
              color: Colors.grey,
            ),
          )
        : Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: Colors.grey,
            ),
            child: IconButton(
              onPressed: selectImage,
              icon: const Icon(
                Icons.person,
                size: 80,
              ),
            ),
          );
  }

  Widget _buildListTile(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListTile(
        leading: InkWell(
          onTap: onTap,
          child: Icon(
            icon,
            color: AppColors.mainColor,
          ),
        ),
        title: Text(text),
        trailing: const Icon(Icons.arrow_forward),
      ),
    );
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
}
