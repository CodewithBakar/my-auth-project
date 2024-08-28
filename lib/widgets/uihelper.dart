import 'package:flutter/material.dart';

class Uihelper {
  // Method for headline bold text style
  static TextStyle headlineBoldStyle() {
    return TextStyle(
      fontSize: 20.0,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
  }

  // Method for a custom text field
  static Widget customTextField({
    required String hintText,
    required TextEditingController controller,
    bool obscureText = false,
    IconData? prefixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none
            ),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          ),
        ),
      ),
    );
  }

  // Method for a custom button
  static Widget customButton({
    required String text,
    required VoidCallback onPressed,
    Color color = Colors.blue,
    double borderRadius = 10.0,
    double padding = 15.0,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.all(padding),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );
  }
}
