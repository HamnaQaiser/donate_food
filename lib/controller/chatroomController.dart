import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class ChatRoomController extends ChangeNotifier{


  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore dbRef = FirebaseFirestore.instance;


 Future sendMessaga( String sender, String receiver, message) async {
   String chatRoomId = '${sender}_${receiver}';

   dbRef.collection("chat_room").doc(chatRoomId).collection('messages').add(
       {
         "sender": sender,
         "receiver": receiver,
         "time": Timestamp.now(),
         "message": message
       });


 }


}