import '../models.dart';

class CartItemModel {
  late int id;
  late int quantity;
  late String name;
  // late String price;
  late String formattedPrice;
  // String? customPrice;
  String? formattedCustomPrice;
  // String? total;
  late String formattedTotal;
  String? discountPercent;
  late double discountAmount;
  String? formattedDiscountAmount;
  String? child;
  late CartOrderProduct product;

  CartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    name = json['name'];
    // price = json['price'] + .0.toString().toString();
    formattedPrice = json['formatted_price'];
    // customPrice = json['custom_price']; //+ .0 ?? 0.0;
    formattedCustomPrice = json['formatted_custom_price'];
    // total = json['total']; // + .0 ?? 0.0;
    formattedTotal = json['formatted_total'];
    discountPercent = json['discount_percent'];
    discountAmount = json['discount_amount'] + .0 ?? 0.0;
    formattedDiscountAmount = json['formatted_discount_amount'];
    child = json['child'];
    product = CartOrderProduct.fromJson(json['product']);
  }
}
