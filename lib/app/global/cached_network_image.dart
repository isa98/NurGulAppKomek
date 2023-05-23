import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget cachedImageNetwork(
  String url,
  BoxFit boxFit, [
  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16.0)),
  double width = double.infinity,
  double height = double.infinity,
]) {
  return ClipRRect(
    borderRadius: borderRadius,
    child: url.contains('http')
        ? CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: boxFit,
                ),
              ),
            ),
            placeholder: (context, url) => PlaceholderImageWidget(
              width: width,
              height: height,
            ),
            errorWidget: (context, url, error) => PlaceholderImageWidget(
              width: width,
              height: height,
            ),
          )
        : PlaceholderImageWidget(
            width: width,
            height: height,
          ),
  );
}

class PlaceholderImageWidget extends StatelessWidget {
  final double width;
  final double height;
  final bool setContainerSize;

  const PlaceholderImageWidget({
    super.key,
    required this.height,
    required this.width,
    this.setContainerSize = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      child: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: Image.asset(
            Get.isDarkMode ? 'assets/logo/placeholder_dark.png' : 'assets/logo/placeholder_light.png',
            fit: BoxFit.cover,
            height: height,
            width: width,
          ),
        ),
      ),
    );
  }
}
