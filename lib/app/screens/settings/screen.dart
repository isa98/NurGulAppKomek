import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.dart';
import 'controller.dart';
import 'widgets/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings_title'.tr.toUpperCase()),
      ),
      body: GetX<SettingsController>(
        init: SettingsController(),
        builder: (sc) => sc.state.loginStatusController.loginStatus ? const ProfileWidget() : const LoginWidget(),
      ),

      //ProfileLoginWidget(),
    );
  }
}
