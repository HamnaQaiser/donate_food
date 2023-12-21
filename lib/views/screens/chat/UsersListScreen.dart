import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/searchField.dart';
import 'package:food_donation_app/utility/constants.dart';
class CreateChat extends StatefulWidget {
  const CreateChat({super.key});

  @override
  State<CreateChat> createState() => _CreateChatState();
}



class _CreateChatState extends State<CreateChat> {

final searchController = TextEditingController();
  final dbref =FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Chat', style: paragraph.copyWith(color: mainColor, fontSize: 22),),),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SearchField(controller: searchController, label: 'Search', onTap: () {  },),
          ),
          StreamBuilder(
              stream: dbref.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  print('something went wrong');
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var document = snapshot.data!.docs[index];

                          return ListTile(
                            onTap: (){
                            },
                            leading: CircleAvatar(),
                            title: Text(snapshot.data!.docs[index]['name']),
                            subtitle: Text(snapshot.data!.docs[index]['email']),
                          );


                      }),
                );
              })
        ],
      ),
    );
  }
}
