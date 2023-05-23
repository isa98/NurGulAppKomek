import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app.dart';

class PaymentTypeList extends StatefulWidget {
  final Function(PaymentMethodModel, int?) callback;
  const PaymentTypeList({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  State<PaymentTypeList> createState() => _PaymentTypeListState();
}

class _PaymentTypeListState extends State<PaymentTypeList> {
  // int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return GetX<CartController>(
      init: CartController(),
      builder: (cc) => Container(
        decoration: BoxDecoration(
          color: Get.isDarkMode ? const Color(0xFF000000) : const Color(0xFFF8F9FE),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 8),
              child: Text(
                'cart_payment_type_title'.tr,
                style: Get.theme.textTheme.titleMedium,
              ),
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final method = cc.state.paymentMethods[index];
                return RadioListTile(
                  title: Text(
                    method.methodTitle,
                    style: TextStyle(
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                  subtitle: Text(method.description),
                  activeColor: Get.theme.colorScheme.primary,
                  value: method.id,
                  groupValue: cc.state.selectedPaymentIndex.value,
                  onChanged: (int? value) {
                    widget.callback(method, value);
                  },
                );
              },
              itemCount: cc.state.paymentMethods.length,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
