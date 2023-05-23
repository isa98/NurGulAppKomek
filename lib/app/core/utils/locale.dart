import 'package:shared_preferences/shared_preferences.dart';

import 'utils.dart';

Future<String> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString(Constants.locale) ?? 'tm';
}

Future<void> setLocale(String code) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString(Constants.locale, code);
}
