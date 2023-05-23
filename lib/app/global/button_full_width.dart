import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app.dart';

class ButtonWidthFull extends StatelessWidget {
  final String title;
  final Color txtColor;
  final VoidCallback? callback;

  const ButtonWidthFull({
    super.key,
    required this.title,
    required this.callback,
    this.txtColor = ThemeColor.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: TextButton(
        style: ButtonStyle(
          // elevation: MaterialStateProperty.all(5),
          shape: MaterialStateProperty.all((RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)))),
          // padding: MaterialStateProperty.all(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all(Get.theme.colorScheme.primary), // <-- Button color
          // overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          //   if (states.contains(MaterialState.pressed))
          //     return btnColor == ThemeColor.mainColor
          //         ? ThemeColor.grey.withOpacity(0.50)
          //         : ThemeColor.mainColor.withOpacity(0.30); // <-- Splash color
          //   return null;
          // }),
        ),
        onPressed: callback != null ? () => callback!() : null,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: txtColor,
          ),
        ),
      ),
    );
  }
}
