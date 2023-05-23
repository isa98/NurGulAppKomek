import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../app.dart';

class User {
  late String firstName;
  late String phone;

  User({required this.firstName, required this.phone});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    phone = '+993 ${json['phone']}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['phone'] = phone;
    return data;
  }

  static Future<void> saveUser(String firstName, String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final User user = User(firstName: firstName, phone: phone);

    String userStr = jsonEncode(user);
    prefs.setString(Constants.user, userStr);
  }

  static Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? userStr = prefs.getString(Constants.user);

    if (isNullOrEmpty(userStr)) return null;

    Map<String, dynamic> userMap = jsonDecode(userStr ?? '');
    User user = User.fromJson(userMap);

    return user;
  }
}
