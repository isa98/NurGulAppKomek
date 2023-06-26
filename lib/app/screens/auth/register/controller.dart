import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app.dart';
import 'state.dart';

class RegisterController extends GetxController {
  final state = RegisterState();

  @override
  void onClose() {
    state.nameCtrl.dispose();
    state.phoneCtrl.dispose();
    state.pwdCtrl.dispose();
    state.pwdRptCtrl.dispose();

    state.nameFocus.dispose();
    state.phoneFocus.dispose();
    state.pwdFocus.dispose();
    state.pwdRptFocus.dispose();

    super.onClose();
  }

  void onVisibilityChange() {
    state.obscureText.value = !state.obscureText.value;
    state.visibilityIcon.value =
        state.obscureText.value ? Icons.visibility_off : Icons.visibility;
  }

  Future<void> onRegisterTapped() async {
    debugPrint('onRegisterTapped');
    FocusManager.instance.primaryFocus?.unfocus();

    if (state.formKey.currentState!.validate()) {
      if (!checkPasswordEquality()) {
        showSnack('general_warning'.tr, 'validation_password_not_match'.tr,
            SnackType.warning, 3);
        return;
      }

      state.isLoading.value = true;

      final maskedPhoneNumber = state.phoneCtrl.value.text;
      final phone = maskedPhoneNumber.replaceAll(RegExp(r'\D+'), '');

      final Map<String, dynamic> params = {
        'first_name': state.nameCtrl.text.trim(),
        'last_name': '-',
        'phone': phone,
        'password': state.pwdCtrl.text.trim(),
        'gender': 'Male',
        'device_name': await getDeviceName(),
      };

      final result = await AuthApi.register(params);
      if (result) {
        // clear form
        state.formKey.currentState?.reset();

        // set login status
        await setLoginStatus(true);

        // navigate to settings screen
        Get.offAllNamed(AppRoutes.dashboard);
        // set settings page
        DashboardController dc = Get.put(DashboardController());
        dc.changeTabIndex(4);
      }

      state.isLoading.value = false;
    }
  }

  bool checkPasswordEquality() =>
      state.pwdCtrl.text.trim() == state.pwdRptCtrl.text.trim();
}
