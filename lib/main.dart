import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/controller/LocationController.dart';
import 'package:food_donation_app/controller/Role_manager.dart';
import 'package:food_donation_app/controller/chatroomController.dart';
import 'package:food_donation_app/controller/donationController.dart';
import 'package:food_donation_app/controller/login_controller.dart';
import 'package:food_donation_app/controller/profile_controller.dart';
import 'package:food_donation_app/controller/register_controller.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/routes/routes.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/add_post.dart';
import 'package:food_donation_app/views/emailValidation.dart';

import 'package:food_donation_app/views/splash_screen.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> LoginProvider()),
      ChangeNotifierProvider(create: (_)=> RegisterProvider()),
      ChangeNotifierProvider(create: (_)=> LocationController()),
      ChangeNotifierProvider(create: (_)=> ProfileProvider()),
      ChangeNotifierProvider(create: (_)=> ChatRoomController()),
      ChangeNotifierProvider(create: (_)=> DonationController()),

      // ChangeNotifierProvider(create: create)

    ],child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Connect',
      theme: ThemeData(
        indicatorColor: mainColor,
        primarySwatch: primaryMaterialColor,
        useMaterial3: true,
      ),
     // home: TestScreen(),
      home: SplashScreen(),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    ),);
  }
}
