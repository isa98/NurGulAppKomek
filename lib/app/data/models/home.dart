import '../data.dart';

class HomeModel {
  late List<SliderModel> sliders;
  late List<ProductSection> productSections;

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] != null) {
      sliders = <SliderModel>[];
      json['sliders'].forEach((v) {
        sliders.add(SliderModel.fromJson(v));
      });
    }
    if (json['product_sections'] != null) {
      productSections = <ProductSection>[];
      json['product_sections'].forEach((v) {
        productSections.add(ProductSection.fromJson(v));
      });
    }
  }
}

class ProductSection {
  late String title;
  late String type;
  late String filter;
  List<dynamic> items = [];

  ProductSection.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    filter = json['filter'];

    if (json['items'] != null) {
      items = <dynamic>[];
      if (type == 'product') {
        json['items'].forEach((v) {
          items.add(ProductModel.fromJson(v));
        });
      } else if (type == 'banner') {
        json['items'].forEach((v) {
          items.add(SliderModel.fromJson(v));
        });
      }
    }
  }
}
