import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.dart';

class AddressesState {
  RxBool isLoading = false.obs;
  RxBool isAddingLoading = false.obs;
  RxBool hasError = false.obs;

  RxList<AddressModel> addresses = <AddressModel>[].obs;

  final addressForm = GlobalKey<FormState>();
  final TextEditingController addressCtrl = TextEditingController();

  OperationType operationType = OperationType.create;

  AddressModel? tmpAddress;
}
