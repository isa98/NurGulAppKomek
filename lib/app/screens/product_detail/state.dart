import 'package:get/get.dart';

import '../../app.dart';

class ProductDetailState {
  RxBool isWishlistTapped = false.obs;

  RxBool isLoading = false.obs;
  RxInt quantity = 1.obs;
  RxList<ProductModel> relatedProducts = <ProductModel>[].obs;

  // tis is used to update fav icon when status changes
  Rxn<ProductModel> product = Rxn<ProductModel>();

  final int minItemQuantity = 2;
}
