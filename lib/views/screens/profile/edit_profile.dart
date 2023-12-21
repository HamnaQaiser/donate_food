import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/components/donationField.dart';
import 'package:food_donation_app/controller/Session_manager.dart';
import 'package:food_donation_app/controller/profile_controller.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final String name, email, phone, address, image;
  const EditProfile(
      {super.key,
      required this.name,
      required this.email,
      required this.phone,
      required this.address,
      required this.image});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  final nameNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  final emailNode = FocusNode();

  TextEditingController phoneController = TextEditingController();
  final phoneNode = FocusNode();

  TextEditingController addressController = TextEditingController();
  final addressNode = FocusNode();

  final dbref = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.name;
    emailController.text = widget.email;
    phoneController.text = widget.phone;
    addressController.text = widget.address;

    final provider = Provider.of<ProfileProvider>(context, listen: true);
    File? _selectedImage;
    final auth = FirebaseAuth.instance;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: mainColor,
        title: Text(
          'Edit Profile',
          style: paragraph.copyWith(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade100),
                          child: provider.image == null ? widget.image == ''
                              ? Icon(Icons.person, size: 48,color: mainColor,)
                              : Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(widget.image),fit: BoxFit.cover)),
                          ): Container(height: 120,width: 120,decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: FileImage(File(provider.image!.path)),fit: BoxFit.cover),),)

                      ),
                      Positioned(
                        top: 90,
                        left: 80,
                        child: GestureDetector(
                          onTap: () {
                            provider.pickImage(context);
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: mainColor,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.grey.shade100)),
                            child: Icon(
                              Icons.add,
                              color: Colors.grey.shade100,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: 'Update Name',
                          hintStyle: paragraph,
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: 'Update Email',
                          hintStyle: paragraph,
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          hintText: 'Update Phone',
                          hintStyle: paragraph,
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                          hintText: 'Update Address',
                          hintStyle: paragraph,
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GradientButton(
                  label: 'Update',
                  onPress: () {
                    provider.uploadImage(context);
                   provider.updateUser(nameController.text, emailController.text, phoneController.text, addressController.text)
                 ; },
                  loading: provider.Loading),
            ),
          ],
        ),
      ),
    );
  }
}
