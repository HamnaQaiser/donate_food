import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/constants.dart';

class DonationField extends StatelessWidget {
  DonationField({
    required this.controller,
    required this.keyboardType,
    required this.validator,

       required this.label,

    Key? key,
  }) : super(key: key);

  TextEditingController controller = TextEditingController();


  final String label;

  final FormFieldValidator validator;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,

      cursorColor: mainColor,
      validator: validator,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,

        hintStyle: paragraph,
        label: Text(label),
        labelStyle: paragraph.copyWith(color: mainColor),
        filled: true,

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
