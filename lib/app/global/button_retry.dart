import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RetryWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const RetryWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Image.asset(
            'assets/images/no_inet.png',
            fit: BoxFit.cover,
            height: 0.6.sh,
            width: 1.sw,
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            child: Column(
              children: [
                Text('retry_info_title'.tr),
                const SizedBox(height: 10),
                Text('retry_info_text'.tr),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: onRetry,
                  child: Text('retry'.tr),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
