import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF8A2BE2);
  static const Color secondary = Color(0xFF4B0082);
  static const Color background = Color(0xFFF5F5F5);
  static const Color text = Color(0xFF333333);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color red = Colors.red;
  static const Color green = Colors.green;

  static const Color skyBlue = Color(0xFF00BFFF);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
