import 'package:get/get.dart';

import 'controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    // Get.lazyPut<HomeController>(() => HomeController());
    // Get.put<CategoryController>(
    //   CategoryController(),
    //   permanent: true,
    // );
  }
}
