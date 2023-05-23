class SliderModel {
  late String sliderPath;
  late String imageUrl;

  SliderModel({
    required this.sliderPath,
    required this.imageUrl,
  });

  SliderModel.fromJson(Map<String, dynamic> json) {
    sliderPath = json['slider_path'] ?? '';
    imageUrl = json['image_url'] ?? '';
  }
}
