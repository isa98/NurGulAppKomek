import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

import '../app.dart';

class CarouselSlider extends StatefulWidget {
  final List<String> sliders;
  final Function(int index) onSliderTapped;
  final BoxFit boxFit;
  final Color activeColor;
  final Color passiveColor;

  const CarouselSlider({
    super.key,
    required this.sliders,
    required this.onSliderTapped,
    this.boxFit = BoxFit.cover,
    this.activeColor = Colors.white,
    this.passiveColor = Colors.grey,
  });

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  late final PageController _controller;
  late Timer _timer;
  int _currentIndex = 0;

  Widget _getIndicators() {
    return SizedBox(
      height: 15.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          widget.sliders.length,
          (index) => Container(
            width: 10.w,
            height: 10.h,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentIndex == index % widget.sliders.length
                  ? widget.activeColor
                  : widget.passiveColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeInOutCubic);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            // itemCount: widget.sliders.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                // onLongPress: () {
                //   _stopTimer();
                // },
                // onLongPressUp: () {
                //   _startTimer();
                // },
                onTap: () => widget.onSliderTapped(index),
                child: Container(
                  color: ThemeColor.white,
                  child: cachedImageNetwork(
                    widget.sliders[index % widget.sliders.length],
                    widget.boxFit,
                    BorderRadius.zero,
                  ),
                ),
              );
            },
            onPageChanged: (int index) {
              setState(() {
                _currentIndex = index % widget.sliders.length;
              });
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: _getIndicators(),
          ),
        ],
      ),
    );
  }
}
