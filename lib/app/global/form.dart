import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app.dart';

final txtStyle = TextStyle(
  color: ThemeColor.formBorderColor,
  fontSize: 16.sp,
);

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final int maxLines;
  final bool obscureText;
  final bool isPhone;
  final TextInputType inputType;
  final Widget? suffix;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onChangeCallback;
  final FocusNode focusNode;

  const MyTextFormField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.maxLines = 1,
    this.obscureText = false,
    this.isPhone = false,
    this.inputType = TextInputType.text,
    this.suffix,
    this.prefix,
    this.inputFormatters,
    this.onChangeCallback,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      maxLines: maxLines,
      // cursorColor: ThemeColor.cursorColor,
      style: txtStyle,
      keyboardType: inputType,
      onTapOutside: (_) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
      inputFormatters: inputFormatters != null ? [...inputFormatters!] : [],
      textInputAction: TextInputAction.done,
      decoration: inputDecoration(),
      validator: (value) => _validator(value),
      onChanged: (value) =>
          onChangeCallback != null ? onChangeCallback!(value) : null,
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      alignLabelWithHint: maxLines != 1,
      hintText: hintText ?? label,
      hintStyle: txtStyle,
      prefixIcon: prefix,
      suffixIcon: suffix,
      // prefixIconConstraints: const BoxConstraints(),
      suffixIconConstraints: const BoxConstraints(),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Get.theme.colorScheme.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: ThemeColor.formBorderColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Get.theme.colorScheme.primary),
      ),
      // disabledBorder: InputBorder.none,
    );
  }

  String? _validator(String? value) {
    if (obscureText) {
      return (value == null || value.trim().length < 6)
          ? 'validation_min_6_char'.tr
          : null;
    }
    if (isPhone) {
      final phone = value?.replaceAll(RegExp(r'\D+'), '');
      return (phone == null || phone.trim().length < 8)
          ? 'validation_invalid_phone'.tr
          : null;
    }

    return (value == null || value.trim().isEmpty)
        ? '$label ${'validation_is_reqired'.tr}'
        : null;
  }
}
