import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterState {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController pwdCtrl = TextEditingController();
  TextEditingController pwdRptCtrl = TextEditingController();

  RxBool obscureText = true.obs;
  Rx<IconData> visibilityIcon = Icons.visibility_off.obs;

  RxBool isLoading = false.obs;
}
