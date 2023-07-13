import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../app.dart';
import 'controller.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel model;

  const ProductDetailScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GetX<ProductDetailController>(
      init: ProductDetailController(model),
      builder: (pc) => Scaffold(
        body: SafeArea(
          top: false,
          bottom: false,
          child: LoaderOverlay(
            useDefaultLoading: false,
            overlayWidget: const CustomLoader(),
            child: Scaffold(
              appBar: AppBar(
                leading: BackButton(
                    color: Get.isDarkMode
                        ? Get.theme.colorScheme.primary
                        : ThemeColor.white),
                title: Text(
                  model.name,
                  style: TextStyle(
                      color: ThemeColor.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // begin image part
                      Container(
                        decoration: const BoxDecoration(
                          color: ThemeColor.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                          // boxShadow: [StyleConstants.boxShadow],
                        ),
                        height: 260.h,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              child: model.images.isNotEmpty
                                  ? CarouselSlider(
                                      sliders: model.images
                                          .map((img) => img.originalImageUrl)
                                          .toList(),
                                      boxFit: BoxFit.scaleDown,
                                      activeColor: Get.theme.primaryColor,
                                      passiveColor: Colors.grey,
                                      onSliderTapped: (index) {
                                        debugPrint('image index $index');
                                      },
                                    )
                                  : cachedImageNetwork('', BoxFit.contain),
                            ),
                            model.isNew
                                ? Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: ThemeColor.mainColor,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        'product_new'.tr,
                                        style: TextStyle(
                                          color: ThemeColor.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),

                            // wishlist part
                            Positioned(
                              top: 10,
                              right: 10,
                              child: InkWell(
                                onTap: () => pc.onAddToWishlistTapped(context),
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ThemeColor.mainColor, width: 2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: pc.state.product.value!.isWishlisted
                                      ? const Icon(
                                          Icons.favorite,
                                          color: ThemeColor.mainColor,
                                        )
                                      : const Icon(
                                          Icons.favorite_border,
                                          color: ThemeColor.mainColor,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // end image part

                      SizedBox(height: 24.h),

                      // begin name and inc&dec part
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              model.name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Get.theme.textTheme.titleMedium,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          CircleItemButton(
                            icon: Icon(
                              Icons.remove,
                              size: 18.sp,
                              color: Get.theme.colorScheme.primary,
                            ),
                            onPressed: pc.onDecTapped,
                          ),
                          SizedBox(width: 8.w),
                          Text(pc.state.quantity.value.toString(),
                              style: Get.theme.textTheme.bodyMedium),
                          SizedBox(width: 8.w),
                          CircleItemButton(
                            icon: Icon(
                              Icons.add,
                              size: 18.sp,
                              color: Get.theme.colorScheme.primary,
                            ),
                            onPressed: pc.onIncTapped,
                          ),
                        ],
                      ),
                      // end name and inc&dec part

                      SizedBox(height: 24.h),

                      // begin description part
                      Container(
                        decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? Get.theme.primaryColor
                                : ThemeColor.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFEBEBEB))
                            // boxShadow: [StyleConstants.boxShadow],
                            ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            model.description,
                            style: Get.theme.textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      // end description part

                      SizedBox(height: 24.h),

                      // begin related products part
                      pc.state.isLoading.value
                          ? SizedBox(
                              height: 296.h,
                              child: CustomLoader(height: 20.h, width: 20.w),
                            )
                          : pc.state.relatedProducts.isNotEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'product_related_products'
                                          .tr
                                          .toUpperCase(),
                                      style: Get.theme.textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 8),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: pc.state.relatedProducts
                                            .map((product) {
                                          return SizedBox(
                                            width: 200.w,
                                            child: ProductCard(model: product),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                      // end related products part

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                padding: EdgeInsets.only(
                  bottom: Get.mediaQuery.padding.bottom,
                ),
                child: SizedBox(
                  height: 55.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          color: Get.isDarkMode
                              ? const Color(0xFF151515)
                              : const Color(0xFFFFB2CF),
                          child: model.hasDiscount
                              ? Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          model.formattedPrice,
                                          style: TextStyle(
                                            color: Get.isDarkMode
                                                ? ThemeColor.white
                                                : const Color(0xFF620024),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          '${(model.price * pc.state.quantity.value).toStringAsFixed(2)} TMT',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Get.isDarkMode
                                                ? const Color(0xFFA7ADB7)
                                                : const Color(0xFFFF005E),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    '${(model.price * pc.state.quantity.value).toStringAsFixed(2)} TMT',
                                    style: TextStyle(
                                        color: Get.isDarkMode
                                            ? ThemeColor.white
                                            : const Color(0xFF620024),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp),
                                  ),
                                ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => pc.onAddToCartTapped(context),
                          child: Container(
                            color: const Color(0xFFFF005E),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/add_to_cart.svg',
                                    color: ThemeColor.white,
                                    height: 30.h,
                                    width: 30.w,
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      'product_add_to_cart'.tr,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: ThemeColor.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
