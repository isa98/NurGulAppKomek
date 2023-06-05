import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;

import '../../../app.dart';
import '../controller.dart';
import 'settings_element_widget.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<SettingsController>(
      builder: (sc) => sc.state.isLoading.value
          ? const CustomLoader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Section 1 - Profile Picture - Username - Name
                  GestureDetector(
                    onTap: () => sc.onEditProfileTapped(context),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 24),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 100.w,
                            height: 100.h,
                            child: Stack(
                              children: [
                                Container(
                                  width: 100.w,
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: ThemeColor.mainColorMid,
                                  ),
                                  alignment: Alignment.center,
                                  clipBehavior: Clip.antiAlias,
                                  child: const Icon(
                                    Icons.person,
                                    size: 100.0,
                                    color: ThemeColor.mainColor,
                                  ),
                                ),
                                Positioned(
                                    bottom: 0.0,
                                    right: 0.0,
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(35.0),
                                        // image: const DecorationImage(
                                        //   image: AssetImage('assets/icons/avatar.png'),
                                        //   fit: BoxFit.scaleDown,
                                        // ),
                                        color: ThemeColor.mainColor,
                                      ),
                                      child: const Icon(
                                        Icons.edit_rounded,
                                        color: ThemeColor.white,
                                        size: 15.0,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          // full name
                          isNullOrEmpty(sc.state.user.value)
                              ? const SizedBox.shrink()
                              : Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 4, top: 14),
                                      child: Text(
                                        sc.state.user.value!.firstName,
                                        style: TextStyle(
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : ThemeColor.lightTextColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),

                                    // Username
                                    Text(
                                      sc.state.user.value!.phone,
                                      style: TextStyle(
                                        color: Get.isDarkMode
                                            ? Colors.white.withOpacity(0.6)
                                            : ThemeColor.lightTextColor,
                                        fontSize: 14.sp,
                                      ),
                                      // style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                  SettingsElementWidget(
                      text: 'settings_address'.tr,
                      callback: () => sc.navigate(AppRoutes.addresses)),
                  SettingsElementWidget(
                      text: 'settings_order_history'.tr,
                      callback: () => sc.navigate(AppRoutes.orders)),
                  SettingsElementWidget(
                    text: 'settings_lang'.tr,
                    callback: () => sc.onLanguageTapped(context),
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: ThemeColor.dividerColor),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(left: 16, right: 2),
                      title: Text('settings_theme'.tr,
                          style: Theme.of(context).textTheme.bodyMedium),
                      trailing: Transform.scale(
                        scale: 1,
                        child: Platform.isAndroid
                            ? Switch(
                                value: sc.state.isDarkMode.value,
                                onChanged: (value) => sc.onSwitchTheme(value),
                              )
                            : CupertinoSwitch(
                                value: sc.state.isDarkMode.value,
                                onChanged: (value) => sc.onSwitchTheme(value),
                              ),
                      ),
                    ),
                  ),
                  // SettingsElementWidget(text: 'settings_contact'.tr, callback: () {}),
                  SettingsElementWidget(
                      text: 'settings_about_us'.tr,
                      callback: () => sc.navigate(AppRoutes.cms)),
                  SettingsElementWidget(
                    text: 'privacy_policy'.tr,
                    callback: () => sc.navigate(AppRoutes.privacy),
                  ),
                  SettingsElementWidget(
                    text: 'settings_logout'.tr,
                    callback: () => sc.onLogoutTapped(context),
                    trailingIcon: Icon(
                      Icons.exit_to_app_rounded,
                      size: 22.sp,
                      color: const Color(0xFF8F9098),
                    ),
                  ),
                  SettingsElementWidget(
                    text: 'settings_delete_account'.tr,
                    callback: () => sc.onDeleteAccountTapped(context),
                    trailingIcon: Image.asset(
                      'assets/icons/delete.png',
                      color: Get.theme.colorScheme.primary,
                      height: 25.h,
                      width: 25.w,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }
}
