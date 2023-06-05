import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.dart';

class CmsController extends GetxController with StateMixin<Type> {
  RxBool isLoading = false.obs;
  RxString htmlContent = ''.obs;

  @override
  void onInit() {
    debugPrint('CmsController: onInit()');
    getCMS();
    super.onInit();
  }

  Future<void> getCMS() async {
    isLoading.value = true;

    htmlContent.value = await CMSApi.get();

    isLoading.value = false;
  }
}
