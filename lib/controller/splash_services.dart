import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/controller/Role_manager.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/views/boarding_screen.dart';
import 'package:food_donation_app/views/dashboard.dart';

import 'Session_manager.dart';

class SplashService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  isLogin(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    Timer(Duration(seconds: 3), () async {
      if (user != null) {
        SessionController().userId = user!.uid.toString();
        final userDoc = await firestore.collection('Users').doc(user.uid).get();
        if (userDoc.exists) {
          RoleController().role = userDoc.data()?['role'];
          if (RoleController().role != null) {
            if (RoleController().role == 'NGO') {
              Navigator.pushNamed(context, RouteName.ngoDashboard);
            } else {
              Navigator.pushNamed(context, RouteName.dashboard);
            }
            return;
          }
        }
      }
      Navigator.pushNamed(context, RouteName.boardingScreen);
    });
  }
}




