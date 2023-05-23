import 'package:get/get.dart';

import 'login_status_controller.dart';

class LoginStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginStatusController>(
      LoginStatusController(),
      permanent: true,
    );
  }
}
