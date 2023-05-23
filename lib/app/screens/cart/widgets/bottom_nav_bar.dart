import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app.dart';

class CartBottomNavbar extends StatelessWidget {
  const CartBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CartController>(
      init: CartController(),
      builder: (cc) => Container(
        height: 130.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? ThemeColor.darkMainColorGreenSecondary : const Color(0xFFFFEDF4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // price part
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'cart_total'.tr,
                  style: Get.theme.textTheme.bodyMedium,
                ),
                Flexible(
                  child: Text(
                    cc.state.cartModel.value != null ? cc.state.cartModel.value!.formattedGrandTotal : '',
                    style: Get.theme.textTheme.titleMedium,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // button approve
            cc.state.isCheckoutLoading.value
                ? CustomLoader(height: 30.h, width: 30.w)
                : ButtonWidthFull(
                    callback: cc.onCheckoutTapped,
                    title: 'cart_approve'.tr,
                  ),
          ],
        ),
      ),
    );
  }
}
