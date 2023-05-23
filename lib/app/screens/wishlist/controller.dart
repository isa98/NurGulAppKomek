// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.dart';

import 'state.dart';

class WishlistController extends GetxController with StateMixin<List<WishlistModel>>, ScrollMixin {
  final wishlistState = WishlistState();

  @override
  void onInit() {
    _fetchWishlist();

    super.onInit();
  }

  @override
  void dispose() {
    debugPrint('WishlistController dispose');
    super.dispose();
  }

  void reset() {
    wishlistState.repositories.clear();
    wishlistState.page = 1;
    wishlistState.getFirstData = false;
    wishlistState.lastPage.value = false;
    change(null, status: RxStatus.loading());
  }

  Future<void> _fetchWishlist() async {
    debugPrint('fetchWishlist');

    if (!wishlistState.loginStatusController.loginStatus) return;

    final Map<String, dynamic> params = {
      'currency': 'TMT',
      'locale': await getLocale(),
      'page': wishlistState.page,
      'limit': Constants.pageSize,
    };

    await WishlistApi.get(params).then(
      (result) {
        final bool emptyRepositories = result.isEmpty;
        if (!wishlistState.getFirstData && emptyRepositories) {
          change(null, status: RxStatus.empty());
        } else if (wishlistState.getFirstData && emptyRepositories) {
          wishlistState.lastPage.value = true;
        } else {
          wishlistState.getFirstData = true;
          wishlistState.repositories.addAll(result);

          if (result.length < Constants.pageSize) wishlistState.lastPage.value = true;

          change(wishlistState.repositories, status: RxStatus.success());
        }
      },
      onError: (err) {
        change(null, status: RxStatus.error(err.toString()));
      },
    );
  }

  Future<void> refreshList() async {
    debugPrint('onRefresh');
    reset();
    await _fetchWishlist();
  }

  @override
  Future<void> onEndScroll() async {
    if (!wishlistState.lastPage.value) {
      wishlistState.page += 1;
      await _fetchWishlist();
    }
  }

  @override
  Future<void> onTopScroll() async {
    debugPrint('onTopScroll');
  }
}
