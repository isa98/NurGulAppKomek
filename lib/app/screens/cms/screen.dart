import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app.dart';

class CMSScreen extends StatelessWidget {
  const CMSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CmsController>(
      init: CmsController(),
      builder: (cc) => Scaffold(
        appBar: AppBar(
          leading: const CircleButton(),
          centerTitle: true,
          title: Text('about_us_title'.tr.toUpperCase()),
        ),
        body: cc.isLoading.value
            ? const CustomLoader()
            : isNullOrEmpty(cc.htmlContent.value)
                ? RetryWidget(onRetry: cc.getCMS)
                : Container(
                    padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
                    child: SingleChildScrollView(
                      child: Center(
                        child: Html(data: cc.htmlContent.value),
                      ),
                    ),
                  ),
      ),
    );
  }
}
