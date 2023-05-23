import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app.dart';
import 'address_list.dart';
import 'payment_type_list.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<CartController>(
          builder: (cc) {
            return Column(
              children: [
                AddressList(
                  callback: (address, selectedIndex) => cc.onAddressSelected(context, address, selectedIndex),
                  cc: cc,
                ),
                const SizedBox(height: 20),
                PaymentTypeList(
                  callback: (method, selectedIndex) => cc.onPaymentTypeSelected(context, method, selectedIndex),
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
