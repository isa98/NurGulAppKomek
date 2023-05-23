import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../app.dart';

class DashboardController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  Rxn<CartModel?>? cart;

  RxInt tabIndex = 0.obs;

  void changeTabIndex(int index) {
    debugPrint('changeTabIndex $index');
    tabIndex.value = index;
  }

  @override
  void onInit() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300), value: 1);
    getCart();
    super.onInit();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> getCart() async {
    LoginStatusController loginStatusController = Get.put(LoginStatusController());
    if (!loginStatusController.loginStatus) return;

    CartController cartController = Get.put(CartController());

    if (!isNullOrEmpty(cartController.state.cartModel)) {
      cart = cartController.state.cartModel;
    }
  }
}
