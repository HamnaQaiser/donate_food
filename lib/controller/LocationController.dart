import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/utils.dart';

class LocationController extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final dbRef = FirebaseFirestore.instance.collection('Users');
  final makerRef = FirebaseFirestore.instance.collection('markers');

  bool _loading = false;
  bool get Loading => _loading;

  void setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  void UpdateLocation(address, longitude, latitude) {
    setLoading(true);
    dbRef.doc(auth.currentUser!.uid).update({
      'address': address,
      'longitude': longitude,
      'latitude': latitude
    }).then((value) {
      makerRef.doc(auth.currentUser!.uid).set({
        'lat': latitude,
        'long': longitude,
        'place': auth.currentUser!.displayName
      }).then((value){
        setLoading(false);
        Utils.toastMessage('Location Updated', Colors.green);
      }).onError((error, stackTrace){
        Utils.toastMessage(error.toString(), Colors.red);
      });
    }).onError((error, stackTrace){
      Utils.toastMessage(error.toString(), Colors.red);
    });
  }
}
