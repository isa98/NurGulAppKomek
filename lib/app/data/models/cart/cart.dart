import '../models.dart';

class CartModel {
  late int id;
  String? shippingMethod;
  String? couponCode;
  int? isGift;
  late int itemsCount;
  late int itemsQty;
  late double grandTotal;
  late String formattedGrandTotal;
  late double subTotal;
  late String formattedSubTotal;
  late double discount;
  late String formattedDiscount;
  String? checkoutMethod;
  late List<CartVendor> vendors;

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shippingMethod = json['shipping_method'];
    couponCode = json['coupon_code'];
    isGift = json['is_gift'];
    itemsCount = json['items_count'];
    itemsQty = json['items_qty'];
    grandTotal = json['grand_total'] + .0 ?? 0.0;
    formattedGrandTotal = json['formatted_grand_total'];
    subTotal = json['sub_total'] + .0 ?? 0.0;
    formattedSubTotal = json['formatted_sub_total'];
    discount = json['discount'] + .0 ?? 0.0;
    formattedDiscount = json['formatted_discount'];
    checkoutMethod = json['checkout_method'];
    vendors = CartVendor.getVendors(json['vendors']);
  }
}
