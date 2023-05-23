import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app.dart';
import 'ru_ru.dart';
import 'tm_tm.dart';

class LocalizationService extends Translations {
  // Default locale
  // static final locale = Locale('tm', 'TM');

  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('tm', 'TM');

  // Supported languages
  // Needs to be same order with locales
  static final langs = [
    LanguageModel(id: 1, language: 'Türkmen dili', code: 'tm', icon: 'tm.png'),
    LanguageModel(id: 2, language: 'Русский', code: 'ru', icon: 'ru.png'),
  ];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    const Locale('tm', 'TM'),
    const Locale('ru', 'RU'),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'tm_TM': tmTM, // tm_tm.dart
        'ru_RU': ruRu, // ru_ru.dart
      };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i].code) return locales[i];
    }
    return Get.locale!;
  }
}
