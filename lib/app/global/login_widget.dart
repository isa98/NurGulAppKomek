import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Center(
            child: Text(
              'login_write_something'.tr,
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: OutlinedButton(
              onPressed: () {
                debugPrint('navigate to login screen');
                Get.toNamed(AppRoutes.login);
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                side: BorderSide(
                  width: 2,
                  color: Get.theme.colorScheme.primary,
                ),
              ),
              child: Text('login_login'.tr),
            ),
          ),
        ],
      ),
    );
  }
}
