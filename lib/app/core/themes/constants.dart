import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StyleConstants {
  static const formSpacer = SizedBox(height: 8);
  static final formHeaderStyle = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold);
  static final boxShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 1,
    blurRadius: 1,
    offset: const Offset(
      0,
      1, // to move the shadow downwards by 3 pixels.
    ), // changes position of shadow,
  );
}
