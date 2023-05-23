import '../models.dart';

class OrderVendor {
  late String name;
  late String totalAmount;
  late int totalQuantity;
  late List<OrderItem> items;

  OrderVendor({
    required this.name,
    required this.totalQuantity,
    required this.items,
  });

  static List<OrderVendor> getVendors(Map<String, dynamic> json) {
    List<OrderVendor> vendors = <OrderVendor>[];
    for (final vendorName in json.keys) {
      final value = json[vendorName];

      final vendor = OrderVendor(
        name: vendorName,
        totalQuantity: 0,
        items: <OrderItem>[],
      );

      value['products'].forEach((v) {
        // debugPrint('v $v');
        // vendor.totalQuantity += v['qty_ordered'] as int;
        vendor.items.add(OrderItem.fromJson(v));
      });

      vendors.add(vendor);
    }

    return vendors;
  }
}
