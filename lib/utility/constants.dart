import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color mainColor = Color(0xfff15a29);

const Color textColor = Color(0xff939393);
const Color secondaryColor = Color(0xffbe1e2d);

TextStyle Heading1 = GoogleFonts.openSans(
    fontSize: 40, fontWeight: FontWeight.bold, color: mainColor, height: 1);
TextStyle Heading2 = GoogleFonts.openSans(
    fontWeight: FontWeight.w600, color: mainColor, fontSize: 36);
TextStyle Heading3 = GoogleFonts.openSans(
    fontWeight: FontWeight.w500, color: mainColor, fontSize: 16);
TextStyle paragraph = GoogleFonts.openSans(
    fontSize: 16, fontWeight: FontWeight.w400, color: textColor);

const MaterialColor primaryMaterialColor = MaterialColor(
  0xfff15a29,
  <int, Color>{
    50: Color(0xfff15a29),
    100: Color(0xfff15a29),
    200: Color(0xfff15a29),
    300: Color(0xfff15a29),
    400: Color(0xfff15a29),
    500: Color(0xfff15a29),
    600: Color(0xfff15a29),
    700: Color(0xfff15a29),
    800: Color(0xfff15a29),
    900: Color(0xfff15a29),
  },
);
