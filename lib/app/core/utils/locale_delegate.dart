import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackButtonTextOverride extends DefaultMaterialLocalizations {
  BackButtonTextOverride(Locale locale) : super();
  @override
  String get backButtonTooltip => 'back'.tr;
}

class BackButtonTextDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const BackButtonTextDelegate();
  @override
  Future<BackButtonTextOverride> load(Locale locale) {
    return SynchronousFuture(BackButtonTextOverride(locale));
  }

  @override
  bool shouldReload(BackButtonTextDelegate old) => false;
  @override
  bool isSupported(Locale locale) => true;
}
