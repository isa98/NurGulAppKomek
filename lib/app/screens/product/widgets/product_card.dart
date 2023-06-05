import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../../app.dart';

class ProductCard extends StatefulWidget {
  final ProductModel model;
  final double elevation;

  const ProductCard({
    super.key,
    required this.model,
    this.elevation = 0.5,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isAddToWishlistLoading = false;
  bool _isAddToCartLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 315.h,
      child: InkWell(
        onTap: () {
          debugPrint('product');
          if (Get.currentRoute == AppRoutes.productDetailScreen) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(model: widget.model),
              ),
            );
          } else {
            Get.to(() => ProductDetailScreen(model: widget.model));
          }
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image part
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColor.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: cachedImageNetwork(
                    widget.model.images.isNotEmpty
                        ? widget.model.images.first.originalImageUrl
                        : '',
                    BoxFit.fill,
                    const BorderRadius.all(Radius.circular(4.0)),
                    1.sw,
                    150.h,
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              // Product name part
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  widget.model.name,
                  maxLines: 2,
                  style: TextStyle(
                    color: Get.isDarkMode ? ThemeColor.white : ThemeColor.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(height: 4.h),

              // price widget
              widget.model.hasDiscount
                  // Discount part text
                  ? Row(
                      children: [
                        // Discounted price
                        _priceWidget(widget.model.formattedSpecialPrice ?? '',
                            widget.model.hasDiscount),

                        // Original price
                        Flexible(
                          child: Text(
                            widget.model.formattedRegularPrice ?? '',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.lineThrough,
                              color: ThemeColor.discountPriceColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    )
                  : _priceWidget(widget.model.formattedPrice, false),

              const Spacer(),

              // row buttons part
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: GetX<CartController>(
                          init: CartController(),
                          builder: (controller) {
                            final isAddToCartLoading =
                                controller.state.isLoading.value;
                            final isItemInCart =
                                controller.isInCart(widget.model.id);
                            if (isAddToCartLoading || _isAddToCartLoading) {
                              return CustomLoader(
                                height: 20.h,
                                width: 20.w,
                              );
                            }
                            return Material(
                              color: Colors.transparent,
                              child: Ink(
                                decoration: BoxDecoration(
                                    color: Get.isDarkMode
                                        ? ThemeColor.darkMainColorLight
                                        : isItemInCart
                                            ? ThemeColor.white
                                            : ThemeColor.mainColorMid,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      width: 2.0,
                                      color: isItemInCart
                                          ? ThemeColor.mainColor
                                          : ThemeColor.mainColorMid,
                                    )),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(6),
                                  onTap: () async {
                                    debugPrint('addToCart');
                                    final itemId = controller
                                            .getCartItemId(widget.model.id) ??
                                        0;
                                    setState(() => _isAddToCartLoading = true);
                                    final Map<String, dynamic> params = {
                                      'product_id': widget.model.id,
                                      'quantity': 1,
                                    };
                                    if (!isItemInCart) {
                                      await controller.add(
                                          params, widget.model.id);
                                    } else {
                                      await controller.remove(itemId);
                                    }
                                    setState(() => _isAddToCartLoading = false);
                                  },
                                  child: SizedBox(
                                    height: 32.h,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            isItemInCart
                                                ? Icons
                                                    .remove_shopping_cart_rounded
                                                : Icons
                                                    .add_shopping_cart_rounded,
                                            color:
                                                Get.theme.colorScheme.primary,
                                            size: 22.sp,
                                          ),
                                          const SizedBox(width: 12),
                                          Flexible(
                                            child: Text(
                                              isItemInCart
                                                  ? 'product_remove_from_cart'
                                                      .tr
                                                  : 'product_add_to_cart'.tr,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Get.isDarkMode
                                                      ? ThemeColor.white
                                                      : ThemeColor.mainColor,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(width: 8),
                    _isAddToWishlistLoading
                        ? Expanded(
                            flex: 1,
                            child: CustomLoader(
                              height: 20.h,
                              width: 20.w,
                            ),
                          )
                        : Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  _isAddToWishlistLoading = true;
                                });

                                await WishlistApi.addRemove(widget.model.id)
                                    .then((result) {
                                  if (result) {
                                    widget.model.isWishlisted =
                                        !widget.model.isWishlisted;

                                    // current screen is wishlist screen, refresh
                                    final DashboardController dc =
                                        Get.put(DashboardController());

                                    if (dc.tabIndex.value == 3) {
                                      HomeApi.resetModel();

                                      WishlistController wc =
                                          Get.put(WishlistController());
                                      wc.refreshList();
                                    }
                                  }

                                  setState(() {
                                    _isAddToWishlistLoading = false;
                                  });
                                });
                              },
                              child: Container(
                                height: 35.h,
                                width: 35.w,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ThemeColor.mainColor, width: 2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: widget.model.isWishlisted
                                    ? Icon(
                                        Icons.favorite,
                                        color: ThemeColor.mainColor,
                                        size: 22.sp,
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        color: ThemeColor.mainColor,
                                        size: 22.sp,
                                      ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _priceWidget(String text, bool hasDiscount) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: ThemeColor.darkPriceColor,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
