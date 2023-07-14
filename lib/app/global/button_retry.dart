import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RetryWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const RetryWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/no_inet.png',
              fit: BoxFit.cover,
              // height: 0.6.sh,
              // width: 1.sw,
            ),
            Positioned(
              left: 0.0,
              bottom: 0.0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'retry_info_title'.tr,
                      style: Get.theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'retry_info_text'.tr,
                      style: Get.theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: onRetry,
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                        ),
                      ),
                      child: Text('retry'.tr),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
