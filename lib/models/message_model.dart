import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderName;
  final  String receiverId;
  final String message;
  final Timestamp timestamp;
  const Message(this.senderId, this.senderName, this.receiverId, this.message, this.timestamp, );


  Map<String, dynamic> toMap(){
    return {
      'senderId':senderId,
      'senderName':senderName,
      'receiverId':receiverId,
      'message':message,
      'Time':timestamp,
    };
  }
}