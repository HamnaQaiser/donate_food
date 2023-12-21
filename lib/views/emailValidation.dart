import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/controller/Session_manager.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';

class ValidationScreen extends StatefulWidget {
  const ValidationScreen({super.key});

  @override
  State<ValidationScreen> createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  final auth = FirebaseAuth.instance;
  final dbRef = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  bool verification = false;
  Future<void> checkValidation() async {
    final val =await auth.currentUser!.emailVerified;
    setState(() {
      verification = val;

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    checkValidation()  ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.mail,
              size: 80,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Verify your email address',
              style: Heading2.copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'We have just send email verification link on your email. Please check email and click that link to verify your Email address.',
              style: paragraph,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'If not auto redirected after validation, click on the Continue button.',
              style: paragraph,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            GradientButton(
                label: 'Continue',
                onPress: () {
                  final message = SnackBar(
                      content: Text('Email not verified!. Please try again'));
                  print(verification);
                  if(verification == true){
                    dbRef.update({
                      'isVerified': 'Verified'
                    }).then((value) {
                      Navigator.pushNamed(context, RouteName.dashboard);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User Created Successfully')));
                    }).onError((error, stackTrace){
                      ScaffoldMessenger.of(context).showSnackBar(message);
                    });
                  }
                  // checkValidation().then((value) {
                  //   dbRef.update({'isVerified': 'Verified'});
                  //   Navigator.pushNamed(context, RouteName.homeScreen);
                  // }).onError((error, stackTrace) {
                  //   ScaffoldMessenger.of(context).showSnackBar(message);
                  // });
                },
                loading: false),
            SizedBox(
              height: 60,
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Resend E-mail link',
                  style: paragraph.copyWith(
                    color: mainColor,
                  ),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.loginScreen);
                },
                child: Text(
                  '<- back to Login',
                  style: paragraph.copyWith(
                    color: mainColor,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
