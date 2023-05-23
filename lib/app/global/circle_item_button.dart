import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../app.dart';

class CircleItemButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;

  const CircleItemButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22.h,
      height: 22.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Get.theme.colorScheme.secondary,
      ),
      child: Material(
        color: Get.theme.colorScheme.secondary,
        elevation: 2.0,
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onPressed,
          splashColor: Get.isDarkMode ? ThemeColor.darkSplashColor : ThemeColor.lightSplashColor,
          child: icon,
        ),
      ),
    );
  }
}
