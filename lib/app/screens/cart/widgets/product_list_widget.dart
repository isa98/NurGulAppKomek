import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: VendorListView(),
        ),
      ],
    );
  }
}

// displays vendor list
class VendorListView extends StatelessWidget {
  const VendorListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CartController>(
      init: CartController(),
      builder: (cc) {
        final CartModel? model = cc.state.cartModel.value;
        return cc.state.isLoading.value
            ? const CustomLoader()
            : model != null
                ? ListView.builder(
                    // shrinkWrap: true,
                    itemCount: model.vendors.length,
                    itemBuilder: (_, int index) => Container(
                      margin: const EdgeInsets.all(8),
                      child: ProductListView(items: model.vendors[index].items),
                    ),
                  )
                : Center(
                    child: RetryWidget(onRetry: cc.get),
                  );
      },
    );
  }
}

// displays vendor product list
class ProductListView extends StatelessWidget {
  final List<CartItemModel> items;

  const ProductListView({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (_, index) => CartItemWidget(item: items[index]),
      separatorBuilder: (_, int index) => Divider(
        color: ThemeColor.black.withAlpha(16),
        height: 0.5,
        thickness: 1.5,
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItemModel item;
  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (cc) => Container(
        height: 108.h,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border:
              const Border(bottom: BorderSide(color: ThemeColor.dividerColor)),
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
                item.product.images.isNotEmpty
                    ? item.product.images.first.originalImageUrl
                    : '',
                BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),

            // 2. info
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. item name & delete icon
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: Get.theme.textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 30.sp,
                        child: CircleItemButton(
                          icon: Image.asset(
                            'assets/icons/delete.png',
                            color: Get.theme.colorScheme.primary,
                            height: 18.h,
                            width: 18.w,
                          ),
                          onPressed: () => cc.onTrashTapped(context, item.id),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // 2. inc & dec button and price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleItemButton(
                            icon: Icon(
                              Icons.remove,
                              size: 18.sp,
                              color: Get.theme.colorScheme.primary,
                            ),
                            onPressed: () => cc.onIncDecTapped(
                                context, item.id, item.quantity - 1),
                          ),
                          SizedBox(width: 8.w),
                          Text(item.quantity.toString(),
                              style: Get.theme.textTheme.bodyMedium),
                          SizedBox(width: 8.w),
                          CircleItemButton(
                            icon: Icon(
                              Icons.add,
                              size: 18.sp,
                              color: Get.theme.colorScheme.primary,
                            ),
                            onPressed: () => cc.onIncDecTapped(
                                context, item.id, item.quantity + 1),
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
                                  color: Get.isDarkMode
                                      ? ThemeColor.white
                                      : const Color(0xFF620024),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            if (item.discountAmount > 0.0)
                              Flexible(
                                child: Text(
                                  item.formattedDiscountAmount ?? '0',
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Get.isDarkMode
                                        ? ThemeColor.white
                                        : const Color(0xFF620024),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.sp,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
