import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';


Future<void> initLoginStatus() async {
  debugPrint('initLoginStatus');
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final bool status = prefs.getBool(Constants.isLoggedIn) ?? false;

  await setLoginStatus(status);
}

Future<void> setLoginStatus(status) async {
  debugPrint('setLoginStatus $status');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(Constants.isLoggedIn, status);

  LoginStatusController loginStatusController = Get.put(LoginStatusController());

  loginStatusController.loginStatus = status;
}
