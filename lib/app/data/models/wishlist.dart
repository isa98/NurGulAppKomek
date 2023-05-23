import 'models.dart';

class WishlistModel {
  late int id;
  late ProductModel product;

  WishlistModel({
    required this.id,
    required this.product,
  });

  WishlistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductModel.fromJson(json['product']);
  }

  static List<WishlistModel> listFromJson(list) => List<WishlistModel>.from(list.map((x) => WishlistModel.fromJson(x)));
}
