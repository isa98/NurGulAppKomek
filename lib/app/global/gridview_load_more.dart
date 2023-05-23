import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app.dart';

class GridViewLoadMoreWidget extends StatelessWidget {
  final int index;
  const GridViewLoadMoreWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Transform.translate(
          offset: Offset(index % 2 == 0 ? context.width / 4 : 0, 0),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: CustomLoader(),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
