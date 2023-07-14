import 'package:get/get.dart';
import 'package:nurgul/app/screens/splash/screen.dart';

import '../../app.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const Dashboard(),
      bindings: [
        DashboardBinding(),
        CategoryBinding(),
        LoginStatusBinding(),
      ],
    ),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.register, page: () => const RegisterScreen()),
    GetPage(name: AppRoutes.productList, page: () => ProductListScreen()),
    GetPage(name: AppRoutes.orders, page: () => const OrdersScreen()),
    GetPage(name: AppRoutes.addresses, page: () => const AddressesScreen()),
    GetPage(name: AppRoutes.cms, page: () => const CMSScreen()),
    GetPage(name: AppRoutes.privacy, page: () => const PrivacyPolicyScreen()),
    GetPage(
        name: AppRoutes.deliveryAndPayment,
        page: () => const DeliveryAndPaymentScreen()),
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
  ];
}
