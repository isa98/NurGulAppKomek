import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginState {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  RxBool isLoading = false.obs;

  RxBool obscureText = true.obs;
  Rx<IconData> visibilityIcon = Icons.visibility_off.obs;
}
