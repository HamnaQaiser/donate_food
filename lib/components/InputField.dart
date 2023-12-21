

import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/constants.dart';

class InputField extends StatelessWidget {
  InputField({
    required this.controller,
    required this.keyboardType,
    required this.validator,
    required this.focusNode,
    this.icon,
    required this.label,
    this.obscure = false,
    Key? key,
  }) : super(key: key);

  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
   IconData? icon;
  final String label;
  final bool obscure;
  final FormFieldValidator validator;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      focusNode: focusNode,
      obscureText: obscure,
      cursorColor: mainColor,
      validator: validator,

      decoration: InputDecoration(

        fillColor: Colors.grey.shade200,
        prefixIcon: Icon(
         icon
        ),
        hintStyle: paragraph,
        label: Text(label),
        labelStyle: paragraph.copyWith(color: mainColor),
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
