import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? ThemeColor.darkMainColorLight : ThemeColor.white,
      appBar: AppBar(
        leading: const BackButton(color: ThemeColor.white),
        title: Text('reg_register'.tr.toUpperCase()),
      ),
      body: GetX<RegisterController>(
        init: RegisterController(),
        builder: (rc) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: rc.state.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text('reg_register_short'.tr,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text('reg_register_desc'.tr,
                      style: TextStyle(fontSize: 14.sp)),
                  const SizedBox(height: 16),
                  Text('reg_form_name'.tr,
                      style: StyleConstants.formHeaderStyle),
                  StyleConstants.formSpacer,
                  MyTextFormField(
                    label: 'reg_form_name'.tr,
                    hintText: 'Aman Amanow',
                    inputType: TextInputType.text,
                    controller: rc.state.nameCtrl,
                    focusNode: FocusNode(),
                  ),
                  const SizedBox(height: 20),
                  Text('reg_form_phone'.tr,
                      style: StyleConstants.formHeaderStyle),
                  StyleConstants.formSpacer,
                  MyTextFormField(
                    label: 'phone'.tr,
                    isPhone: true,
                    focusNode: FocusNode(),
                    prefix: Padding(
                      padding: EdgeInsets.fromLTRB(12, 14.sp, 0, 0),
                      child: Text(
                        '+993 ',
                        style: TextStyle(
                          color: ThemeColor.formBorderColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    hintText: '6x xxxxxx',
                    inputType: TextInputType.number,
                    inputFormatters: [maskFormatterPhone],
                    controller: rc.state.phoneCtrl,
                  ),
                  const SizedBox(height: 20),
                  Text('reg_form_pwd'.tr,
                      style: StyleConstants.formHeaderStyle),
                  StyleConstants.formSpacer,
                  MyTextFormField(
                    label: 'reg_form_pwd_new'.tr,
                    controller: rc.state.pwdCtrl,
                    focusNode: FocusNode(),
                    suffix: InkWell(
                      onTap: rc.onVisibilityChange,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Icon(
                          rc.state.visibilityIcon.value,
                          color: ThemeColor.formBorderColor,
                        ),
                      ),
                    ),
                    obscureText: rc.state.obscureText.value,
                  ),
                  StyleConstants.formSpacer,
                  StyleConstants.formSpacer,
                  MyTextFormField(
                    label: 'reg_form_pwd_new_rpt'.tr,
                    controller: rc.state.pwdRptCtrl,
                    focusNode: FocusNode(),
                    suffix: InkWell(
                      onTap: rc.onVisibilityChange,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Icon(
                          rc.state.visibilityIcon.value,
                          color: ThemeColor.formBorderColor,
                        ),
                      ),
                    ),
                    obscureText: rc.state.obscureText.value,
                  ),
                  const SizedBox(height: 32),
                  rc.state.isLoading.value
                      ? CustomLoader(height: 48.h, width: 48.w)
                      : ButtonWidthFull(
                          callback: rc.onRegisterTapped,
                          title: 'reg_register_short'.tr),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
