
import '../models.dart';
import 'cart_item.dart';

class CartVendor {
  late String name;
  late String totalAmount;
  late int totalQuantity;
  late List<CartItemModel> items;

  CartVendor({
    required this.name,
    required this.totalAmount,
    required this.totalQuantity,
    required this.items,
  });

  static List<CartVendor> getVendors(Map<String, dynamic> json) {
    List<CartVendor> vendors = <CartVendor>[];
    for (final vendorName in json.keys) {
      final value = json[vendorName];

      final vendor = CartVendor(
        name: vendorName,
        totalAmount: '',
        totalQuantity: 0,
        items: <CartItemModel>[],
      );

      value.forEach((v) {
        vendor.totalQuantity += v['quantity'] as int;
        vendor.items.add(CartItemModel.fromJson(v));
      });

      vendors.add(vendor);
    }

    return vendors;
  }
}
