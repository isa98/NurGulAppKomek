import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../app.dart';

class BrandsWidget extends StatelessWidget {
  const BrandsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CategoryController>(
      init: CategoryController(),
      builder: (cc) {
        final bool isLastPage = cc.categoryState.lastPage.value;
        return cc.obx(
          (state) => state != null
              ? RefreshIndicator(
                  onRefresh: cc.refreshList,
                  child: AlignedGridView.count(
                    shrinkWrap: true,
                    controller: cc.scroll,
                    physics: const AlwaysScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    padding: EdgeInsets.fromLTRB(16, 16, 16, Get.bottomBarHeight),
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemCount: cc.categoryState.brands.length + 1,
                    itemBuilder: (context, index) {
                      if (index < state.length) {
                        return InkWell(
                          splashColor: Get.isDarkMode ? ThemeColor.darkSplashColor : ThemeColor.lightSplashColor,
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => cc.onBrandTapped(cc.categoryState.brands[index]),
                          child: SizedBox(
                            height: Get.width * 0.30,
                            width: Get.width * 0.25,
                            child: Card(
                              elevation: 3,
                              color: Get.isDarkMode ? ThemeColor.darkMainColor : const Color(0xFFF8F9FE),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: cachedImageNetwork(
                                cc.categoryState.brands[index].image,
                                BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      } else if (index == state.length && !isLastPage) {
                        return GridViewLoadMoreWidget(index: index);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                )
              : RetryWidget(onRetry: cc.getCategories),
          onLoading: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CustomLoader(),
            ],
          ),
          onEmpty: const NotFoundWidget(),
          onError: (error) => RetryWidget(onRetry: cc.getCategories),
        );
      },
    );
  }
}
