import 'package:flutter/material.dart';

import '../../../app.dart';

class GalleryCarouselSlider extends StatefulWidget {
  final List<String>? stringImages;
  final int index;
  const GalleryCarouselSlider(
      {super.key, this.stringImages, required this.index});

  @override
  State<GalleryCarouselSlider> createState() => _GalleryCarouselSliderState();
}

class _GalleryCarouselSliderState extends State<GalleryCarouselSlider> {
  int bannerIndex = 0;
  late final PageController _controller;

  List images = [];
  bool _pagingEnabled = true;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.index);
    bannerIndex = widget.index;
    images = widget.stringImages ?? [];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: images.isNotEmpty
          ? Stack(children: [
              _getImages(),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                child: _getIndicators(),
              ),
            ])
          : const SizedBox(),
    );
  }

  Widget _getImages() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: PageView.builder(
          physics: images.length > 1
              ? _pagingEnabled
                  ? const PageScrollPhysics()
                  : const NeverScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          controller: _controller,
          onPageChanged: (value) {
            setState(() {
              bannerIndex = value % images.length;
            });
          },
          itemBuilder: (context, index) {
            final rawImage = images[index % images.length];
            final String image = rawImage;

            return DoubleTappableInteractiveViewer(
              scaleDuration: const Duration(milliseconds: 600),
              scale: 2.0,
              child: cachedImageNetwork(
                image,
                BoxFit.contain,
              ),
              onScaleChanged: (scale) {
                setState(() {
                  // Disable paging when image is zoomed-in
                  _pagingEnabled = scale <= 1.0;
                });
              },
            );
          },
        ),
      ),
    );
  }

  Widget _getIndicators() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: SizedBox(
        height: 15.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            images.length,
            (index) => CarouselSliderIndicator(
                dotIndex: index % images.length, bannerIndex: bannerIndex),
          ),
        ),
      ),
    );
  }
}

class CarouselSliderIndicator extends StatelessWidget {
  const CarouselSliderIndicator(
      {Key? key, required this.dotIndex, required this.bannerIndex})
      : super(key: key);

  final int dotIndex;
  final int bannerIndex;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8.0),
      height: bannerIndex == dotIndex ? 13.0 : 8.0,
      width: bannerIndex == dotIndex ? 13.0 : 8.0,
      decoration: BoxDecoration(
        color: bannerIndex == dotIndex
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        shape: BoxShape.circle,
      ),
    );
  }
}

class DoubleTappableInteractiveViewer extends StatefulWidget {
  final double scale;
  final Duration scaleDuration;
  final Curve curve;
  final Widget child;
  final void Function(double)? onScaleChanged;

  const DoubleTappableInteractiveViewer({
    super.key,
    this.scale = 2,
    this.curve = Curves.fastLinearToSlowEaseIn,
    required this.scaleDuration,
    required this.child,
    this.onScaleChanged,
  });

  @override
  State<DoubleTappableInteractiveViewer> createState() =>
      _DoubleTappableInteractiveViewerState();
}

class _DoubleTappableInteractiveViewerState
    extends State<DoubleTappableInteractiveViewer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Animation<Matrix4>? _zoomAnimation;
  late TransformationController _transformationController;
  TapDownDetails? _doubleTapDetails;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.scaleDuration,
    )..addListener(() {
        _transformationController.value = _zoomAnimation!.value;
      });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    final newValue = _transformationController.value.isIdentity()
        ? _applyZoom()
        : _revertZoom();
    double scale = newValue.getMaxScaleOnAxis();

    if (widget.onScaleChanged != null) {
      widget.onScaleChanged!(scale);
    }

    _zoomAnimation = Matrix4Tween(
      begin: _transformationController.value,
      end: newValue,
    ).animate(CurveTween(curve: widget.curve).animate(_animationController));
    _animationController.forward(from: 0);
  }

  Matrix4 _applyZoom() {
    final tapPosition = _doubleTapDetails!.localPosition;
    final translationCorrection = widget.scale - 1;
    final zoomed = Matrix4.identity()
      ..translate(
        -tapPosition.dx * translationCorrection,
        -tapPosition.dy * translationCorrection,
      )
      ..scale(widget.scale);
    return zoomed;
  }

  Matrix4 _revertZoom() {
    return Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: _handleDoubleTapDown,
      onDoubleTap: _handleDoubleTap,
      child: InteractiveViewer(
        transformationController: _transformationController,
        child: widget.child,
        onInteractionEnd: (details) {
          double scale = _transformationController.value.getMaxScaleOnAxis();

          if (widget.onScaleChanged != null) {
            widget.onScaleChanged!(scale);
          }
        },
      ),
    );
  }
}
