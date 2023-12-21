

import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/constants.dart';

class SearchField extends StatelessWidget {
  SearchField({
    required this.controller,
    required this.label,

    Key? key, required this.onTap,
  }) : super(key: key);

  TextEditingController controller = TextEditingController();

  IconData? icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      cursorColor: mainColor,


      decoration: InputDecoration(

        fillColor: Colors.grey.shade100,
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(
              Icons.search,
          color: mainColor,
          ),
        ),
        hintStyle: paragraph.copyWith(color: mainColor),
        hintText: label,
        filled: true,
        contentPadding: EdgeInsets.all(18),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: mainColor, width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red, width: 1)),
      ),
    );
  }
}
