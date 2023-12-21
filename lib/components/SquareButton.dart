import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/constants.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({Key? key, required this.image, required this.text})
      : super(key: key);
  final String image, text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 80,
          ),
          Text(
            text,
            style: paragraph,
          )
        ],
      ),
    );
  }
}
