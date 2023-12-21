import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final String address;
  final String pass;

  UserModel(this.name, this.id, this.email, this.phone, this.image,
      this.address, this.pass);

  toJson() {
    return {
      'Name': name,
      'Email': email,
      'Phone': phone,
      'Address': address,
      'image': image,
      'password': pass
    };
  }

  factory UserModel.fromSnapsshot(DocumentSnapshot<Map<String,dynamic>> document) {
    final data = document.data()!;

    return UserModel(data["name"], document['id'], data['email'], data['phone'], data['image'], data['address'], data['pass']);
  }
}
