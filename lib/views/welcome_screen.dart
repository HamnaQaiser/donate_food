import 'package:flutter/material.dart';

import 'package:food_donation_app/components/RoundedButton.dart';
import 'package:food_donation_app/components/SquareButton.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/login.dart';
import 'package:food_donation_app/views/register.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: Heading1,
              ),
              Text(
                'Start your helping journey',
                style: paragraph,
              ),
              SizedBox(
                height: 60,
              ),
              Image.asset(
                'asset/welcome.png',
              ),
              SizedBox(
                height: 80,
              ),
              RoundedButton(
                label: 'Login',
                loading: false,
                bgColor: mainColor,
                onPress: () {
                  Navigator.pushNamed(context, RouteName.loginScreen);
                },
                labelColor: Colors.white,
              ),
              SizedBox(
                height: 18,
              ),
              RoundedButton(
                loading: false,
                label: 'Register',
                bgColor: Colors.grey.shade400,
                onPress: () {
                  // showModalBottomSheet(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return Container(
                  //         padding: EdgeInsets.symmetric(horizontal: 80),
                  //         height: 150,
                  //         width: double.infinity,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             SquareButton(
                  //               image: 'asset/donar.png',
                  //               text: 'Doner',
                  //             ),
                  //             SquareButton(
                  //               image: 'asset/receiver.png',
                  //               text: 'Receiver',
                  //             )
                  //           ],
                  //         ),
                  //       );
                  //     });
                  Navigator.pushNamed(context, RouteName.registerScreen);
                },
                labelColor: Colors.white,
              ),

              ////////////////    Continue with social //////////////////////

              // Text(
              //   "Or Continue with",
              //   style: Heading3.copyWith(
              //
              //       fontSize: 16
              //       ),
              // ),
              //
              //         Container(
              //           height: 50,width: 100,
              //           // color: Colors.red,
              //           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Image.asset('asset/facebook.png'),
              //               Image.asset('asset/google.png'),
              //             ],
              //           ),
              //         )
            ],
          ),
        ),
      ),
    );
  }
}
