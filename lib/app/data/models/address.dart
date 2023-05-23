class AddressModel {
  late int id;
  late List<String> address1;
  late bool isDefault;

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address1 = json['address1'].cast<String>();
    isDefault = json['isDefault'] ?? false;
  }

  static List<AddressModel> listFromJson(list) => List<AddressModel>.from(list.map((x) => AddressModel.fromJson(x)));
}
