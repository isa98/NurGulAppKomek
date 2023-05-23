import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/not_found.png',
          fit: BoxFit.cover,
          height: 0.6.sh,
          width: 1.sw,
        ),
        const SizedBox(height: 20),
        Text(
          'general_data_not_fount'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
      ],
    );
  }
}
