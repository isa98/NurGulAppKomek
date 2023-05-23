import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback? callback;

  const CircleButton({super.key, this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => callback == null ? Navigator.pop(context) : callback!(),
        splashColor: Theme.of(context).splashColor,
        child: Icon(
          GetPlatform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          size: 20,
          color: Get.isDarkMode ? ThemeColor.darkMainColorGreen : ThemeColor.white,
        ),
      ),
    );
  }
}
