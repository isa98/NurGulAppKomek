import 'package:get/get.dart';

import '../../app.dart';

class ProductState {
  LoginStatusController loginStatusController = Get.put(LoginStatusController());

  List<ProductModel> repositories = [];
  int page = 1;
  bool getFirstData = false;
  RxBool lastPage = false.obs;
  RxBool isLoadingMore = false.obs;
}
