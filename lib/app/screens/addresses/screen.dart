import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../app.dart';
import 'widgets/address_form.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<AddressController>(
      init: AddressController(),
      builder: (ac) {
        return Scaffold(
          appBar: AppBar(
            leading: const CircleButton(),
            centerTitle: true,
            title: Text('settings_address'.tr.toUpperCase()),
            actions: [
              IconButton(
                onPressed: ac.onAddAddressTapped,
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 28.sp,
                  color: ThemeColor.white,
                ),
              ),
            ],
          ),
          body: LoaderOverlay(
            child: ac.state.isLoading.value
                ? const CustomLoader()
                : ac.state.hasError.value
                    ? RetryWidget(onRetry: ac.fetchAddresses)
                    : ac.state.addresses.isEmpty
                        ? const NotFoundWidget()
                        : ListView.builder(
                            padding: const EdgeInsets.all(16.0),
                            itemCount: ac.state.addresses.length,
                            itemBuilder: (_, index) {
                              final address = ac.state.addresses[index];
                              return Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ThemeColor.dividerColor,
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Icon(Icons.map_rounded, color: Get.theme.colorScheme.primary),
                                  title: Text(
                                    address.address1.first,
                                    style: Get.theme.textTheme.bodyMedium,
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => CustomDialog(
                                          title: 'address_delete_warning_title'.tr.toUpperCase(),
                                          content: 'address_delete_warning_content'.tr,
                                          continueBtnTxt: 'address_delete_approve'.tr,
                                          cancelBtnTxt: 'general_cancel'.tr,
                                          onCancelPressed: () async {
                                            debugPrint('onCancelPressed');
                                            Navigator.of(context, rootNavigator: true).pop();
                                          },
                                          onContinuePressed: () async {
                                            debugPrint('onContinuePressed');
                                            // dismiss dialog
                                            Navigator.of(context, rootNavigator: true).pop();

                                            // delete address
                                            ac.deleteAddress(context, address);
                                          },
                                        ),
                                      );
                                    },
                                    icon: Image.asset(
                                      'assets/icons/delete.png',
                                      // color: ThemeColor.white,
                                      height: 25.h,
                                      width: 25.w,
                                    ), //const Icon(Icons.delete_forever_sharp),
                                  ),
                                  onTap: () {
                                    debugPrint('edit address');
                                    ac.onUpdateTapped(address);
                                    Get.dialog(const AddAddressDialog());
                                  },
                                ),
                              );
                            },
                          ),
          ),
        );
      },
    );
  }
}
