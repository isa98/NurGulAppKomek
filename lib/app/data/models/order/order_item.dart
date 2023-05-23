import '../models.dart';

class OrderItem {
  late int id;
  late String sku;
  late String type;
  late String name;
  late CartOrderProduct product;
  String? couponCode;
  late double weight;
  late double totalWeight;
  late int qtyOrdered;
  late int qtyCanceled;
  late int qtyInvoiced;
  late int qtyShipped;
  late int qtyRefunded;
  late double price;
  late String formattedPrice;
  late double total;
  late String formattedTotal;
  late double totalInvoiced;
  late String formattedTotalInvoiced;
  late double amountRefunded;
  late String formattedAmountRefunded;
  late double discountPercent;
  late double discountAmount;
  late String formattedDiscountAmount;
  late double discountInvoiced;
  late String formattedDiscountInvoiced;
  late double discountRefunded;
  late String formattedDiscountRefunded;
  late double grantTotal;
  late String formattedGrantTotal;



  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    type = json['type'];
    name = json['name'];
    product =  CartOrderProduct.fromJson(json['product']);
    couponCode = json['coupon_code'];
    weight = json['weight'] + .0 ?? 0.0;
    totalWeight = json['total_weight'] + .0 ?? 0.0;
    qtyOrdered = json['qty_ordered'];
    qtyCanceled = json['qty_canceled'];
    qtyInvoiced = json['qty_invoiced'];
    qtyShipped = json['qty_shipped'];
    qtyRefunded = json['qty_refunded'];
    price = json['price'] + .0 ?? 0.0;
    formattedPrice = json['formatted_price'];
    total = json['total'] + .0 ?? 0.0;
    formattedTotal = json['formatted_total'];
    totalInvoiced = json['total_invoiced'] + .0 ?? 0.0;
    formattedTotalInvoiced = json['formatted_total_invoiced'];
    amountRefunded = json['amount_refunded'] + .0 ?? 0.0;
    formattedAmountRefunded = json['formatted_amount_refunded'];
    discountPercent = json['discount_percent'] + .0 ?? 0.0;
    discountAmount = json['discount_amount'] + .0 ?? 0.0;
    formattedDiscountAmount = json['formatted_discount_amount'];
    discountInvoiced = json['discount_invoiced'] + .0 ?? 0.0;
    formattedDiscountInvoiced = json['formatted_discount_invoiced'];
    discountRefunded = json['discount_refunded'] + .0 ?? 0.0;
    formattedDiscountRefunded = json['formatted_discount_refunded'];
    grantTotal = json['grant_total'] + .0 ?? 0.0;
    formattedGrantTotal = json['formatted_grant_total'];
  }
}
