import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.dart';

class SettingsState {
  final RxBool isDarkMode = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isUpdateLoading = false.obs;

  RxString selectedLang = 'tm'.obs;

  Rxn<User> user = Rxn<User>();

  LoginStatusController loginStatusController = Get.put(LoginStatusController());

  final profileForm = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController pwdCtrl = TextEditingController();


  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode pwdFocus = FocusNode();

  RxBool obscureText = true.obs;
  Rx<IconData> visibilityIcon = Icons.visibility_off.obs;
}
