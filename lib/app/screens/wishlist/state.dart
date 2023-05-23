import 'package:get/get.dart';

import '../../app.dart';

class WishlistState {
  LoginStatusController loginStatusController = Get.put(LoginStatusController());

  RxList<WishlistModel> repositories = <WishlistModel>[].obs;
  int page = 1;
  bool getFirstData = false;
  RxBool lastPage = false.obs;
  RxBool isLoadingMore = false.obs;
}
