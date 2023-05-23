import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';
import '../../app.dart';
import 'widgets/edit_profile_form.dart';
import 'widgets/language_selector.dart';

class SettingsController extends GetxController {
  final state = SettingsState();

  @override
  void onInit() {
    setInitials();
    super.onInit();
  }

  @override
  void onClose() {
    state.nameCtrl.dispose();
    state.phoneCtrl.dispose();
    state.pwdCtrl.dispose();

    super.onClose();
  }

  void onLoginTapped() {
    Get.toNamed(AppRoutes.login);
  }

  void onVisibilityChange() {
    state.obscureText.value = !state.obscureText.value;
    state.visibilityIcon.value = state.obscureText.value ? Icons.visibility_off : Icons.visibility;
  }

  void onLogoutTapped(BuildContext context) {
    debugPrint('onLogoutTapped');
    showDialog(
      context: context,
      builder: (_) => CustomDialog(
        title: 'settings_logout'.tr.toUpperCase(),
        content: 'settings_logout_body'.tr,
        continueBtnTxt: 'settings_logout'.tr,
        cancelBtnTxt: 'general_cancel'.tr,
        onCancelPressed: () async {
          debugPrint('onCancelPressed');
          Navigator.of(context, rootNavigator: true).pop();
        },
        onContinuePressed: () async {
          debugPrint('onContinuePressed');
          Navigator.of(context, rootNavigator: true).pop();

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.clear();

          //set login status
          await setLoginStatus(false);

          refresh();

          Get.toNamed(AppRoutes.login);
        },
      ),
    );
  }

  void navigate(String path) => Get.toNamed(path);

  void onLanguageTapped(BuildContext ctx) {
    final EdgeInsets mqPadding = MediaQuery.of(ctx).padding;

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      // backgroundColor: Colors.white,
      context: ctx,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 90.w,
                height: 7.h,
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.circular(20.w),
                ),
              ),
              const SizedBox(height: 16.0),
              SelectBox(
                label: 'Turkmen dili',
                isSelected: state.selectedLang.value == 'tm',
                onTap: () => onLanguageSelected('tm'),
              ),
              // const SizedBox(height: 16.0),
              const Divider(),
              SelectBox(
                label: 'Russian',
                isSelected: state.selectedLang.value == 'ru',
                onTap: () => onLanguageSelected('ru'),
              ),

              // safe area
              SizedBox(height: mqPadding.bottom + 16.0),
            ],
          ),
        );
      },
    );
  }

  Future<void> onDeleteAccountTapped(BuildContext context) async {
    debugPrint('onDeleteAccountTapped');

    showDialog(
      context: context,
      builder: (_) => CustomDialog(
        title: 'settings_delete_account'.tr.toUpperCase(),
        content: 'settings_delete_account_body'.tr,
        continueBtnTxt: 'settings_delete'.tr,
        cancelBtnTxt: 'general_cancel'.tr,
        onCancelPressed: () async {
          debugPrint('onCancelPressed');
          Navigator.of(context, rootNavigator: true).pop();
        },
        onContinuePressed: () async {
          debugPrint('onContinuePressed');
          Navigator.of(context, rootNavigator: true).pop();

          await AuthApi.deleteAccount();

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.clear();

          //set login status
          await setLoginStatus(false);

          refresh();

          Get.toNamed(AppRoutes.login);
        },
      ),
    );
  }

  Future<void> onEditProfileTapped(BuildContext context) async {
    debugPrint('onEditProfileTapped');

    final User? user = await User.getUser();

    if (user != null) {
      state.nameCtrl.text = user.firstName;
    }

    Get.dialog(const EditProfileDialog());
  }

  Future<void> onLanguageSelected(String language) async {
    debugPrint('onLanguageSelected $language');
    state.selectedLang.value = language;

    LocalizationService().changeLocale(language);
    await setLocale(language);

    setInitials();
    resetLocaleSavedData();

    update();
    Get.back();
  }

  Future<void> onSwitchTheme(isDarkMode) async {
    state.isLoading.value = true;

    state.isDarkMode.value = isDarkMode;
    final themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode);

    // save to sharedPrefs to set in startup
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Constants.isDarkMode, isDarkMode);

    DashboardController dc = Get.put(DashboardController());
    dc.changeTabIndex(BottomNavbar.settings.index);

    state.isLoading.value = false;
  }

  Future<void> setInitials() async {
    state.isLoading.value = true;

    state.user.value = await User.getUser();

    state.isDarkMode.value = Get.isDarkMode;

    state.selectedLang.value = await getLocale();

    state.isLoading.value = false;
  }

  Future<void> resetLocaleSavedData() async {
    HomeApi.resetModel();
    await CategoryApi.resetData();
  }

  Future<void> updateProfile(BuildContext context) async {
    debugPrint('updateProfile');
    FocusManager.instance.primaryFocus?.unfocus();

    if (state.profileForm.currentState!.validate()) {
      state.isUpdateLoading.value = true;

      String phone = '';
      final User? user = await User.getUser();

      if (user != null) {
        final phones = user.phone.split(' ');
        phone = phones.last;

        final Map<String, dynamic> params = {
          'first_name': state.nameCtrl.text,
          'last_name': '-',
          'phone': phone,
          'device_name': await getDeviceName(),
          // 'password': ,
        };

        final result = await AuthApi.updateUser(params);

        if (result) {
          state.user.value = await User.getUser();
          refresh();
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }

        state.isUpdateLoading.value = false;
      }
    }
  }
}
