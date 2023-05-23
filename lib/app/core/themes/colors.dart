import 'package:flutter/material.dart';

class ThemeColor {
  // primary colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Colors.grey;
  // app main colors
  static const Color mainColor = Color(0xFFCC1055);
  static const Color mainColorMid = Color(0xFFFFB4CF);
  static const Color mainColorLight = Color(0xFFFFEDF4);
  static const Color lightTextColor = Color(0xFF1F2024);
  static const Color mainBgColor = Color(0xFFF7F7F7); // Color(0xFFFFFFFF); //
  // static const Color productCardBtn = Color(0xFFFFB2CF);

  static Color lightSplashColor = Colors.grey.shade200;
  static const Color darkSplashColor = Color(0xFF2A4338);

  // app dark theme colors
  static const Color darkMainColor = Color(0xFF050505);
  static const Color darkMainColorLight = Color(0xFF1E1E1E);
  static const Color darkMainColorGreen = Color(0xFF06C876);
  static const Color darkMainColorGreenSecondary = Color(0xFF2A4338);
  static const Color darkBgColor = Color(0xFF141D19);

  // common
  static const Color dividerColor = Color(0xFFD4D6DD);
  static const Color formBorderColor = Color(0xFF8F9098);
  static const Color darkPriceColor = Color(0xFFFF5100);
  static const Color discountPriceColor = Color(0xFFA7ADB7);

  //background: #A7ADB7;

  static const MaterialColor mainTheme = MaterialColor(
    0xFFCC1055,
    <int, Color>{
      50: Color(0xFFFFB4CF),
      100: Color(0xFFFFB4CF),
      200: Color(0xFFFFB4CF),
      300: Color(0xFFFFB4CF),
      400: Color(0xFFFFB4CF),
      500: Color(0xFFFFEDF4),
      600: Color(0xFFFFEDF4),
      700: Color(0xFFFFEDF4),
      800: Color(0xFFFFEDF4),
      900: Color(0xFFFFEDF4),
    },
  );
}
