import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CircleButton(),
        centerTitle: true,
        title: Text('privacy_policy'.tr.toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
            child: Html(data: 'privacy_policy_text'.tr),
          ),
        ),
      ),
    );
  }
}
