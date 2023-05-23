// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nurgul/app/screens/home/controller.dart';

import '../../app.dart';

import 'state.dart';

class ProductDetailController extends GetxController {
  final state = ProductDetailState();

  ProductModel model;

  ProductDetailController(this.model);

  @override
  void onInit() {
    state.product.value = model;
    getRelatedProducts();
    super.onInit();
  }

  @override
  void onClose() {
    debugPrint('ProductController.onClose');

    // update home screen product model
    if (state.isWishlistTapped.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) => updateModels());
    }

    super.onClose();
  }

  void updateModels() {
    // current screen is wishlist screen, refresh
    final DashboardController dc = Get.put(DashboardController());

    // home screen
    if (dc.tabIndex.value == BottomNavbar.home.index) {
      HomeController hc = Get.put(HomeController());
      hc.state.homeModel.refresh();
    }

    // wishlist screen
    if (dc.tabIndex.value == BottomNavbar.wishlist.index) {
      HomeApi.resetModel();

      WishlistController wc = Get.put(WishlistController());
      wc.refreshList();
    }
  }

  void onIncTapped() => state.quantity.value++;

  void onDecTapped() {
    debugPrint('onDecTapped');
    if (state.quantity.value >= state.minItemQuantity) {
      state.quantity.value--;
    }
  }

  Future<void> getRelatedProducts() async {
    state.isLoading.value = true;

    state.relatedProducts.clear();
    final result = await ProductApi.getRelatedProducts(model.id);

    if (result.isNotEmpty) state.relatedProducts.addAll(result);
    state.isLoading.value = false;
  }

  Future<void> onAddToWishlistTapped(BuildContext context) async {
    debugPrint('onAddToWishlistTapped');
    context.loaderOverlay.show();
    final result = await WishlistApi.addRemove(model.id);

    if (result) {
      state.product.value!.isWishlisted = !state.product.value!.isWishlisted;
      state.product.refresh();

      state.isWishlistTapped.value = true;
    }

    context.loaderOverlay.hide();
  }

  Future<void> onAddToCartTapped(BuildContext context) async {
    debugPrint('onAddToCartTapped');

    context.loaderOverlay.show();

    CartController cc = Get.put(CartController());

    final Map<String, dynamic> params = {
      'product_id': model.id,
      'quantity': state.quantity.value,
    };

    await cc.add(params, model.id);

    context.loaderOverlay.hide();
  }
}
