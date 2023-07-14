

import 'package:shared_preferences/shared_preferences.dart';

class StorageInit {
  static const String isFirstOpen = 'is_first_open';

  static Future<bool> getValue() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    if (sharedPref.containsKey(isFirstOpen)) {
      return sharedPref.getBool(isFirstOpen) ?? true;
    }
    return false;
  }

  static Future<void> clearValue() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    if (sharedPref.containsKey(isFirstOpen)) {
      await sharedPref.remove(isFirstOpen);
    }
  }

  static Future<void> saveNewValue() async {
     SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(isFirstOpen, true);
  }
}
