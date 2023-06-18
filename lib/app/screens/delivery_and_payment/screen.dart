import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app.dart';

class DeliveryAndPaymentScreen extends StatelessWidget {
  const DeliveryAndPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CircleButton(),
        centerTitle: true,
        title: Text(
          'delivery_and_payment'.tr.toUpperCase(),
          softWrap: false,
          overflow: TextOverflow.fade,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
            child: Html(data: 'delivery_and_payment_text'.tr),
          ),
        ),
      ),
    );
  }
}
