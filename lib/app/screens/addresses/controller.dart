// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../app.dart';
import 'state.dart';
import 'widgets/address_form.dart';

class AddressController extends GetxController {
  final state = AddressesState();

  @override
  void onInit() {
    debugPrint('AddressController onInit');
    fetchAddresses();
    super.onInit();
  }

  @override
  void onClose() {
    state.addressCtrl.dispose();
    super.onClose();
  }

  Future<void> fetchAddresses() async {
    state.isLoading.value = true;

    state.addresses.clear();

    final List<AddressModel>? addressList = await AddressesApi.get();
    state.isLoading.value = false;

    if (addressList == null) {
      state.hasError.value = true;
      return;
    }

    state.addresses.addAll(addressList);
  }

  void onAddAddressTapped() {
    debugPrint('onAddAddressTapped');
    // clear data
    state.tmpAddress = null;
    state.addressCtrl.text = '';

    // set OperationType
    state.operationType = OperationType.create;

    Get.dialog(const AddAddressDialog());
  }

  void onUpdateTapped(AddressModel address) {
    state.tmpAddress = address;
    state.addressCtrl.text = address.address1.first;
    state.operationType = OperationType.update;
  }

  Future<void> createUpdateAddress(BuildContext context) async {
    // validate form
    if (!state.addressForm.currentState!.validate()) return;

    state.isAddingLoading.value = true;

    List<String> addresses1 = [state.addressCtrl.text];

    final Map<String, dynamic> params = {
      'locale': await getLocale(),
      'address1': addresses1,
      'city': 'Ashgabat',
    };

    AddressModel? result;

    if (state.operationType == OperationType.create) {
      result = await AddressesApi.create(params);
    } else {
      if (state.tmpAddress != null) {
        result = await AddressesApi.update(params, state.tmpAddress!.id);
      }
    }

    state.isAddingLoading.value = false;

    if (result == null) {
      // dismiss dialogue
      Navigator.pop(context);

      showSnack('general_error'.tr, 'general_error'.tr, SnackType.error);
      return;
    }

    if (state.operationType == OperationType.create) {
      state.addresses.add(result);
    } else {
      // update address
      state.addresses[state.addresses.indexWhere((a) => a.id == state.tmpAddress!.id)] = result;
    }

    // reset text
    state.addressCtrl.text = '';

    showSnack('general_success'.tr, 'address_success_message'.tr);

    // dismiss dialogue
    Navigator.pop(context);
  }

  Future<void> deleteAddress(BuildContext context, AddressModel address) async {
    debugPrint('deleteAddress id: ${address.id}');

    context.loaderOverlay.show();

    final result = await AddressesApi.delete(address.id);

    context.loaderOverlay.hide();

    if (result) {
      state.addresses.removeWhere((a) => a.id == address.id);
      state.addresses.refresh();
    } else {
      showSnack('general_error'.tr, 'general_error'.tr, SnackType.error);
    }
  }
}
