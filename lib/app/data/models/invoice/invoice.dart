import '../models.dart';

class InvoiceModel {
  int? id;
  String? state;
  int? emailSent;
  int? totalQty;
  String? channelCurrencyCode;
  String? orderCurrencyCode;
  String? subTotal;
  String? formatedSubTotal;
  String? grandTotal;
  String? formatedGrandTotal;
  String? shippingAmount;
  String? formatedShippingAmount;
  String? taxAmount;
  String? formatedTaxAmount;
  String? discountAmount;
  String? formatedDiscountAmount;
  InvoiceOrderAddress? orderAddress;
  List<InvoiceItem>? items;
  String? createdAt;

  InvoiceModel({
    this.id,
    this.state,
    this.emailSent,
    this.totalQty,
    this.channelCurrencyCode,
    this.orderCurrencyCode,
    this.subTotal,
    this.formatedSubTotal,
    this.grandTotal,
    this.formatedGrandTotal,
    this.shippingAmount,
    this.formatedShippingAmount,
    this.taxAmount,
    this.formatedTaxAmount,
    this.discountAmount,
    this.formatedDiscountAmount,
    this.orderAddress,
    this.items,
    this.createdAt,
  });

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
    emailSent = json['email_sent'];
    totalQty = json['total_qty'];
    channelCurrencyCode = json['channel_currency_code'];
    orderCurrencyCode = json['order_currency_code'];
    subTotal = json['sub_total'];
    formatedSubTotal = json['formated_sub_total'];
    grandTotal = json['grand_total'];
    formatedGrandTotal = json['formated_grand_total'];
    shippingAmount = json['shipping_amount'];
    formatedShippingAmount = json['formated_shipping_amount'];
    taxAmount = json['tax_amount'];
    formatedTaxAmount = json['formated_tax_amount'];
    discountAmount = json['discount_amount'];
    formatedDiscountAmount = json['formated_discount_amount'];
    orderAddress = json['order_address'] != null ? InvoiceOrderAddress.fromJson(json['order_address']) : null;
    if (json['items'] != null) {
      items = <InvoiceItem>[];
      json['items'].forEach((v) {
        items!.add(InvoiceItem.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }
}
