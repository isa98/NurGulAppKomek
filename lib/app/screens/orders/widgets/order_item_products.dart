import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app.dart';

class OrderItemProductList extends StatelessWidget {
  final List<OrderItem> items;
  const OrderItemProductList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CircleButton(),
        centerTitle: true,
        title: Text('order_order_title'.tr.toUpperCase()),
      ),
      body: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        physics: const ClampingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (_, index) => OrderItemWidget(item: items[index], count: items[index].qtyOrdered),
        separatorBuilder: (_, int index) => const Divider(
          height: 0.5,
          thickness: 1.5,
        ),
      ),
    );
  }
}

class OrderItemWidget extends StatelessWidget {
  final OrderItem item;
  final int count;
  const OrderItemWidget({super.key, required this.item, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108.h,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: const Border(bottom: BorderSide(color: ThemeColor.dividerColor)),
        color: Get.isDarkMode ? ThemeColor.darkMainColor : ThemeColor.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. image
          SizedBox(
            height: 90.h,
            width: 90.w,
            child: cachedImageNetwork(
              item.product.images.isNotEmpty ? item.product.images.first.originalImageUrl : '',
              BoxFit.contain,
            ),
          ),
          const SizedBox(width: 16),

          // 2. info
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. item name
                Expanded(
                  child: Text(
                    item.name,
                    style: Get.theme.textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const Spacer(),

                // 2. item count and price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 4),
                    Row(
                      children: [
                        Text('order_total_item_count'.tr, style: Get.theme.textTheme.titleMedium),
                        Text(
                          count.toString(),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              item.formattedPrice,
                              maxLines: 1,
                              style: TextStyle(
                                color: Get.isDarkMode ? ThemeColor.white : const Color(0xFFFF5100),
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          if (item.discountAmount > 0.0)
                            Flexible(
                              child: Text(
                                item.formattedDiscountAmount,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.lineThrough,
                                  color: Get.isDarkMode ? const Color(0xFFA7ADB7) : const Color(0xFFFF005E),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
