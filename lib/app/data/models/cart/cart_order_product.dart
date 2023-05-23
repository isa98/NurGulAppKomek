import '../models.dart';

class CartOrderProduct {
  late int id;
  late String name;
  late List<ProductImage> images;

  CartOrderProduct({
    required this.id,
    required this.name,
    required this.images,
  });

  CartOrderProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['images'] != null) {
      images = <ProductImage>[];
      json['images'].forEach((v) {
        images.add(ProductImage.fromJson(v));
      });
    }
  }
}
