import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app.dart';
import 'state.dart';

class LoginController extends GetxController {
  final state = LoginState();

  @override
  void onClose() {
    state.phoneCtrl.dispose();
    state.passwordCtrl.dispose();

    state.phoneFocus.dispose();
    state.passwordFocus.dispose();
    super.onClose();
  }

  void onVisibilityChange() {
    state.obscureText.value = !state.obscureText.value;
    state.visibilityIcon.value =
        state.obscureText.value ? Icons.visibility_off : Icons.visibility;
  }

  Future<void> onLoginTapped() async {
    debugPrint('onLoginTapped');
    FocusManager.instance.primaryFocus?.unfocus();

    if (state.formKey.currentState!.validate()) {
      state.isLoading.value = true;

      final maskedPhoneNumber = state.phoneCtrl.value.text;
      final phone = maskedPhoneNumber.replaceAll(RegExp(r'\D+'), '');

      final Map<String, dynamic> params = {
        'phone': phone,
        'password': state.passwordCtrl.text.trim(),
        'token': true,
        'device_name': await getDeviceName(),
      };

      final result = await AuthApi.login(params);
      if (result) {
        debugPrint('result $result');
        // clear form
        state.formKey.currentState?.reset();

        // set login status
        await setLoginStatus(true);

        // go to settings screen
        Get.offAllNamed(AppRoutes.dashboard);
        DashboardController dc = Get.put(DashboardController());
        dc.changeTabIndex(4);
      }

      state.isLoading.value = false;
    }
  }
}
