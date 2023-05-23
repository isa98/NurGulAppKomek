import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.dart';
import 'state.dart';

class OrdersController extends GetxController with StateMixin<List<OrderModel>>, ScrollMixin {
  final olState = OrdersState();

  @override
  void onInit() {
    debugPrint('OrderController onInit');
    fetchProducts();
    super.onInit();
  }

  void reset() {
    olState.repositories.clear();
    olState.page = 1;
    olState.getFirstData = false;
    olState.lastPage.value = false;
    change(null, status: RxStatus.loading());
  }

  Future<void> fetchProducts() async {
    final Map<String, dynamic> params = {
      'page': olState.page,
      'limit': Constants.pageSize,
      'pagination': true,
      'locale': await getLocale(),
    };

    await OrdersApi.get(params).then(
      (result) {
        final bool emptyRepositories = result.isEmpty;
        if (!olState.getFirstData && emptyRepositories) {
          change(null, status: RxStatus.empty());
        } else if (olState.getFirstData && emptyRepositories) {
          olState.lastPage.value = true;
        } else {
          olState.getFirstData = true;
          olState.repositories.addAll(result);

          if (result.length < Constants.pageSize) olState.lastPage.value = true;

          change(olState.repositories, status: RxStatus.success());
        }
      },
      onError: (err) {
        change(null, status: RxStatus.error(err.toString()));
      },
    );
  }

  Future<void> refreshList() async {
    debugPrint('onRefresh');
    reset();
    await fetchProducts();
  }

  List<OrderItem> getOrderItems(OrderModel order) {
    List<OrderItem> items = [];

    for (int i = 0; i < order.vendors.length; i++) {
      final vendor = order.vendors[i];
      for (int j = 0; j < vendor.items.length; j++) {
        items.add(vendor.items[j]);
      }
    }
    return items;
  }

  Future<void> onCancelButtonTapped(BuildContext context, int orderId) async {
    debugPrint('_onCancelButtonTapped');
    // context.loaderOverlay.show();
    // await OrdersApi.cancelOrder(orderId);
    // context.loaderOverlay.hide();
  }

  void onSupportButtonTapped() {
    debugPrint('_onSupportButtonTapped');
  }

  Future<bool> onWillPopScope() async {
    // Get.offNamedUntil(AppRoutes.DASHBOARD, (route) => false);
    return false;
  }

  @override
  Future<void> onEndScroll() async {
    debugPrint('onEndScroll');
    if (!olState.lastPage.value) {
      olState.page += 1;
      await fetchProducts();
    }
  }

  @override
  Future<void> onTopScroll() async {
    debugPrint('onTopScroll');
  }
}
