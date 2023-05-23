import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.dart';

void navigateToLoginScreen() {
  debugPrint('navigateToLoginScreen');
  Get.offNamedUntil('/', (route) => false);

  final DashboardController dashboardController = Get.put(DashboardController());
  dashboardController.changeTabIndex(4);
}
