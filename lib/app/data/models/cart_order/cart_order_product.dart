import '../models.dart';

class CartOrderProduct {
  late int id;
  late String name;
  late List<ProductImage> images;
  List<SuperAttribute>? superAttributes;

  CartOrderProduct({
    required this.id,
    required this.name,
    required this.images,
    this.superAttributes,
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
    if (json['super_attributes'] != null) {
      superAttributes = <SuperAttribute>[];
      json['super_attributes'].forEach((v) {
        superAttributes!.add(SuperAttribute.fromJson(v));
      });
    }
  }
}
