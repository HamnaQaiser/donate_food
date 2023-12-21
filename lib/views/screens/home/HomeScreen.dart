import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/components/card.dart';
import 'package:food_donation_app/components/searchField.dart';
import 'package:food_donation_app/controller/LocationManager.dart';
import 'package:food_donation_app/controller/Role_manager.dart';
import 'package:food_donation_app/controller/Session_manager.dart';
import 'package:food_donation_app/controller/notification_services.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/add_post.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final searchController = TextEditingController();
  final searchNode = FocusNode();
  final dbref = FirebaseFirestore.instance.collection("Users");
String  location = 'loading...';
  String profile = 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

  void getUserData()async{
    var ref = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get();

   setState(() {
     location = ref['address'];
     profile  = ref['image'];
   });

  }

  void initState() {
    // TODO: implement initState
getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 1,
              backgroundColor: mainColor,
              title: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ListTile(
                    leading: GestureDetector(
                        child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 32,
                    )),
                    title: Text(
                      LocationManager().local == null
                          ? "Loading..."
                          : location,
                      // location.toString(),
                      style: paragraph.copyWith(
                          fontSize: 12, color: Colors.white, height: 1),
                    ),
                    trailing: CircleAvatar(backgroundImage: NetworkImage(profile),),
                  ))),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InputField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      return null;
                    },
                    focusNode: searchNode,
                    icon: Icons.search,
                    label: 'Search Anything...'),
              ),


              CarouselSlider(
                  items: [
                    Container(
                      color: Colors.grey.shade100,
                      child: Image(
                        image: AssetImage('./././asset/carousal_img_1.jpg'),
                        fit: BoxFit.cover,
                        width: 1000,
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade100,
                      child: Image(
                        image: AssetImage(
                          './././asset/carousal_img_2.jpg',
                        ),
                        fit: BoxFit.cover,
                        width: 1000,
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade100,
                      child: Image(
                        image: AssetImage('./././asset/carousal_img_3.jpg'),
                        fit: BoxFit.cover,
                        width: 1000,
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade100,
                      child: Image(
                        image: AssetImage('./././asset/carousal_img_4.jpg'),
                        fit: BoxFit.cover,
                        width: 1000,
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true)),
              ListTile(
                title: Text(
                  'Recent Donations',
                  style: paragraph.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.donationScreen);
                  },
                  child: Text(
                    'See all',
                    style: paragraph.copyWith(color: mainColor),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('donations')
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData) {
                      return Center(child: Text('Something went wrong'));
                    }
                    if (snapshot.data.docs.isEmpty) {
                      return Center(
                          child: Text(
                        'No active donation available',
                        style: paragraph,
                      ));
                    }
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            if (RoleController().role == 'Restaurant') {
                              if (snapshot.data.docs[index]['id'] ==
                                  FirebaseAuth.instance.currentUser!.uid) {
                                return CardContiner(
                                  item: snapshot.data!.docs[index]['item'],
                                  quantity: snapshot.data!.docs[index]
                                      ['quantity'],
                                  restaurentName: snapshot.data!.docs[index]
                                      ['donated by'],
                                  time: snapshot.data!.docs[index]['prep time'] ==
                                          null
                                      ? ""
                                      : snapshot.data!.docs[index]['prep time'],
                                  address: snapshot.data.docs[index]['location'],
                                  status: snapshot.data.docs[index]['status'], onTap: () {  },
                                );
                              }
                              return Container(
                                  height: 400,
                                  child: Center(
                                    child: Text(
                                      'No active donations found!',
                                      style: paragraph,
                                    ),
                                  ));
                            }
                            return CardContiner(
                              item: snapshot.data!.docs[index]['item'],
                              quantity: snapshot.data!.docs[index]['quantity'],
                              restaurentName: snapshot.data!.docs[index]
                                  ['donated by'],
                              time:
                                  snapshot.data!.docs[index]['prep time'] == null
                                      ? ""
                                      : snapshot.data!.docs[index]['prep time'],
                              address: snapshot.data.docs[index]['location'],
                              status: snapshot.data.docs[index]['status'], onTap: () {  },
                            );
                          }),
                    );
                  },
                ),
              )
            ],
          )),
    );
  }
}
