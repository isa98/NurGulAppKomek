import 'package:flutter/material.dart';

import '../../app.dart';

class ProductApi {
  static String className = 'ProductApi';

  static Future<List<ProductModel>> get(Map<String, dynamic> params) async {
    const String fnName = 'get';

    try {
      debugPrint('class: $className, method: $fnName, params: $params');

      String path = '${Constants.baseUrl}/products';

      final response = await HttpUtil().get(path: path, queryParameters: params);

      return ProductModel.listFromJson(response['data'] as List);
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName, params: $params, error: $e ');
      throw Exception('Error occurred');
    }
  }

  static Future<List<ProductModel>> search(Map<String, dynamic> params) async {
    const String fnName = 'search';

    try {
      debugPrint('class: $className, method: $fnName, params: $params');

      String path = '${Constants.baseUrl}/products-search';

      final response = await HttpUtil().get(path: path, queryParameters: params);

      return ProductModel.listFromJson(response['data'] as List);
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName, params: $params, error: $e ');
      throw Exception('Error occurred');
    }
  }

  static Future<List<ProductModel>> getRelatedProducts(int productId) async {
    const String fnName = 'getRelatedProducts';

    try {
      debugPrint('class: $className, method: $fnName');

      String path = '${Constants.baseUrl}/products/related/$productId';

      final response = await HttpUtil().get(path: path);

      return ProductModel.listFromJson(response['data'] as List);
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName,  error: $e ');
      throw Exception('Error occurred');
    }
  }
}
