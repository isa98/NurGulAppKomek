import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: ThemeColor.darkMainColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: ThemeColor.darkMainColorGreen,
    secondary: ThemeColor.darkMainColorGreenSecondary,
    brightness: Brightness.dark,
    background: ThemeColor.darkMainColorLight,
    tertiary: ThemeColor.white,
  ),
  scaffoldBackgroundColor: ThemeColor.darkBgColor,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    unselectedItemColor: Colors.white,
    selectedItemColor: ThemeColor.darkMainColorGreen,
    elevation: 0,
  ),
  highlightColor: Colors.transparent,
  splashColor: ThemeColor.darkSplashColor,
  textTheme: TextTheme(
    labelMedium: const TextStyle(
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.sp,
      color: ThemeColor.white,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16.sp,
      color: ThemeColor.white,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 13.sp,
      color: ThemeColor.white,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: ThemeColor.darkMainColor,
    elevation: 0,
    titleTextStyle: TextStyle(color: ThemeColor.white, fontSize: 18.sp),
  ),
  listTileTheme: const ListTileThemeData(),
  // cardTheme: const CardTheme(color: ThemeColor.darkMainColor),
);
