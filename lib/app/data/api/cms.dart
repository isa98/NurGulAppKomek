import 'package:flutter/material.dart';

import '../../app.dart';

class CMSApi {
  static const String className = 'CMSApi';

  static Future<String> get() async {
    const String fnName = 'get';

    try {
      debugPrint('class: $className, method: $fnName');

      String path = '${Constants.baseUrl}/page-content';

      final Map<String, dynamic> params = {
        'locale': await getLocale(),
        'url': 'about',
      };

      final response = await HttpUtil().post(path, queryParameters: params);

      debugPrint('response $response');

      return response['data']['html_content']; //CMSModel.listFromJson(response['data']);
    } catch (e) {
      debugPrint('ERROR: class: $className, method: $fnName, error: $e ');
      return '';
    }
  }
}
