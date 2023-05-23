import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.dart';
import 'state.dart';

class CategoryController extends GetxController
    with StateMixin<List<BrandModel>>, ScrollMixin, GetTickerProviderStateMixin {
  final categoryState = CategoryState();

  @override
  void onInit() {
    categoryState.tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );

    categoryState.tabController.addListener(_onTabSelected);

    getCategories();
    super.onInit();
  }

  @override
  void onClose() {
    categoryState.tabController.dispose();
    super.onClose();
  }

  Future<void> _onTabSelected() async {
    debugPrint('_onTabSelected');
    if (categoryState.tabController.indexIsChanging) {
      debugPrint('tab is animating. from active (getting the index) to inactive(getting the index) ');
    } else {
      //tab is finished animating you get the current index
      //here you can get your index or run some method once.
      debugPrint('${categoryState.tabController.index}');
      if (categoryState.brands.isEmpty) {
        await _fetchBrands();
      }
    }
  }

  void onBrandTapped(BrandModel brand) {
    debugPrint('brand ${brand.label}, ID: ${brand.id}');
    final Map<String, dynamic> params = {
      'brands': brand.id,
      'title': brand.label,
    };
    Get.toNamed(AppRoutes.productList, arguments: params);
  }

  Future<void> getCategories() async {
    categoryState.isCategoryLoading.value = true;

    categoryState.categories.clear();

    final Map<String, dynamic> params = {
      'locale': await getLocale(),
    };

    final categories = await CategoryApi.getCategories(params);

    categoryState.categories.addAll(categories);

    categoryState.isCategoryLoading.value = false;
  }

  Future<void> _fetchBrands() async {
    final Map<String, dynamic> params = {
      'currency': 'TMT',
      'locale': await getLocale(),
      'page': categoryState.page,
      'limit': Constants.pageSize,
    };

    await CategoryApi.getBrands(params).then(
      (result) {
        final bool emptyRepositories = result.isEmpty;
        if (!categoryState.getFirstData && emptyRepositories) {
          change(null, status: RxStatus.empty());
        } else if (categoryState.getFirstData && emptyRepositories) {
          categoryState.lastPage.value = true;
        } else {
          categoryState.getFirstData = true;
          categoryState.brands.addAll(result);

          if (result.length < Constants.pageSize) categoryState.lastPage.value = true;

          change(categoryState.brands, status: RxStatus.success());
        }
      },
      onError: (err) {
        change(null, status: RxStatus.error(err.toString()));
      },
    );
  }

  void onCategoryTapped(CategoryModel category) {
    debugPrint('onCategoryTapped => ${category.name}');
    final Map<String, dynamic> params = {
      'category': category.id,
      'title': category.name,
    };
    Get.toNamed(AppRoutes.productList, arguments: params);
  }

  void reset() {
    categoryState.brands.clear();
    categoryState.page = 1;
    categoryState.getFirstData = false;
    categoryState.lastPage.value = false;
    change(null, status: RxStatus.loading());
  }

  Future<void> refreshList() async {
    debugPrint('onRefresh');
    reset();
    await _fetchBrands();
  }

  @override
  Future<void> onEndScroll() async {
    if (!categoryState.lastPage.value) {
      categoryState.page += 1;
      await _fetchBrands();
    }
  }

  @override
  Future<void> onTopScroll() async {
    debugPrint('onTopScroll');
  }
}
