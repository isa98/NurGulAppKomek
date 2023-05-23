import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../app.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key});

  final Map<String, dynamic> params = Get.arguments ?? {'': ''};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CircleButton(),
        title: Image.asset(
          'assets/images/nurgul.png',
          height: 30.sp,
        ),

        /* Text(
          'Nur gül',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Manrope',
            // fontStyle: FontStyle.italic
          ),
        ), */
        centerTitle: false,
        actions: const [SearchWidget()],
      ),
      body: GetX<ProductController>(
          init: ProductController(params),
          builder: (plc) {
            final bool isLastPage = plc.productState.lastPage.value;
            return LoaderOverlay(
              useDefaultLoading: false,
              overlayWidget: const Center(child: CustomLoader()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    child: Text(
                      params['title'] ?? '',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: plc.obx(
                      (state) => state != null
                          ? RefreshIndicator(
                              onRefresh: plc.refreshList,
                              child: AlignedGridView.count(
                                shrinkWrap: true,
                                controller: plc.scroll,
                                physics: const AlwaysScrollableScrollPhysics(),
                                crossAxisCount: context.isTablet ? 3 : 2,
                                padding: EdgeInsets.fromLTRB(8, 0, 8, Get.bottomBarHeight),
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                itemCount: plc.productState.repositories.length + 1,
                                itemBuilder: (context, index) {
                                  if (index < state.length) {
                                    final product = plc.productState.repositories[index];
                                    return ProductCard(model: product);
                                  } else if (index == state.length && !isLastPage) {
                                    return GridViewLoadMoreWidget(index: index);
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                            )
                          : RetryWidget(onRetry: plc.refreshList),
                      onLoading: const Center(child: CustomLoader()),
                      onEmpty: const NotFoundWidget(),
                      onError: (error) => RetryWidget(onRetry: plc.refreshList),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}