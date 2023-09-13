// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.dart';

import 'state.dart';

class ProductController extends GetxController
    with StateMixin<List<ProductModel>>, ScrollMixin {
  final productState = ProductState();

  final Map<String, dynamic> params;

  ProductController(this.params);

  @override
  void onInit() {
    fetchProducts();

    super.onInit();
  }

  @override
  void dispose() {
    debugPrint('productController dispose');
    super.dispose();
  }

  void reset() {
    productState.repositories.clear();
    productState.page = 1;
    productState.getFirstData = false;
    productState.lastPage.value = false;
    change(null, status: RxStatus.loading());
  }

  Future<void> fetchProducts() async {
    debugPrint('fetchProducts');
    final Map<String, dynamic> queryParams = {
      'currency': 'TMT',
      'locale': await getLocale(),
      'page': productState.page,
      'limit': Constants.pageSize,
    };

    var excludeKeys = ['title', 'type', 'vendorId'];

    params.forEach((key, value) {
      if (!excludeKeys.contains(key)) queryParams[key] = value;
    });

    debugPrint('params $queryParams');

    if (params['type'] == 'vendor') {
      await ProductApi.getVendorProducts(params['vendorId'], queryParams).then(
        (result) {
          final bool emptyRepositories = result.isEmpty;
          if (!productState.getFirstData && emptyRepositories) {
            change(null, status: RxStatus.empty());
          } else if (productState.getFirstData && emptyRepositories) {
            productState.lastPage.value = true;
          } else {
            productState.getFirstData = true;
            productState.repositories.addAll(result);

            if (result.length < Constants.pageSize)
              productState.lastPage.value = true;

            change(productState.repositories, status: RxStatus.success());
          }
        },
        onError: (err) {
          change(null, status: RxStatus.error(err.toString()));
        },
      );
    } else {
      await ProductApi.get(queryParams).then(
        (result) {
          final bool emptyRepositories = result.isEmpty;
          if (!productState.getFirstData && emptyRepositories) {
            change(null, status: RxStatus.empty());
          } else if (productState.getFirstData && emptyRepositories) {
            productState.lastPage.value = true;
          } else {
            productState.getFirstData = true;
            productState.repositories.addAll(result);

            if (result.length < Constants.pageSize)
              productState.lastPage.value = true;

            change(productState.repositories, status: RxStatus.success());
          }
        },
        onError: (err) {
          change(null, status: RxStatus.error(err.toString()));
        },
      );
    }
  }

  Future<void> refreshList() async {
    debugPrint('onRefresh');
    reset();
    await fetchProducts();
  }

  @override
  Future<void> onEndScroll() async {
    if (!productState.lastPage.value) {
      productState.page += 1;
      await fetchProducts();
    }
  }

  @override
  Future<void> onTopScroll() async {
    debugPrint('onTopScroll');
  }
}
