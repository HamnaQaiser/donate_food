import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/controller/Session_manager.dart';
import 'package:food_donation_app/views/ngo_dashboard/chat_screen.dart';

import '../../routes/route_name.dart';
import '../../utility/constants.dart';
class NGOChatScreen extends StatefulWidget {
  const NGOChatScreen({super.key});

  @override
  State<NGOChatScreen> createState() => _NGOChatScreenState();
}

class _NGOChatScreenState extends State<NGOChatScreen> {
  late Stream<QuerySnapshot> restaurantsStream;
  SessionController sessionController = SessionController();
  void initState() {
    // TODO: implement initState
    super.initState();
    restaurantsStream = FirebaseFirestore.instance
        .collection('Users')
        .where('role', isEqualTo: 'Restaurant')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Chat Screen',
          style: paragraph.copyWith(color: mainColor, fontSize: 22),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: restaurantsStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No registered restaurants available'));
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var document = snapshot.data!.docs[index];
                      return RestaurantCard(
                        name: document['name'],
                        email: document['email'],
                        id: document['id'],
                        senderId: sessionController.userId.toString(),
                      );

                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),

    );
  }
}
class RestaurantCard extends StatelessWidget {
  final String name;
  final String email;
  final String id;
  final String senderId;


   RestaurantCard({
    Key? key,
    required this.name,
    required this.email,
    required this.id,
     required this.senderId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 3.0,
      child: ListTile(
        onTap: () => {
          Navigator.push(context,
        MaterialPageRoute(builder: (_)=>
        ChatScreen(senderId: senderId, receiverId: id, Name: name))),
        },
        leading: CircleAvatar(
        ),
        title: Text(name),
        subtitle: Text(email),
      ),
    );
  }
}

