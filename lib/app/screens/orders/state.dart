import 'package:get/get.dart';

import '../../app.dart';

class OrdersState {
  List<OrderModel> repositories = [];
  int page = 1;
  bool getFirstData = false;
  RxBool lastPage = false.obs;
  RxBool isLoadingMore = false.obs;
}
