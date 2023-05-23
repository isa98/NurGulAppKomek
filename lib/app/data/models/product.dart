import '../../app.dart';

class ProductModel {
  late int id;
  late String type;
  late String name;
  late String formattedPrice;
  late List<ProductImage> images;
  late List<ProductAttribute> attributes;
  late bool inStock;
  late bool isWishlisted;
  late double price;
  late bool isNew;
  late bool isFeatured;
  String? urlKey;
  late String shortDescription;
  late String description;
  String? optionValue;
  bool? isSaved;
  bool? isItemInCart;
  bool? showQuantityChanger;
  String? formattedSpecialPrice;
  String? formattedRegularPrice;
  bool hasDiscount = false;
  String? discountRate;
  List<ProductVariation>? variations;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'] ?? 'simple';
    name = json['name'] ?? '';
    price = double.tryParse(json['price'].toString()) ?? 0.0;
    formattedPrice = json['formatted_price'] ?? '';
    shortDescription = json['short_description'] ?? '';
    description = json['description'] ?? '';
    optionValue = json['option_value'];

    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images.add(ProductImage.fromJson(v));
      });
    } else {
      images = [];
    }

    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes.add(ProductAttribute.fromJson(v));
      });
    } else {
      attributes = [];
    }

    inStock = json['in_stock'];
    isSaved = json['is_saved'];
    isWishlisted = json['is_wishlisted'] ?? false;
    isItemInCart = json['is_item_in_cart'];
    showQuantityChanger = json['show_quantity_changer'];
    isNew = isNullOrEmpty(json['new']) ? false : json['new'] == 1;
    isFeatured = isNullOrEmpty(json['featured']) ? false : json['featured'] == 1;

    if (!isNullOrEmpty(json['formatted_special_price']) && !isNullOrEmpty(json['formatted_regular_price'])) {
      hasDiscount = true;

      formattedSpecialPrice = json['formatted_special_price'];
      formattedRegularPrice = json['formatted_regular_price'];

      final double specialPrice = double.tryParse(json['special_price'].toString()) ?? 0.0;
      final double regularPrice = double.tryParse(json['regular_price'].toString()) ?? 0.0;

      double discountRt = (100 * (regularPrice - specialPrice)) / regularPrice;
      discountRate = '${discountRt.toStringAsFixed(2)}%';
    }
  }

  static List<ProductModel> listFromJson(list) => List<ProductModel>.from(list.map((x) => ProductModel.fromJson(x)));
}

class ProductAttribute {
  late String code;
  late int value;
  late String name;
  late String label;

  ProductAttribute({
    required this.code,
    required this.value,
    required this.name,
    required this.label,
  });

  ProductAttribute.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    value = json['value'];
    name = json['name'];
    label = json['label'];
  }
}

class ProductImage {
  late String originalImageUrl;
  late String smallImageUrl;

  ProductImage({
    required this.originalImageUrl,
    required this.smallImageUrl,
  });

  ProductImage.fromJson(Map<String, dynamic> json) {
    originalImageUrl = json['original_image_url'] ?? '';
    smallImageUrl = json['small_image_url'] ?? '';
  }
}

class ProductVariation {
  late int id;
  late String colorLabel;
  late String sizeLabel;
  late String formattedPrice;
  String? formattedSpecialPrice;
  String? formattedRegularPrice;
  late List<ProductImage> images;

  ProductVariation({
    required this.id,
    required this.colorLabel,
    required this.sizeLabel,
    required this.formattedPrice,
    required this.formattedSpecialPrice,
    required this.formattedRegularPrice,
    required this.images,
  });
}

class ProductAdditionalInfoModel {
  late int id;
  late String code;
  late String label;
  late String value;
  late String adminName;
  late String type;

  ProductAdditionalInfoModel({
    required this.id,
    required this.code,
    required this.label,
    required this.value,
    required this.adminName,
    required this.type,
  });

  ProductAdditionalInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'].toString();
    label = json['label'].toString();
    value = json['value'].toString();
    adminName = json['admin_name'].toString();
    type = json['type'].toString();
  }
}

class Reviews {
  late int total;
  late String averageRating;

  Reviews({
    required this.total,
    required this.averageRating,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    averageRating = json['average_rating'] ?? '0';
  }
}
