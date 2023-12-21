import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/RoundedButton.dart';
import 'package:food_donation_app/controller/Session_manager.dart';
import 'package:food_donation_app/controller/profile_controller.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/login.dart';
import 'package:food_donation_app/views/screens/profile/edit_profile.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;

  @override
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context, listen: true);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(auth.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            DocumentSnapshot? data = snapshot.data!;
            Map<String, dynamic> document = data.data() as Map<String, dynamic>;

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return Center(child: Text('Something went wrong..'));
            }

            return ListView(
              children: [
                Container(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile(
                                    name: document['name'],
                                    email: document['email'],
                                    phone: document['phone'],
                                    address: document['address'], image: document['image'],)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          'Edit Profile',
                          style: paragraph,
                          textAlign: TextAlign.right,
                        ),
                      )),
                ),
                Center(
                    child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey.shade100),
                  child: document['image'] == ""
                      ? Icon(Icons.person, size: 48,color: mainColor,)
                      : Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                  image: NetworkImage(
                                document['image'],
                              ))),
                        ),
                )),
                SizedBox(
                  height: 30,
                ),
                ReusableRow(
                    title: 'Name',
                    value: document!['name'],
                    iconData: Icons.person),
                ReusableRow(
                    title: 'Email',
                    value: document!['email'],
                    iconData: Icons.mail),
                ReusableRow(
                    title: 'Phone',
                    value: document!['phone'],
                    iconData: Icons.phone),
                ReusableRow(
                    title: 'Address',
                    value: document!['address'],
                    iconData: Icons.home),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: GradientButton(
                      label: 'Logout',
                      onPress: () {
                        auth.signOut().then((value) {
                          Navigator.pushNamed(context, RouteName.loginScreen);
                        });
                      },
                      loading: false),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;

  const ReusableRow(
      {Key? key,
      required this.title,
      required this.value,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: paragraph,
          ),
          leading: Icon(
            iconData,
            color: mainColor,
          ),
          trailing: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              value,
              style: paragraph,
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Divider(
            color: Colors.grey.shade200,
          ),
        )
      ],
    );
  }
}
