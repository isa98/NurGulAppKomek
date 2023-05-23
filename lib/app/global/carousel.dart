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
  final PageController _controller = PageController();
  late Timer _timer;
  int _currentIndex = 0;

  void _changePage() {
    if (_currentIndex < widget.sliders.length - 1) {
      _currentIndex++;
    } else {
      _currentIndex = 0;
    }

    _controller.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  Widget _buildIndicator() {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.sliders.map((url) {
            int index = widget.sliders.indexOf(url);
            return Container(
              width: 10.w,
              height: 10.h,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? widget.activeColor : widget.passiveColor,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      _changePage();
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.sliders.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onLongPress: () {
                  _stopTimer();
                },
                onLongPressUp: () {
                  _startTimer();
                },
                onTap: () => widget.onSliderTapped(index),
                child: Container(
                  color: ThemeColor.white,
                  child: cachedImageNetwork(
                    widget.sliders[index],
                    widget.boxFit,
                    BorderRadius.zero,
                  ),
                ),
              );
            },
            onPageChanged: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: _buildIndicator(),
          ),
        ],
      ),
    );
  }
}
