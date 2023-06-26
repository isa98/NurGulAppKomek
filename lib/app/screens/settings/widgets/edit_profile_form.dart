import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app.dart';
import '../controller.dart';

final Widget divider = SizedBox(height: 10.h);

final ddTxtStyle = TextStyle(
  color: ThemeColor.black,
  fontWeight: FontWeight.w400,
  fontSize: 14.sp,
);

class EditProfileDialog extends StatelessWidget {
  const EditProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<SettingsController>(
      init: SettingsController(),
      builder: (sc) {
        final bool isLoading = sc.state.isUpdateLoading.value;
        return AlertDialog(
          backgroundColor: ThemeColor.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          titlePadding: EdgeInsets.zero,
          scrollable: true,
          title: Center(
            child: ListTile(
              title: Center(
                child: Text(
                  'settings_profile'.tr,
                  style: const TextStyle(color: ThemeColor.black),
                ),
              ),
              subtitle: Center(
                child: Text(
                  'settings_profile_info'.tr,
                  style: const TextStyle(color: ThemeColor.black),
                ),
              ),
            ),
          ),
          contentPadding: const EdgeInsets.all(16),
          insetPadding: EdgeInsets.zero,
          content: Builder(
            builder: (context) {
              final width = 1.sw - 70;
              return SizedBox(
                width: width > 0 ? width : 1.sw,
                child: Form(
                  key: sc.state.profileForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('reg_form_name'.tr, style: StyleConstants.formHeaderStyle),
                      StyleConstants.formSpacer,
                      MyTextFormField(
                        label: 'reg_form_name'.tr,
                        inputType: TextInputType.text,
                        controller: sc.state.nameCtrl,
                        focusNode: sc.state.nameFocus,
                      ),
                      /*  const SizedBox(height: 20),
                      Text('reg_form_phone'.tr, style: StyleConstants.formHeaderStyle),
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
                        controller: sc.state.phoneCtrl,
                      ),
                      const SizedBox(height: 20),
                      Text('reg_form_pwd'.tr, style: StyleConstants.formHeaderStyle),
                      StyleConstants.formSpacer,
                      MyTextFormField(
                        label: 'reg_form_pwd_new'.tr,
                        controller: sc.state.pwdCtrl,
                        suffix: InkWell(
                          onTap: sc.onVisibilityChange,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(
                              sc.state.visibilityIcon.value,
                              color: ThemeColor.formBorderColor,
                            ),
                          ),
                        ),
                        obscureText: sc.state.obscureText.value,
                      ), */
                      SizedBox(height: 30.h),
                      isLoading
                          ? const CustomLoader()
                          : Row(
                              children: [
                                SizedBox(
                                  height: 48.h,
                                  width: width * 0.48,
                                  child: OutlinedButton(
                                    onPressed: () => Navigator.pop(context),
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      side: BorderSide(
                                        width: 2,
                                        color: Get.theme.colorScheme.primary,
                                      ),
                                    ),
                                    child: Text('address_cancel'.tr),
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: width * 0.48,
                                  child: ButtonWidthFull(
                                    title: 'address_update'.tr,
                                    callback: () => sc.updateProfile(context),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
