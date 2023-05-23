import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../app.dart';

// Icons path
const String assetPath = 'assets/navbar_icons/';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('DASHBOARD PAGE');
    return GetX<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            top: false,
            child: IndexedStack(
              index: controller.tabIndex.value,
              children: [
                controller.tabIndex.value == BottomNavbar.home.index ? const HomeScreen() : Container(),
                controller.tabIndex.value == BottomNavbar.categories.index ? const CategoriesScreen() : Container(),
                controller.tabIndex.value == BottomNavbar.cart.index ? const CartScreen() : Container(),
                controller.tabIndex.value == BottomNavbar.wishlist.index ? const WishlistScreen() : Container(),
                controller.tabIndex.value == BottomNavbar.settings.index ? const SettingsScreen() : Container(),
              ],
            ),
          ),
          bottomNavigationBar: SizeTransition(
            sizeFactor: controller.animationController,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: ThemeColor.grey, width: 0.35),
                ),
              ),
              child: BottomNavigationBar(
                onTap: controller.changeTabIndex,
                currentIndex: controller.tabIndex.value,
                type: BottomNavigationBarType.fixed,
                // showSelectedLabels: false,
                // showUnselectedLabels: false,
                items: _getBottomNavbarItems(controller),
              ),
            ),
          ),
        );
      },
    );
  }

  List<BottomNavigationBarItem> _getBottomNavbarItems(DashboardController dc) {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        icon: Icon(UniconsLine.estate, size: 25.sp),
        label: 'nav_home'.tr,
      ),
      BottomNavigationBarItem(
        icon: Icon(UniconsLine.layer_group, size: 25.sp),
        label: 'nav_category'.tr,
      ),
      BottomNavigationBarItem(
        icon: isNullOrEmpty(dc.cart) || isNullOrEmpty(dc.cart!.value)
            ? Icon(UniconsLine.shopping_basket, size: 25.sp)
            : Badge(
                label: Text(dc.cart!.value!.itemsCount.toString()),
                child: Icon(UniconsLine.shopping_basket, size: 25.sp),
              ),
        label: 'nav_cart'.tr,
      ),
      BottomNavigationBarItem(
        icon: Icon(UniconsLine.heart_alt, size: 25.sp),
        label: 'nav_fav'.tr,
      ),
      BottomNavigationBarItem(
        icon:  Icon(UniconsLine.setting, size: 25.sp),
        label: 'nav_settings'.tr,
      ),
    ];
    return items;
  }
}
