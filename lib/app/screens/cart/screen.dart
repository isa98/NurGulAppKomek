import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../app.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/payment.dart';
import 'widgets/product_list_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CartController>(
      init: CartController(),
      builder: (cc) {
        final CartModel? model = cc.state.cartModel.value;
        final bool isLoggedIn = cc.state.loginStatusController.loginStatus;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('cart_my_cart'.tr.toUpperCase()),
          ),
          body: isLoggedIn
              ? cc.state.isLoading.value
                  ? const CustomLoader()
                  : isNullOrEmpty(model)
                      ? const NotFoundWidget()
                      : Scaffold(
                          body: LoaderOverlay(
                            useDefaultLoading: false,
                            overlayWidget: const Center(child: CustomLoader()),
                            child: cc.state.isOrdered.value ? const PaymentWidget() : const ProductListWidget(),
                          ),
                          bottomNavigationBar: const CartBottomNavbar(),
                        )
              : const LoginWidget(),
        );
      },
    );
  }
}
