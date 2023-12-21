import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_donation_app/controller/LocationManager.dart';
import 'package:food_donation_app/controller/Role_manager.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/add_post.dart';
import 'package:food_donation_app/views/ngo_dashboard/ngo_chat.dart';
import 'package:food_donation_app/views/ngo_dashboard/registered_restaurants.dart';
import 'package:food_donation_app/views/screens/chat/restaurant_chat.dart';
import 'package:food_donation_app/views/screens/donation/DonationScreen.dart';
import 'package:food_donation_app/views/screens/Profile/ProfileScreen.dart';
import 'package:food_donation_app/views/screens/home/HomeScreen.dart';
import 'package:food_donation_app/views/screens/map/MapScreen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NGODashboardScreen extends StatefulWidget {
  const NGODashboardScreen({Key? key}) : super(key: key);

  @override
  State<NGODashboardScreen> createState() => _NGODashboardScreenState();
}

class _NGODashboardScreenState extends State<NGODashboardScreen> {


  void getCred(){
    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {

      setState(() {
        RoleController().role = value['role'];
        LocationManager().local = value['address'];
      });
    });

  }

  final List<Widget> _list = [
    NGOHomeScreen(),
    MapScreen(),
    DonationScreen(),
    NGOChatScreen(),
    ProfileScreen(),
  ];

  int _selectedIndex = 0;






  @override
  void initState() {
    // TODO: implement initState
    getCred();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },

      child: Scaffold(

        body: _list.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18 ),
          decoration: BoxDecoration(

            color: mainColor,
          ),
          child: GNav(
            gap: width * 0.01,
            tabBackgroundColor: Colors.white,
            // tabBackgroundGradient:
            //     LinearGradient(colors: [mainColor, secondaryColor]),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.white,
            activeColor: mainColor,

            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
                textStyle:
                paragraph.copyWith(color: mainColor, fontSize: 16),
              ),
              GButton(
                icon: Icons.map,
                text: 'Map',
                textStyle:
                paragraph.copyWith(color: mainColor, fontSize: 16),
              ),
              GButton(
                icon: Icons.dataset,
                text: 'Donations',
                textStyle:
                paragraph.copyWith(color: mainColor, fontSize: 16),
              ),
              GButton(
                icon: Icons.message,
                text: 'Message',
                textStyle:
                paragraph.copyWith(color: mainColor, fontSize: 16),
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
                textStyle:
                paragraph.copyWith(color:mainColor, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
