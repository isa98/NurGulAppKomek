import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app.dart';
import '../../addresses/widgets/address_form.dart';

class AddressList extends StatefulWidget {
  final Function(AddressModel, int?) callback;
  final CartController cc;
  const AddressList({
    Key? key,
    required this.callback,
    required this.cc,
  }) : super(key: key);

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  // int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return GetX<AddressController>(
      init: AddressController(),
      builder: (ac) => Container(
        decoration: BoxDecoration(
          color: Get.isDarkMode ? const Color(0xFF000000) : const Color(0xFFF8F9FE),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ac.state.isLoading.value
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: CustomLoader(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 8),
                    child: Text(
                      'cart_select_address'.tr,
                      style: Get.theme.textTheme.titleMedium,
                    ),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final address = ac.state.addresses[index];
                      return RadioListTile(
                        title: Text(
                          address.address1.first,
                          style: TextStyle(
                            color: Get.theme.colorScheme.primary,
                          ),
                        ),
                        activeColor: Get.theme.colorScheme.primary,
                        value: address.id,
                        groupValue: widget.cc.state.selectedAddressIndex.value,
                        onChanged: (int? value) {
                          widget.callback(address, value);
                        },
                      );
                    },
                    itemCount: ac.state.addresses.length,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ButtonWidthFull(
                      title: 'cart_add_address'.tr,
                      callback: () {
                        Get.dialog(const AddAddressDialog());
                        ac.state.addresses.refresh();
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
