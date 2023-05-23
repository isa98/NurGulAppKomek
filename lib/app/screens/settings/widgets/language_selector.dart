import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectBox extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectBox({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Checkbox(
            activeColor: Get.theme.primaryColor,
            shape: const CircleBorder(),
            value: isSelected,
            onChanged: (_) => onTap(),
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Get.isDarkMode
                      ? Colors.white
                      : Colors.black
                  : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
