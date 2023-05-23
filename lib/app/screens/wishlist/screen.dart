import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../app.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'favorites_appbar_title'.tr.toUpperCase(),
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Manrope',
            // fontStyle: FontStyle.italic
          ),
        ),
        centerTitle: false,
        actions: const [SearchWidget()],
      ),
      body: GetX<WishlistController>(
        init: WishlistController(),
        builder: (wlc) {
          final bool isLoggedIn = wlc.wishlistState.loginStatusController.loginStatus;

          final bool isLastPage = wlc.wishlistState.lastPage.value;
          return isLoggedIn
              ? LoaderOverlay(
                  useDefaultLoading: false,
                  overlayWidget: const Center(child: CustomLoader()),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: wlc.obx(
                          (state) => state != null
                              ? RefreshIndicator(
                                  onRefresh: wlc.refreshList,
                                  child: AlignedGridView.count(
                                    shrinkWrap: true,
                                    controller: wlc.scroll,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    crossAxisCount: context.isTablet ? 3 : 2,
                                    padding: EdgeInsets.fromLTRB(16, 0, 16, Get.bottomBarHeight),
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 4,
                                    itemCount: wlc.wishlistState.repositories.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index < state.length) {
                                        final item = wlc.wishlistState.repositories[index];
                                        return ProductCard(
                                          model: item.product,
                                          // onAddToCartTapped: () => wlc.onAddToCartTapped(context, item.product),
                                          // onFavoriteTapped: () => wlc.onFavoritesTapped(context, item.product),
                                        );
                                      } else if (index == state.length && !isLastPage) {
                                        return GridViewLoadMoreWidget(index: index);
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    },
                                  ),
                                )
                              : RetryWidget(onRetry: wlc.refreshList),
                          onLoading: const CustomLoader(),
                          onEmpty: const NotFoundWidget(),
                          onError: (error) => RetryWidget(onRetry: wlc.refreshList),
                        ),
                      ),
                    ],
                  ),
                )
              : const LoginWidget();
        },
      ),
    );
  }
}
