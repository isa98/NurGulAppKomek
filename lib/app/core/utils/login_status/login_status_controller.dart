import 'package:get/get.dart';

class LoginStatusController extends GetxController {
  final RxBool _loginStatus = false.obs;
  set loginStatus(value) => _loginStatus.value = value;
  bool get loginStatus => _loginStatus.value;
}
