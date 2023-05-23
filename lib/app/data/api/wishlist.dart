import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../app.dart';
import 'package:flutter/material.dart';

class WishlistApi {
  static String className = 'WishlistApi';

  static Future<List<WishlistModel>> get(Map<String, dynamic> params) async {
    const String fnName = 'get';

    try {
      String path = '${Constants.baseUrl}/customer/wishlist';

      debugPrint('class: $className, method: $fnName, $path');

      final response = await HttpUtil().get(path: path, queryParameters: params);

      return WishlistModel.listFromJson(response['data'] as List);
    } on DioError catch (error) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $error ');

      int? errCode = error.response?.statusCode;

      if (errCode == 401) {
        showSnack('general_warning'.tr, 'general_please_login'.tr, SnackType.warning);
      }

      return throw Exception('Error occurred login');
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName');
      showSnack('general_error'.tr, 'general_error'.tr, SnackType.error);
      throw Exception('Error occurred');
    }
  }

  // add and remove from wishlist
  static Future<bool> addRemove(int productId) async {
    const String fnName = 'addRemove';

    try {
      String path = '${Constants.baseUrl}/customer/wishlist/$productId';

      debugPrint('class: $className, method: $fnName $path');

      final response = await HttpUtil().post(
        path,
        queryParameters: {
          'locale': await getLocale(),
        },
      );

      showSnack('general_success'.tr, response['message']);
      return true;
    } on DioError catch (error) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $error ');

      int? errCode = error.response?.statusCode;

      if (errCode == 401) {
        showSnack('general_warning'.tr, 'general_please_login'.tr, SnackType.warning);
      }

      return false;
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName');
      showSnack('general_error', 'can_not_add_item_to_wishlist'.tr, SnackType.error);
      return false;
    }
  }
}
