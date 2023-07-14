import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Timer timer;

  @override
  void initState() {
    timer = Timer(const Duration(milliseconds: 1000), () async {
      // final isFirstOpen = await StorageInit.getValue();
      // print(isFirstOpen);
      // if (isFirstOpen) {
      //   Get.offAllNamed(AppRoutes.dashboard);
      // } else {
      //   Get.offAllNamed(AppRoutes.langChooseRoute);
      // }

      Get.offAllNamed(AppRoutes.dashboard);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: ThemeColor.mainColor),
        padding: EdgeInsets.symmetric(
          horizontal: size / 4,
        ),
        child: Center(
          child: Image.asset(
            'assets/logo/dark_mode_logo.png',
            height: 150.0,
            width: 150.0,
          ),
        ),
      ),
    );
  }
}
