import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.dart';

class CategoryState {
  late TabController tabController;

  final RxBool isCategoryLoading = false.obs;
  final RxBool isCategoryActive = true.obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

  List<BrandModel> brands = [];
  int page = 1;
  bool getFirstData = false;
  RxBool lastPage = false.obs;
  RxBool isLoadingMore = false.obs;
}
