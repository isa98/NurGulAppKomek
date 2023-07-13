import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/no_inet.png',
          fit: BoxFit.cover,
          height: 0.6.sh,
          width: 1.sw,
        ),
        const SizedBox(height: 20),
        Text(
          'general_data_no_inet'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
        Text(
          'general_data_no_inet_body'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
      //  RetryWidget(onRetry: onRetry)
      ],
    );
  }
}