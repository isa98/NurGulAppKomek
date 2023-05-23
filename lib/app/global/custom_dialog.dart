import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String continueBtnTxt;
  final String cancelBtnTxt;
  final VoidCallback onCancelPressed;
  final VoidCallback onContinuePressed;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onCancelPressed,
    required this.onContinuePressed,
    required this.continueBtnTxt,
    required this.cancelBtnTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: ThemeColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, right: 16, left: 16, bottom: 16),
            child: Text(
              title,
              style: TextStyle(
                color: ThemeColor.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: ThemeColor.black),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width * 0.35,
                child: TextButton(
                  onPressed: onCancelPressed,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.white,
                    ),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color: Get.theme.colorScheme.primary,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(cancelBtnTxt),
                ),
              ),
              SizedBox(
                width: width * 0.35,
                child: TextButton(
                  onPressed: onContinuePressed,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Get.theme.colorScheme.primary),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                  child: Text(
                    continueBtnTxt,
                    style: const TextStyle(color: ThemeColor.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
