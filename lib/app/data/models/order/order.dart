import 'package:intl/intl.dart';
import '../models.dart';

class OrderModel {
  late int id;
  late String status;
  late String statusLabel;
  String? channelName;
  int? isGuest;
  String? customerEmail;
  String? customerFirstName;
  String? customerLastName;
  String? shippingMethod;
  String? shippingTitle;
  String? paymentTitle;
  String? shippingDescription;
  String? couponCode;
  int? isGift;
  late int totalItemCount;
  late int totalQtyOrdered;
  String? channelCurrencyCode;
  String? orderCurrencyCode;
  double? grandTotal;
  late String formattedGrandTotal;
  late double totalWeight;
  double? grandTotalInvoiced;
  late String formattedGrandTotalInvoiced;
  double? grandTotalRefunded;
  String? formattedGrandTotalRefunded;
  double? subTotal;
  late String formattedSubTotal;
  double? subTotalInvoiced;
  String? formattedSubTotalInvoiced;
  double? subTotalRefunded;
  String? formattedSubTotalRefunded;
  double? discountPercent;
  late double discountAmount;
  late String formattedDiscountAmount;
  double? discountInvoiced;
  String? formattedDiscountInvoiced;
  double? discountRefunded;
  String? formattedDiscountRefunded;
  double? shippingAmount;
  late String formattedShippingAmount;
  String? shippingInvoiced;
  String? formattedShippingInvoiced;
  String? shippingRefunded;
  String? formattedShippingRefunded;
  late ShippingAddress shippingAddress;
  late BillingAddress billingAddress;
  late List<OrderVendor> vendors;
  late String createdAt;
  late List<InvoiceModel> invoices;

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    statusLabel = json['status_label'];
    channelName = json['channel_name'];
    isGuest = json['is_guest'];
    customerEmail = json['customer_email'];
    customerFirstName = json['customer_first_name'];
    customerLastName = json['customer_last_name'];
    shippingMethod = json['shipping_method'];
    shippingTitle = json['shipping_title'];
    paymentTitle = json['payment_title'];
    shippingDescription = json['shipping_description'];
    couponCode = json['coupon_code'];
    isGift = json['is_gift'];
    totalItemCount = json['total_item_count'];
    totalQtyOrdered = json['total_qty_ordered'];
    channelCurrencyCode = json['channel_currency_code'];
    orderCurrencyCode = json['order_currency_code'];
    grandTotal = json['grand_total'] + .0 ?? 0.0;
    formattedGrandTotal = json['formatted_grand_total'];
    totalWeight = json['total_weight'] + .0 ?? 0.0;
    grandTotalInvoiced = json['grand_total_invoiced'] + .0 ?? 0.0;
    formattedGrandTotalInvoiced = json['formatted_grand_total_invoiced'];
    grandTotalRefunded = json['grand_total_refunded'] + .0 ?? 0.0;
    formattedGrandTotalRefunded = json['formatted_grand_total_refunded'];
    subTotal = json['sub_total'] + .0 ?? 0.0;
    formattedSubTotal = json['formatted_sub_total'];
    subTotalInvoiced = json['sub_total_invoiced'] + .0 ?? 0.0;
    formattedSubTotalInvoiced = json['formatted_sub_total_invoiced'];
    subTotalRefunded = json['sub_total_refunded'] + .0 ?? 0.0;
    formattedSubTotalRefunded = json['formatted_sub_total_refunded'];
    discountPercent = json['discount_percent'] + .0 ?? 0.0;
    discountAmount = json['discount_amount'] + .0 ?? 0.0;
    formattedDiscountAmount = json['formatted_discount_amount'];
    discountInvoiced = json['discount_invoiced'] + .0 ?? 0.0;
    formattedDiscountInvoiced = json['formatted_discount_invoiced'];
    discountRefunded = json['discount_refunded'] + .0 ?? 0.0;
    formattedDiscountRefunded = json['formatted_discount_refunded'];
    shippingAmount = json['shipping_amount'] + .0 ?? 0.0;
    formattedShippingAmount = json['formatted_shipping_amount'];
    shippingInvoiced = json['shipping_invoiced'];
    formattedShippingInvoiced = json['formatted_shipping_invoiced'];
    shippingRefunded = json['shipping_refunded'];
    formattedShippingRefunded = json['formatted_shipping_refunded'];
    shippingAddress = ShippingAddress.fromJson(json['shipping_address']);
    billingAddress = BillingAddress.fromJson(json['billing_address']);
    vendors = OrderVendor.getVendors(json['vendors']);
    createdAt = DateFormat('dd.MM.yyyy').format(DateTime.parse(json['created_at']));
    invoices = <InvoiceModel>[];
    if (json['invoices'] != null) {
      json['invoices'].forEach((v) {
        invoices.add(InvoiceModel.fromJson(v));
      });
    }
  }

  static List<OrderModel> listFromJson(list) => List<OrderModel>.from(list.map((x) => OrderModel.fromJson(x)));
}

class ShippingAddress {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  late List<String> address1;
  String? country;
  String? countryName;
  String? state;
  String? city;
  String? postcode;
  String? phone;

  ShippingAddress({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    required this.address1,
    this.country,
    this.countryName,
    this.state,
    this.city,
    this.postcode,
    this.phone,
  });

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address1 = json['address1'].cast<String>();
    country = json['country'];
    countryName = json['country_name'];
    state = json['state'];
    city = json['city'];
    postcode = json['postcode'];
    phone = json['phone'];
  }
}

class BillingAddress {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  List<String>? address1;
  String? country;
  String? countryName;
  String? state;
  String? city;
  String? postcode;
  String? phone;

  BillingAddress(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.address1,
      this.country,
      this.countryName,
      this.state,
      this.city,
      this.postcode,
      this.phone});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address1 = json['address1'].cast<String>();
    country = json['country'];
    countryName = json['country_name'];
    state = json['state'];
    city = json['city'];
    postcode = json['postcode'];
    phone = json['phone'];
  }
}
