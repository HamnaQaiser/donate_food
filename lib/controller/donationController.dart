import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/utils.dart';

class DonationController extends ChangeNotifier{
   bool _loading = false;
   bool get  loading => _loading;

   void setLoading(bool value){
     _loading = value;
notifyListeners();
   }
  final auth = FirebaseAuth.instance;
  final dbRef = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!.uid;
  void AddDonation(String item, String quantity, TimeOfDay time, String location) {
setLoading(true);
dbRef.collection('donations').doc(FirebaseAuth.instance.currentUser!.uid).set({
  'donated by': user,
  'prep time': time,
  'item': item,
  'quantity': quantity,
  'location': location


}).then((value){
  setLoading(false);
  Utils.toastMessage("Donation Added", Colors.green);
});


  }


}