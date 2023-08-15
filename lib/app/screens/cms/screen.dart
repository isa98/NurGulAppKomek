import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app.dart';

class CMSScreen extends StatelessWidget {
  const CMSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CircleButton(),
        centerTitle: true,
        title: Text('about_us_title'.tr.toUpperCase()),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
        child: SingleChildScrollView(
          child: Center(
            child: Text(r'about_us_text'.tr),
          ),
        ),
      ),
    );
  }
}
