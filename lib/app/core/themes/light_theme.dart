import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: ThemeColor.mainColor,
  primaryColorLight: ThemeColor.mainColor,
  primarySwatch: ThemeColor.mainTheme,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: ThemeColor.mainColor,
    secondary: ThemeColor.mainColorMid,
    background: ThemeColor.white,
    tertiary: ThemeColor.black,
  ),
  scaffoldBackgroundColor: ThemeColor.mainBgColor,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.black,
    selectedItemColor: ThemeColor.mainColor,
    elevation: 0,
  ),
  highlightColor: Colors.transparent,
  splashColor: ThemeColor.lightSplashColor,
  appBarTheme: AppBarTheme(
    backgroundColor: ThemeColor.mainColor,
    elevation: 0,
    titleTextStyle: TextStyle(color: ThemeColor.white, fontSize: 18.sp),
  ),
  textTheme: TextTheme(
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.sp,
      color: ThemeColor.black,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16.sp,
      color: ThemeColor.lightTextColor,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 13.sp,
      color: ThemeColor.lightTextColor,
    ),
  ),
  listTileTheme: const ListTileThemeData(),
  dividerColor: ThemeColor.dividerColor,
  // cardTheme: const CardTheme(color: Color(0xFF2596be)),
);
