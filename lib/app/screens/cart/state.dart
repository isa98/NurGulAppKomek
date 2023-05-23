import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.dart';

class CartState {
  RxBool isLoading = false.obs;
  RxBool isOrdered = false.obs;
  RxBool isCheckoutLoading = false.obs;

  Rxn<CartModel?> cartModel = Rxn<CartModel>();

  LoginStatusController loginStatusController = Get.put(LoginStatusController());

  RxList<PaymentMethodModel> paymentMethods = <PaymentMethodModel>[].obs;
  Rxn<PaymentMethodModel> selectedPaymentMethod = Rxn<PaymentMethodModel>();

  TextEditingController noteCtrl = TextEditingController();

  // validations
  RxInt selectedAddressIndex = 0.obs;
  RxInt selectedPaymentIndex = 0.obs;
}
