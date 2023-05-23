class ShippingRateModel {
  late int id;
  late String carrier;
  late String carrierTitle;
  late String method;
  late String methodTitle;
  late String methodDescription;
  late double price;
  late String formattedPrice;
  // late double basePrice;
  // late int cartAddressId;

  ShippingRateModel({
    required this.id,
    required this.carrier,
    required this.carrierTitle,
    required this.method,
    required this.methodTitle,
    required this.methodDescription,
    required this.price,
    required this.formattedPrice,
    // required this.basePrice,
    // required this.cartAddressId,
  });

  ShippingRateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carrier = json['carrier'];
    carrierTitle = json['carrier_title'];
    method = json['method'];
    methodTitle = json['method_title'];
    methodDescription = json['method_description'];
    price = json['price'] + .0 ?? 0.0;
    formattedPrice = json['formatted_price'] ?? '';
    // basePrice = json['base_price'] + .0 ?? 0.0;
    // cartAddressId = json['cart_address_id'];
  }
}
