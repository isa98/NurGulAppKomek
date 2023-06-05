import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.dart';

class CartApi {
  static String className = 'CartApi';

  static Future<CartModel?> get() async {
    const String fnName = 'get';

    try {
      final Map<String, String> params = {
        'currency': 'TMT',
        'locale': await getLocale(),
      };

      debugPrint('class: $className, method: $fnName , params: $params');

      const String path = '${Constants.baseUrl}/customer/cart';

      final response =
          await HttpUtil().get(path: path, queryParameters: params);

      if (response['data'] == null) return null;

      CartModel cartModel = CartModel.fromJson(response['data']);

      return cartModel;
    } on DioError catch (error) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $error ');

      int? errCode = error.response?.statusCode;

      if (errCode == 401) {
        showSnack(
            'general_warning'.tr, 'general_please_login'.tr, SnackType.warning);
      }

      return null;
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $e ');
      showSnack('general_error'.tr, 'general_error'.tr, SnackType.error);
      return null;
    }
  }

  static Future<CartModel?> add(
      Map<String, dynamic> params, int productId) async {
    const String fnName = 'add';

    try {
      debugPrint('class: $className, method: $fnName , params: $params');

      final String path = '${Constants.baseUrl}/customer/cart/add/$productId';

      final response = await HttpUtil().post(path, queryParameters: params);

      final cartModel = CartModel.fromJson(response['data']);

      showSnack('general_success'.tr, response['message']);

      return cartModel;
    } on DioError catch (error) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $error ');

      int? errCode = error.response?.statusCode;

      if (errCode == 401) {
        // Get.offNamedUntil('/', (route) => false);
        // navigateToLoginScreen();

        showSnack(
            'general_warning'.tr, 'general_please_login'.tr, SnackType.warning);
      }

      if (errCode == 405) {
        showSnack(
            'general_warning'.tr, 'qty_not_available'.tr, SnackType.warning);
      }

      return null;
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $e ');

      showSnack('general_error'.tr, 'general_error'.tr, SnackType.error);
      return null;
    }
  }

  static Future<CartModel?> update(int cartItemId, int quantity) async {
    const String fnName = 'update';

    try {
      final Map<String, dynamic> params = {
        'qty': {
          '$cartItemId': quantity,
        },
        'currency': 'TMT',
      };

      debugPrint('class: $className, method: $fnName , params: $params');

      const String path = '${Constants.baseUrl}/customer/cart/update';

      final response = await HttpUtil().put(path, queryParameters: params);

      CartModel cartModel = CartModel.fromJson(response['data']);

      showSnack('general_success'.tr, 'cart_updated'.tr);

      return cartModel;
    } on DioError catch (error) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $error ');

      int? errCode = error.response?.statusCode;

      if (errCode == 401) {
        showSnack(
            'general_warning'.tr, 'general_please_login'.tr, SnackType.warning);
      }

      return null;
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $e ');
      showSnack('general_error'.tr, 'general_error'.tr, SnackType.error);
      return null;
    }
  }

  static Future<CartModel?> remove(int cartItemId) async {
    const String fnName = 'remove';

    try {
      debugPrint('class: $className, method: $fnName');

      final String path =
          '${Constants.baseUrl}/customer/cart/remove/$cartItemId';

      final response = await HttpUtil().delete(path);

      showSnack('general_success'.tr, 'cart_item_removed_from_card'.tr,
          SnackType.warning);

      if (response['data'] == null) {
        return null;
      }

      return CartModel.fromJson(response['data']);
    } on DioError catch (error) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $error ');

      int? errCode = error.response?.statusCode;

      if (errCode == 401) {
        showSnack(
            'general_warning'.tr, 'general_please_login'.tr, SnackType.warning);
      }

      return null;
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $e ');
      showSnack('general_error'.tr, 'general_error'.tr, SnackType.error);
      return null;
    }
  }

  static Future<List<PaymentMethodModel>?> checkout() async {
    const String fnName = 'checkout';

    List<PaymentMethodModel> list = [];

    try {
      debugPrint('class: $className, method: $fnName');

      const String path = '${Constants.baseUrl}/customer/checkout';

      final response = await HttpUtil().get(path: path);

      final paymentList = response['payment'] as List;

      for (var i = 0; i < paymentList.length; i++) {
        list.add(PaymentMethodModel.fromJson(paymentList[i], i + 1));
      }

      return list;
    } on DioError catch (error) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $error ');

      int? errCode = error.response?.statusCode;

      if (errCode == 401) {
        showSnack(
            'general_warning'.tr, 'general_please_login'.tr, SnackType.warning);
      }

      return null;
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $e ');
      showSnack('general_error'.tr, 'general_error'.tr, SnackType.error);
      return null;
    }
  }

  // delete cart items
  static Future<bool> empty() async {
    const String fnName = 'empty';

    try {
      debugPrint('class: $className, method: $fnName');

      const String path = '${Constants.baseUrl}/customer/cart/empty';

      final response = await HttpUtil().delete(path);

      debugPrint('empty response: $response');

      return true;
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $e ');
      return false;
    }
  }
}
