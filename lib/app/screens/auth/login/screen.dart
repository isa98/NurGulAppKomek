import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller.dart';

import '../../../app.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: BackButton(color: Get.theme.colorScheme.primary),
      //   backgroundColor: Get.theme.scaffoldBackgroundColor,
      // ),
      body: SingleChildScrollView(
        child: GetX<LoginController>(
          init: LoginController(),
          builder: (lc) => Form(
            key: lc.state.formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      Get.isDarkMode ? 'assets/images/auth_img_dark.png' : 'assets/images/auth_img_light.png',
                      height: 0.40.sh,
                      width: 1.sw,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: Get.mediaQuery.padding.top,
                      // left: 8,
                      child: const BackButton(color: ThemeColor.white),
                    )
                  ],
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'login_welcome'.tr,
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      Text('login_phone'.tr, style: StyleConstants.formHeaderStyle),
                      StyleConstants.formSpacer,
                      MyTextFormField(
                        label: 'phone'.tr,
                        isPhone: true,
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
                        controller: lc.state.phoneCtrl,
                      ),
                      const SizedBox(height: 20),
                      Text('login_password'.tr, style: StyleConstants.formHeaderStyle),
                      StyleConstants.formSpacer,
                      MyTextFormField(
                        label: 'login_password'.tr,
                        controller: lc.state.passwordCtrl,
                        suffix: InkWell(
                          onTap: lc.onVisibilityChange,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(
                              lc.state.visibilityIcon.value,
                              color: ThemeColor.formBorderColor,
                            ),
                          ),
                        ),
                        obscureText: lc.state.obscureText.value,
                      ),
                      const SizedBox(height: 32),
                      lc.state.isLoading.value
                          ? CustomLoader(height: 48.h, width: 48.w)
                          : ButtonWidthFull(callback: lc.onLoginTapped, title: 'login_btn_txt'.tr),
                      const SizedBox(height: 16),
                      Center(
                        child: RichText(
                          // overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: 'login_not_member'.tr,
                            style: Get.textTheme.bodyMedium,
                            children: <TextSpan>[
                              TextSpan(
                                text: ' ${'login_register'.tr}',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Get.theme.colorScheme.primary,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    debugPrint('navigate to register screen');
                                    Get.toNamed(AppRoutes.register);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
