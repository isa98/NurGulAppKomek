class BrandModel {
  late int id;
  late String shopTitle;
  late String logo;

  BrandModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopTitle = json['shop_title'];
    logo = json['logo'];
  }

  static List<BrandModel> listFromJson(list) => List<BrandModel>.from(list.map((x) => BrandModel.fromJson(x)));
}
