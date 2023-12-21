import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/constants.dart';
class MessageField extends StatelessWidget {
   MessageField({super.key, required this.label, required this.controller});
   TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  IconData? icon;
  final String label;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,

      cursorColor: mainColor,

      decoration: InputDecoration(

        fillColor: Colors.grey.shade200,
        prefixIcon: Icon(
            icon
        ),
        hintStyle: paragraph,
        hintText: label,
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
