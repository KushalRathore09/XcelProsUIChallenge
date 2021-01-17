import 'package:flutter/material.dart';

class AppColors {
  static const Color darkBlue = Color(0xFF031C23);
  static const Color blue = Color(0xFF0E4FA2);
  static const Color mediumBlue = Color(0xFF06475A);
  static const Color white = Color(0xFFFFFFFF);
  static const Color greenAccent = Color(0xFF37A89B);
  static const Color orange = Color(0xFFFFA93C);
  static const Color yellow = Color(0xFFFED245);

  static const Color lightWhite = Color(0xFFF6F8FB);


  static const Color lightColorRed = Color(0xFFF99A9B);
  static const Color lightColorGreen = Color(0xFF93EA9D);
  static const Color lightColorBlue = Color(0xFF94CAEB);
  static const Color lightColorPurple = Color(0xFFA494EB);
  static const Color lightColorViolet = Color(0xFFDE94EB);
  static const Color lightColorYellow = Color(0xFFEBD094);

}

class AppTextStyles {
  static const TextStyle mainTitleStyle = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.bold,
    height: 1.3,
    fontSize: 25,
  );
  static const TextStyle subtitleStyle = TextStyle(
    color: AppColors.blue,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
}
