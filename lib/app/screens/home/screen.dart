import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller.dart';

import '../../app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/nurgul.png',
          height: 30.sp,
        ),
        // title: Text(
        //   'Nur gul',
        //   style: TextStyle(
        //     fontSize: 18.sp,
        //     fontWeight: FontWeight.bold,
        //     fontFamily: 'Manrope',
        //     // fontStyle: FontStyle.italic
        //   ),
        // ),
        centerTitle: false,
        actions: const [SearchWidget()],
      ),
      body: GetX<HomeController>(
        init: HomeController(),
        builder: (hc) {
          final HomeModel? model = hc.state.homeModel.value;
          return hc.state.isLoading.value
              ? const CustomLoader()
              : isNullOrEmpty(model)
                  ? RetryWidget(onRetry: hc.get)
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 0.25.sh,
                            child: CarouselSlider(
                              sliders: hc.state.homeModel.value!.sliders.map((s) => s.imageUrl).toList(),
                              onSliderTapped: (index) {
                                final String sliderPath = hc.state.homeModel.value!.sliders[index].sliderPath;
                                hc.navigateToProductList(sliderPath);
                              },
                            ),
                          ),
                          ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: model!.productSections.length,
                            itemBuilder: (ctx, i) {
                              final ProductSection section = model.productSections[i];
                              return section.type == 'product'
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                section.title,
                                                style: Get.theme.textTheme.titleMedium,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () => hc.onShowAllTapped(section),
                                              child: Text(
                                                'home_all'.tr.toUpperCase(),
                                                style: Get.theme.textTheme.titleMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          physics: const BouncingScrollPhysics(),
                                          child: Row(
                                            children: section.items.map((p) {
                                              final product = p as ProductModel;
                                              return SizedBox(
                                                width: 200.w,
                                                child: ProductCard(model: product),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        SizedBox(
                                          height: 0.22.sh,
                                          child: CarouselSlider(
                                            sliders: section.items.map((s) => s.imageUrl as String).toList(),
                                            onSliderTapped: (index) {
                                              final String sliderPath = section.items[index].sliderPath;
                                              hc.navigateToProductList(sliderPath);
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    );
                            },
                          ),
                        ],
                      ),
                    );
        },
      ),
    );
  }
}
