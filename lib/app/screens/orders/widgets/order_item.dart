import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app.dart';
import 'order_item_products.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderModel order;
  const OrderItemWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('navigate to OrderItemProductList');
        // we have only one vendor.
        Get.to(
          () => OrderItemProductList(
            items: order.vendors.first.items,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            // image part
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: Get.isDarkMode ? ThemeColor.darkMainColor : ThemeColor.mainColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(
                'assets/icons/box.png',
              ),
            ),
            const SizedBox(width: 24),

            // info part
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'order_order_number'.tr} #${order.id}',
                    style: Get.theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(order.createdAt),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: order.status == 'completed' ? const Color(0xFF1A9F04) : const Color(0xFFE58A00),
                    ),
                    child: Text(
                      'order_status_${order.status}'.tr,
                      style: const TextStyle(color: ThemeColor.white),
                    ),
                  ),
                ],
              ),
            ),

            // item count part
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 28.w,
                height: 28.h,
                decoration: BoxDecoration(
                  color: Get.isDarkMode ? ThemeColor.darkMainColor : ThemeColor.mainColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    order.totalItemCount.toString(),
                    style: TextStyle(
                      color: ThemeColor.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
