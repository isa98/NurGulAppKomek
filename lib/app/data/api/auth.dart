import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app.dart';

class AuthApi {
  static const String className = 'AuthApi';

  static Future<bool> register(Map<String, dynamic> params) async {
    const String fnName = 'register';

    try {
      debugPrint('class: $className, method: $fnName, params: $params');

      const String path = '${Constants.baseUrl}/customer/register';

      final response = await HttpUtil().post(path, queryParameters: params);
      final token = response['token'];
      final message = response['message'];
      showSnack('general_warning'.tr, message, SnackType.info, 3);

      // set token  to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      prefs.setBool(Constants.isLoggedIn, true);
      prefs.setString(Constants.token, token);

      await User.saveUser(response['data']['first_name'], response['data']['phone']);

      return true;
    } on DioError catch (error) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $error ');

      int? errCode = error.response?.statusCode;
      final String message = error.response?.statusMessage ?? 'reg_phone_already_registered'.tr;

      if (errCode == 422) {
        showSnack('general_warning'.tr, message, SnackType.warning, 3);
      }

      return false;
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName, params: $params, error: $e ');
      showSnack('general_error'.tr, 'general_try_again'.tr, SnackType.error, 3);
      return false;
    }
  }

  static Future<bool> login(Map<String, dynamic> params) async {
    const String fnName = 'login';

    try {
      debugPrint('class: $className, method: $fnName, params: $params');

      const String path = '${Constants.baseUrl}/customer/login';

      final response = await HttpUtil().post(path, queryParameters: params);

      // set token  to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      prefs.setBool(Constants.isLoggedIn, true);
      prefs.setString(Constants.token, response['token']);

      await User.saveUser(response['data']['first_name'], response['data']['phone']);

      return true;
    } on DioError catch (error) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $error ');

      int? errCode = error.response?.statusCode;
      final String message = error.response?.statusMessage ?? 'invalid_credentials'.tr;

      if (errCode == 401 || errCode == 422) {
        showSnack('general_warning'.tr, message, SnackType.warning, 3);
      }
      return false;
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName, params: $params, error: $e ');
      showSnack('general_error'.tr, 'general_try_again'.tr, SnackType.error, 3);
      return false;
    }
  }

  static Future<bool> updateUser(Map<String, dynamic> params) async {
    try {
      const String path = '${Constants.baseUrl}/customer/profile';

      final response = await HttpUtil().put(path, queryParameters: params);
      
      await User.saveUser(response['data']['first_name'], response['data']['phone']);

      showSnack('general_success'.tr, response['message'], SnackType.info, 3);

      return true;
    } catch (error) {
      debugPrint('updateUser error: $error');
      showSnack('general_error'.tr, 'general_try_again'.tr, SnackType.error, 3);
      return false;
    }
  }

  static Future<bool> deleteAccount() async {
    const String fnName = 'deleteAccount';

    try {
      debugPrint('class: $className, method: $fnName');
      const String path = '${Constants.baseUrl}/customer/delete';

      final result = await HttpUtil().delete(path);

      debugPrint('result $result');

      return true;
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName,  error: $e ');
      return false;
    }
  }
}
