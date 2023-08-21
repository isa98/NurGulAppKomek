import 'package:flutter/material.dart';

import '../../app.dart';

class CategoryApi {
  static const String className = 'CategoryApi';

  static final List<CategoryModel> _categories = [];
  static final List<BrandModel> _brands = [];

  // clear categories when language change
  static resetData() {
    _categories.clear();
    _brands.clear();
  }

  static Future<List<CategoryModel>> getCategories(
      Map<String, dynamic> params) async {
    const fnName = 'getCategories';

    if (_categories.isEmpty) {
      try {
        const String path = '${Constants.baseUrl}/descendant-categories';

        final response =
            await HttpUtil().get(path: path, queryParameters: params);

        List list = response['data'] as List;

        final List<CategoryModel> categories =
            CategoryModel.listFromJson(list.first['children']);

        _categories.addAll(categories);

        return [..._categories];
      } catch (error) {
        debugPrint('$className $fnName error: $error ');
        return [];
      }
    }
    return [..._categories];
  }

  static Future<List<BrandModel>> getBrands(Map<String, dynamic> params) async {
    const fnName = 'getBrands';

    try {
      const String path = '${Constants.baseUrl}/attribute-options';

      final response =
          await HttpUtil().get(path: path, queryParameters: params);

      final List<BrandModel> brands = BrandModel.listFromJson(response['data']);
      _brands.clear();
      _brands.addAll(brands);

      return _brands;
    } catch (error) {
      debugPrint('$className $fnName error: $error ');
      return [];
    }

    // if (_brands.isEmpty) {

    // }
    // return [..._brands];
  }
}
