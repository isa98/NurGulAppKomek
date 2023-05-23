import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RetryWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const RetryWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.refresh, size: 50.sp),
          const SizedBox(height: 10),
          Text('retry_info_text'.tr),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onRetry,
            child: Text('retry_icon_text'.tr),
          ),
        ],
      ),
    );
  }
}
