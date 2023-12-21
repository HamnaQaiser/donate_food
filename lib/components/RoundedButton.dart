import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key,
      required this.label,
      required this.bgColor,
      required this.onPress,
      required this.labelColor,
      required this.loading})
      : super(key: key);
  final String label;
  final Color bgColor, labelColor;
  final VoidCallback onPress;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onPress,
      child: Container(
        height: 50,
        // width: 250,
        width: double.infinity,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: loading
                ? CircularProgressIndicator()
                : Text(
                    label,
                    style: GoogleFonts.poppins(
                        color: labelColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  )),
      ),
    );
  }
}
