import 'package:flutter/material.dart';
import 'package:food_donation_app/controller/splash_services.dart';
import 'package:food_donation_app/utility/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService service = SplashService();
  @override
  void initState() {
    service.isLogin(context);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(28.0),
      child: Center(
          child: Image.asset('./asset/logo1.png',)),
    ));
  }
}
