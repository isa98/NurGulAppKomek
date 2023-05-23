import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app.dart';

final Widget divider = SizedBox(height: 10.h);

final ddTxtStyle = TextStyle(
  color: ThemeColor.black,
  fontWeight: FontWeight.w400,
  fontSize: 14.sp,
);

class AddAddressDialog extends StatelessWidget {
  const AddAddressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<AddressController>(
      init: AddressController(),
      builder: (ac) {
        final bool isLoading = ac.state.isAddingLoading.value;
        return AlertDialog(
          backgroundColor: ThemeColor.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          titlePadding: EdgeInsets.zero,
          scrollable: true,
          title: Center(
            child: ListTile(
              title: Center(
                child: Text(
                  'settings_address'.tr,
                  style: const TextStyle(color: ThemeColor.black),
                ),
              ),
              subtitle: Center(
                child: Text(
                  'address_address_info'.tr,
                  style: const TextStyle(color: ThemeColor.black),
                ),
              ),
            ),
          ),
          contentPadding: const EdgeInsets.all(16),
          insetPadding: EdgeInsets.zero,
          content: Builder(
            builder: (context) {
              final width = 1.sw - 70;
              return SizedBox(
                width: width > 0 ? width : 1.sw,
                child: Form(
                  key: ac.state.addressForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('address_address'.tr, style: TextStyle(color: ThemeColor.black, fontSize: 16.sp)),
                      divider,
                      MyTextFormField(
                        maxLines: 2,
                        controller: ac.state.addressCtrl,
                        label: 'address_address'.tr,
                        hintText: 'address_hint'.tr,
                      ),
                      SizedBox(height: 30.h),
                      isLoading
                          ? const CustomLoader()
                          : Row(
                              children: [
                                SizedBox(
                                  height: 48.h,
                                  width: width * 0.48,
                                  child: OutlinedButton(
                                    onPressed: () => Navigator.pop(context),
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      side: BorderSide(
                                        width: 2,
                                        color: Get.theme.colorScheme.primary,
                                      ),
                                    ),
                                    child: Text('address_cancel'.tr),
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: width * 0.48,
                                  child: ButtonWidthFull(
                                    title: ac.state.operationType == OperationType.create
                                        ? 'address_add'.tr
                                        : 'address_update'.tr,
                                    callback: () => ac.createUpdateAddress(context),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
