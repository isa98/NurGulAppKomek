class InvoiceItem {
  int? id;
  String? name;
  String? description;
  String? sku;
  int? qty;
  String? price;
  String? formatedPrice;
  String? total;
  String? formatedTotal;
  String? taxAmount;
  String? formatedTaxAmount;
  double? grandTotal;
  String? formatedGrandTotal;

  InvoiceItem({
    this.id,
    this.name,
    this.description,
    this.sku,
    this.qty,
    this.price,
    this.formatedPrice,
    this.total,
    this.formatedTotal,
    this.taxAmount,
    this.formatedTaxAmount,
    this.grandTotal,
    this.formatedGrandTotal,
  });

  InvoiceItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    sku = json['sku'];
    qty = json['qty'];
    price = json['price'];
    formatedPrice = json['formated_price'];
    total = json['total'];
    formatedTotal = json['formated_total'];
    taxAmount = json['tax_amount'];
    formatedTaxAmount = json['formated_tax_amount'];
    grandTotal = json['grand_total'] + .0 ?? 0.0;
    formatedGrandTotal = json['formated_grand_total'];
  }
}
