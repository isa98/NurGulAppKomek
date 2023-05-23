import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CategoryController>(
      init: CategoryController(),
      builder: (cc) {
        return cc.categoryState.isCategoryLoading.value
            ? const CustomLoader()
            : ListView.builder(
                itemCount: cc.categoryState.categories.length,
                itemBuilder: (context, index) {
                  final category = cc.categoryState.categories[index];
                  return Container(
                    margin: EdgeInsets.only(top: 16, left: 0.035.sw, right: 0.035.sw),
                    child: Material(
                      type: MaterialType.transparency,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Get.isDarkMode ? ThemeColor.darkMainColor : const Color.fromARGB(255, 229, 235, 230),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: InkWell(
                          splashColor: Get.isDarkMode ? ThemeColor.darkSplashColor : ThemeColor.lightSplashColor,
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => cc.onCategoryTapped(category),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                            leading: cachedImageNetwork(
                              category.categoryIconPath,
                              BoxFit.scaleDown,
                              BorderRadius.circular(16),
                              40.sp,
                              40.sp,
                            ),
                            title: Text(category.name, style: Theme.of(context).textTheme.titleMedium),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 18.sp,
                              color: const Color(0xFF8F9098),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
