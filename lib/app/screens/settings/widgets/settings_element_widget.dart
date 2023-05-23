import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app.dart';

class SettingsElementWidget extends StatelessWidget {
  final String text;
  final Widget? trailingIcon;
  final VoidCallback callback;
  const SettingsElementWidget({
    super.key,
    required this.text,
    required this.callback,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: ThemeColor.dividerColor),
        ),
      ),
      child: InkWell(
        splashColor: Get.isDarkMode ? ThemeColor.darkSplashColor : ThemeColor.lightSplashColor,
        onTap: callback,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          title: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          trailing: isNullOrEmpty(trailingIcon)
              ? Icon(
                  Icons.arrow_forward_ios,
                  size: 18.sp,
                  color: const Color(0xFF8F9098),
                )
              : trailingIcon,
        ),
      ),
    );
  }
}
