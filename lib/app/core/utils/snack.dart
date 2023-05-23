import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.dart';

void showSnack(String title, message, [SnackType snackType = SnackType.info, int duration = 1]) {
  Get.snackbar(
    title,
    message,
    duration: Duration(seconds: duration),
    snackPosition: SnackPosition.BOTTOM,
    colorText: ThemeColor.white,
    backgroundColor: _getSnackBgColor(snackType),
    margin: const EdgeInsets.all(16),
  );
}

Color _getSnackBgColor(SnackType snackType) {
  if (snackType.index == 1) {
    return Colors.amber.shade600;
  }
  if (snackType.index == 2) {
    return Colors.red.shade700;
  }

  return Colors.green.shade600;
}
