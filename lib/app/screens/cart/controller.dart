// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../app.dart';
import 'state.dart';

class CartController extends GetxController {
  final state = CartState();

  @override
  void onInit() {
    get();
    super.onInit();
  }

  Future<void> get() async {
    if (!state.loginStatusController.loginStatus) return;

    state.isLoading.value = true;
    state.cartModel.value = await CartApi.get();

    state.isLoading.value = false;
  }

  Future<void> add(Map<String, dynamic> params, int productId) async {
    state.cartModel.value = await CartApi.add(params, productId);
  }

  Future<void> onIncDecTapped(BuildContext context, int itemId, int newQuantity) async {
    debugPrint('onIncDecTapped');

    if (newQuantity < 1) {
      showSnack('general_warning'.tr, 'cart_min_item'.tr, SnackType.warning);
      return;
    }

    context.loaderOverlay.show();
    final response = await CartApi.update(itemId, newQuantity);
    if (response != null) {
      state.cartModel.value = response;
    }
    context.loaderOverlay.hide();
  }

  Future<void> onTrashTapped(BuildContext context, int itemId) async {
    debugPrint('onTrashTapped $itemId');

    context.loaderOverlay.show();
    state.cartModel.value = await CartApi.remove(itemId);
    context.loaderOverlay.hide();
  }

  Future<void> onAddressSelected(BuildContext context, AddressModel address, int? selectedIndex) async {
    debugPrint('onAddressSelected ${address.id}');

    context.loaderOverlay.show();

    final Map<String, dynamic> params = {
      "billing": {
        "address1": [address.address1.first]
      },
      "shipping": {
        "address1": [address.address1.first]
      },
      "shipping_method": "courier_courier"
    };

    final bool result = await OrdersApi.saveShipping(params);

    context.loaderOverlay.hide();

    // this did not show properly in try catch
    if (!result) {
      showSnack('general_error'.tr, 'general_error'.tr, SnackType.error);
    } else {
      state.selectedAddressIndex.value = selectedIndex ?? 0;
    }

    update();
  }

  Future<void> onPaymentTypeSelected(BuildContext context, PaymentMethodModel method, int? selectedIndex) async {
    debugPrint('onPaymentTypeSelected ${method.method}');

    context.loaderOverlay.show();

    final Map<String, dynamic> params = {
      'payment': {
        'method': method.method,
      },
    };

    final result = await OrdersApi.savePayment(params);

    context.loaderOverlay.hide();

    // this did not show properly in try catch
    if (!result) {
      showSnack('general_error'.tr, 'general_error'.tr, SnackType.error);
    } else {
      state.selectedPaymentIndex.value = selectedIndex ?? 0;
    }

    update();
  }

  Future<void> onCheckoutTapped() async {
    debugPrint('onCheckoutTapped');

    // if price widget is displayed, then order
    if (state.isOrdered.value) {
      debugPrint('complete order');
      // 1. validate
      // validate address
      if (state.selectedAddressIndex.value == 0) {
        showSnack('general_warning'.tr, 'cart_select_address'.tr, SnackType.warning);
        return;
      }
      // validate payment
      if (state.selectedPaymentIndex.value == 0) {
        showSnack('general_warning'.tr, 'cart_payment_type_title'.tr, SnackType.warning);
        return;
      }

      // 2. complete order

      final Map<String, dynamic> params = {
        // 'shipping_method': state.selectedShippingRate.value?.method ?? '',
        // 'payment': state.selectedPaymentMethod.value?.method,
        'locale': await getLocale(),
      };

      final result = await OrdersApi.saveOrder(params);

      if (result) {
        Get.offNamedUntil('/', (route) => false);

        Get.to(() => const OrdersScreen());
      }
    } else {
      // fetch payment methods
      state.isCheckoutLoading.value = true;

      List<PaymentMethodModel>? paymentMethods = await CartApi.checkout();

      if (paymentMethods != null) {
        state.isOrdered.value = true;

        state.paymentMethods.addAll(paymentMethods);
      }

      state.isCheckoutLoading.value = false;
    }
  }

  void clearLists() {
    // state.shippingRates.clear();
    // state.paymentMethods.clear();
  }
}
