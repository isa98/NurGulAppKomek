class PaymentMethodModel {
  late int id;
  late String method;
  late String methodTitle;
  late String description;

  PaymentMethodModel.fromJson(Map<String, dynamic> json, int index) {
    id = index;
    method = json['method'];
    methodTitle = json['method_title'];
    description = json['description'];
  }
}
