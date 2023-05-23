import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.dart';

class OrdersApi {
  static String className = 'OrdersApi';

  static Future<List<OrderModel>> get(Map<String, dynamic> params) async {
    const String fnName = 'get';

    try {
      debugPrint('class: $className, method: $fnName , params: $params');

      const String path = '${Constants.baseUrl}/customer/orders';

      final response = await HttpUtil().get(path: path, queryParameters: params);

      return OrderModel.listFromJson(response['data'] as List);
    } on DioError catch (error) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $error ');

      int? errCode = error.response?.statusCode;

      if (errCode == 401) {
        showSnack('general_warning'.tr, 'general_please_login'.tr, SnackType.warning);
      }

      throw Exception('Error occurred');
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $e ');
      showSnack('general_error'.tr, 'general_error'.tr, SnackType.error);
      throw Exception('Error occurred');
    }
  }

  static Future<bool> saveOrder(Map<String, dynamic> params) async {
    const String fnName = 'saveOrder';

    try {
      debugPrint('class: $className, method: $fnName, params: $params');

      String path = '${Constants.baseUrl}/customer/checkout/save-order';

      final response = await HttpUtil().post(path, queryParameters: params);

      final status = response['data']['status'];
      // show api message
      if (status) {
        if (!isNullOrEmpty(response['message'])) showSnack('general_success'.tr, response['message'], SnackType.info);
      } else {
        if (!isNullOrEmpty(response['message'])) showSnack('general_error'.tr, response['message'], SnackType.error);
      }

      return true;
    } on DioError catch (error) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $error ');

      int? errCode = error.response?.statusCode;

      if (errCode == 401) {
        Get.offNamedUntil('/', (route) => false);
        navigateToLoginScreen();
        showSnack('general_warning'.tr, 'general_please_login'.tr, SnackType.warning);
      }
      return false;
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName, params: $params, error: $e ');
      showSnack('general_error'.tr, 'general_error'.tr, SnackType.error);
      return false;
    }
  }

  static Future<bool> cancelOrder(int orderId) async {
    const String fnName = 'cancel';

    try {
      debugPrint('class: $className, method: $fnName');

      String path = '${Constants.baseUrl}/customer/orders/$orderId/cancel';

      await HttpUtil().post(path);

      return true;
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $e ');
      return false;
    }
  }

  static Future<bool> saveShipping(Map<String, dynamic> params) async {
    const String fnName = 'saveShipping';

    try {
      debugPrint('class: $className, method: $fnName, params: $params');

      String path = '${Constants.baseUrl}/customer/checkout/save-shipping';

      final response = await HttpUtil().post(path, data: params);
      showSnack('general_success'.tr, response['message'], SnackType.info);

      return true;
    } on DioError catch (error) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $error ');

      int? errCode = error.response?.statusCode;

      if (errCode == 401) {
        Get.offNamedUntil('/', (route) => false);
        navigateToLoginScreen();
        showSnack('general_warning'.tr, 'general_please_login'.tr, SnackType.warning);
      }
      return false;
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName, params: $params, error: $e ');
      // showSnack('general_error'.tr, 'general_error'.tr, SnackType.info);
      return false;
    }
  }

  static Future<bool> savePayment(Map<String, dynamic> params) async {
    const String fnName = 'savePayment';

    try {
      debugPrint('class: $className, method: $fnName, params: $params');

      String path = '${Constants.baseUrl}/customer/checkout/save-payment';

      final response = await HttpUtil().post(path, queryParameters: params);
      showSnack('general_success'.tr, response['message'], SnackType.info);

      return true;
    } on DioError catch (error) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $error ');

      int? errCode = error.response?.statusCode;

      if (errCode == 401) {
        Get.offNamedUntil('/', (route) => false);
        navigateToLoginScreen();
        showSnack('general_warning'.tr, 'general_please_login'.tr, SnackType.warning);
      }
      return false;
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName, params: $params, error: $e ');
      showSnack('general_error'.tr, 'general_error'.tr, SnackType.error);
      return false;
    }
  }
}
