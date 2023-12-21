import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/controller/Role_manager.dart';
import 'package:food_donation_app/controller/Session_manager.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/dashboard.dart';

class RegisterProvider with ChangeNotifier{

  FirebaseAuth auth  = FirebaseAuth.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final dbRef = FirebaseFirestore.instance.collection('Users');
  void setLoading (bool value){
    _isLoading = value;
    notifyListeners();

  }


  void signup(BuildContext context, String name,String email,String password, String role){
    setLoading(true);
    auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
      setLoading(false);
      // final user =  auth.currentUser
      final id = value.user!.uid.toString();
      // SessionController().userId = auth.currentUser!.uid;

      dbRef.doc(id).set({
        'id': id,
        'role': role,
        'name' : name,
        'email': email,
        'phone' : '',
        'image': '',
        'address': '',
        'pass': password,
        'isVerified': "Not"
      });
      auth.currentUser!.updateDisplayName(name);
      RoleController().role = role;
      if(role == "Restaurant") {
        Navigator.pushNamed(context, RouteName.dashboard);
      }
      else {
         Navigator.pushNamed(context, RouteName.ngoDashboard);
      }


      Utils.toastMessage('User Created Successfully', Colors.green);

    }).onError((error, stackTrace){
      setLoading(false);
      print(error);
      Utils.toastMessage(error.toString(),Colors.red);
    });
  }

}
