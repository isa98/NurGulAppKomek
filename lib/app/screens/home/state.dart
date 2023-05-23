import 'package:get/get.dart';

import '../../app.dart';

class HomeState {
  LoginStatusController loginStatusController = Get.put(LoginStatusController());

  Rxn<HomeModel> homeModel = Rxn<HomeModel>();

  RxBool isLoading = true.obs;
}
