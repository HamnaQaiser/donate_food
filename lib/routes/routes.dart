


import 'package:flutter/material.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/views/add_post.dart';
import 'package:food_donation_app/views/boarding_screen.dart';
import 'package:food_donation_app/views/emailValidation.dart';
import 'package:food_donation_app/views/dashboard.dart';
import 'package:food_donation_app/views/login.dart';
import 'package:food_donation_app/views/register.dart';
import 'package:food_donation_app/views/screens/chat/restaurant_chat.dart';
import 'package:food_donation_app/views/screens/chat/UsersListScreen.dart';
import 'package:food_donation_app/views/screens/donation/DonationScreen.dart';
import 'package:food_donation_app/views/screens/map/MapScreen.dart';
import 'package:food_donation_app/views/screens/profile/ProfileScreen.dart';
import 'package:food_donation_app/views/screens/donation/addDonation.dart';
import 'package:food_donation_app/views/splash_screen.dart';
import 'package:food_donation_app/views/welcome_screen.dart';

import '../views/ngo_dashboard/ngo_dashboard.dart';

class Routes {
  final String name;
  final String receiverId;
  Routes(this.name, this.receiverId);
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (_) =>  LoginScreen());
      case RouteName.registerScreen:
        return MaterialPageRoute(builder: (_) =>  RegisterScreen());
      case RouteName.welcomScreen:
        return MaterialPageRoute(builder: (_) =>  WelcomeScreen());
      case RouteName.boardingScreen:
        return MaterialPageRoute(builder: (_) =>  BoardingScreen());
      case RouteName.dashboard:
        return MaterialPageRoute(builder: (_)=>  DashboardScreen());
      case RouteName.chatScreen:
        return MaterialPageRoute(builder: (_)=>  RestaurantChatScreen());
      case RouteName.mapScreen:
        return MaterialPageRoute(builder: (_)=>  MapScreen());
      case RouteName.donationScreen:
        return MaterialPageRoute(builder: (_)=>  DonationScreen());
      case RouteName.profileScreen:
        return MaterialPageRoute(builder: (_)=>  ProfileScreen());
      case RouteName.validationScreen:
        return MaterialPageRoute(builder: (_)=>  ValidationScreen());
      case RouteName.addDonation:
        return MaterialPageRoute(builder: (_)=>  AddDonation());
      case RouteName.createChat:
        return MaterialPageRoute(builder: (_)=>  CreateChat());
      case RouteName.ngoDashboard:
        return MaterialPageRoute(builder: (_)=> NGODashboardScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}

Map<String , WidgetBuilder> routes={
  "/" : (context) => DashboardScreen(),
  "/splashScreen" : (context) => SplashScreen(),
  "/login" : (context) => LoginScreen(),
  "/signup" : (context) => RegisterScreen(),
  "/boarding" : (context) => BoardingScreen(),
  "/welcome" : (context) => WelcomeScreen(),

};