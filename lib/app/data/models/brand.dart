class BrandModel {
  late int id;
  late String adminName;
  late String label;
  late String image;

  BrandModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminName = json['admin_name'];
    label = json['label'];
    image = json['image'];
  }

  static List<BrandModel> listFromJson(list) => List<BrandModel>.from(list.map((x) => BrandModel.fromJson(x)));
}
