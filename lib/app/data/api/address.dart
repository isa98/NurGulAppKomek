import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../app.dart';

class AddressesApi {
  static String className = 'AddressesApi';

  static List<StateModel> states = [];

  static Future<AddressModel?> create(Map<String, dynamic> params) async {
    try {
      const String path = '${Constants.baseUrl}/customer/addresses';

      final response = await HttpUtil().post(path, data: jsonEncode(params));

      return AddressModel.fromJson(response['data']);
    } catch (error) {
      debugPrint('AddressesApi create error: ${error.toString()}');
      return null;
    }
  }

  static Future<List<AddressModel>?> get() async {
    const String fnName = 'get';

    debugPrint('class: $className, method: $fnName');

    try {
      const String path = '${Constants.baseUrl}/customer/addresses';

      final response = await HttpUtil().get(path: path);

      return AddressModel.listFromJson(response['data']);
    } catch (error) {
      debugPrint('AddressesApi get error: $error');
      return null;
    }
  }

  static Future<AddressModel?> update(Map<String, dynamic> params, int id) async {
    try {
      final String path = '${Constants.baseUrl}/customer/addresses/$id';

      final response = await HttpUtil().put(path, data: jsonEncode(params));

      return AddressModel.fromJson(response['data']);
    } catch (error) {
      debugPrint('AddressesApi updateAddress error: ${error.toString()}');
      return null;
    }
  }

  static Future<bool> delete(int id) async {
    const String fnName = 'delete';
    try {
      String path = '${Constants.baseUrl}/customer/addresses/$id';

      debugPrint('class: $className, method: $fnName, path: $path');

      final response = await HttpUtil().delete(path);

      debugPrint('delete address response $response');

      return true;
    } catch (error) {
      debugPrint('AddressesApi get error: $error');
      return false;
    }
  }
}
