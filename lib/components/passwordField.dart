import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/constants.dart';

class PasswordField extends StatefulWidget {
  PasswordField({
    required this.controller,
    required this.validator,
    required this.focusNode,
    required this.keyboardType,
    required this.label,


    Key? key,
  }) : super(key: key);



  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  final String label;
  final FormFieldValidator validator;
  final TextInputType keyboardType;


  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late bool _showPass = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: _showPass,
      cursorColor: mainColor,

      validator: widget.validator,
      keyboardType: widget.keyboardType,

      decoration: InputDecoration(
// focusColor: mainColor,
        fillColor: Colors.grey.shade200,
        suffixIcon: GestureDetector(
          onTap: (){
setState(() {
  _showPass = !_showPass;

});
          },
            child: Icon( _showPass? Icons.visibility_off: Icons.visibility)),
        prefixIcon: Icon(
          Icons.lock
        ),
        hintStyle: paragraph,
        label: Text(widget.label),
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
