import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nurgul/app/app.dart';
import 'widgets/brands.dart';
import 'widgets/categories.dart';
import '../../../library/library.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Get.isDarkMode ? ThemeColor.darkMainColorLight : ThemeColor.mainColorLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text('cat_categories'.tr.toUpperCase()),
      ),
      body: GetBuilder<CategoryController>(
        init: CategoryController(),
        builder: (cc) {
          return DefaultTabController(
            length: 2,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 8),
                ButtonsTabBar(
                  controller: cc.categoryState.tabController,
                  width: 0.45.sw,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  unselectedBackgroundColor: Theme.of(context).colorScheme.secondary,
                  unselectedLabelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: [
                    Tab(text: 'cat_categories'.tr),
                    Tab(text: 'cat_brands'.tr),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: cc.categoryState.tabController,
                    children: const <Widget>[
                      CategoriesWidget(),
                      BrandsWidget(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
