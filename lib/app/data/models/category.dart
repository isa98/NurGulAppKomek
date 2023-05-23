class CategoryModel {
  late int id;
  late int parentId;
  late String name;
  late String categoryIconPath;

  CategoryModel({
    required this.id,
    required this.parentId,
    required this.name,
    required this.categoryIconPath,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'] ?? 1;
    name = json['name'] ?? "";
    categoryIconPath = json['category_icon_path'] ?? "";
  }

  static List<CategoryModel> listFromJson(list) => List<CategoryModel>.from(list.map((x) => CategoryModel.fromJson(x)));
}
