import 'package:flutter/material.dart';

import '../../app.dart';

class HomeApi {
  static const String className = 'HomeApi';

  static HomeModel? model;

  static void resetModel() {
    model = null;
  }

  static Future<HomeModel?> get() async {
    const String fnName = 'get';

    // if (!isNullOrEmpty(model)) return model;

    try {
      final Map<String, String> params = {
        'currency': 'TMT',
        'locale': await getLocale(),
      };

      debugPrint('class: $className, method: $fnName , params: $params');

      const String path = '${Constants.baseUrl}/home';

      final response =
          await HttpUtil().get(path: path, queryParameters: params);

      if (response['data'] == null) return null;

      HomeModel homeModel = HomeModel.fromJson(response['data']);

      model = homeModel;

      return homeModel;
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $e ');
      return null;
    }
  }
}
