// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app.dart';
import 'state.dart';

class HomeController extends GetxController {
  final state = HomeState();

  @override
  void onInit() {
    get();
    super.onInit();
  }

  Future<void> get() async {
    state.isLoading.value = true;

    final model = await HomeApi.get();

    if (model != null) state.homeModel.value = model;

    state.isLoading.value = false;
  }

  void onShowAllTapped(ProductSection section) {
    debugPrint('onShowAllTapped');
    final filters = section.filter.split('=');
    final Map<String, dynamic> params = {
      'title': section.title,
      filters[0]: filters[1],
    };
    Get.toNamed(AppRoutes.productList, arguments: params);
  }

  void navigateToProductList(String path) {
    debugPrint('MyCarouselController navigateToProductList path: $path');

    // check has parameter to navigate
    final hasParams = path.contains('=');

    if (!hasParams) return;

    final params = path.split('&');

    final Map<String, dynamic> queryParams = {};

    for (var param in params) {
      final parts = param.split('=');
      queryParams.addAll({
        parts[0]: parts[1],
      });
    }

    Get.toNamed(AppRoutes.productList, arguments: queryParams);
  }
}

/*
category={id}

new={boolean}

featured={boolean}
*/