import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/controller/Role_manager.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/dashboard.dart';

import 'Session_manager.dart';



class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void Login(BuildContext context, String email, String password) {
    setLoading(true);
    auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      setLoading(false);
      SessionController().userId = value.user!.uid.toString();
      Utils.toastMessage("Login Successfully", Colors.green);
      final User? user = auth.currentUser;
      if (user != null) {
        firestore.collection('Users').doc(user.uid).get().then((docSnapshot) {
          if (docSnapshot.exists) {
            RoleController().role = docSnapshot.data()?['role'];
            if (RoleController().role != null) {
              if (RoleController().role == 'NGO') {
                Navigator.pushNamed(context, RouteName.ngoDashboard);
              }
              else {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()));
              }}}}).catchError((error) {
          Utils.toastMessage('Error getting user document: $error', Colors.red);
        });
      } else {
        Utils.toastMessage('User is not signed in.', Colors.red);
      }
    }).catchError((e) {
      Utils.toastMessage(e.toString(), Colors.red);
    }).whenComplete(() {
      setLoading(false);
    });
  }
}
