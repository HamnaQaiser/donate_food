import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static toastMessage(String _message, Color color) {
    Fluttertoast.showToast(
        msg: _message,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
