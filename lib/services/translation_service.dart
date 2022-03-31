import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gosuto/lang/lang.dart';

class TranslationService extends Translations {
  final _box = GetStorage();
  final _key = 'languageCode';

  // static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('en', 'US');

  static final langCodes = [
    'en',
    'vi',
  ];

  static final langs =
  LinkedHashMap.from({'en': 'English', 'vi': 'Tiếng Việt'});

  static get locales => [
    const Locale('en', 'US'),
    const Locale('vi', 'VN'),
  ];

  static Locale _getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ?? fallbackLocale;
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }
    return fallbackLocale;
  }

  Locale _loadLocaleFromBox() =>
      _getLocaleFromLanguage(langCode: _box.read(_key));

  _saveLocaleToBox(Locale locale) => _box.write(_key, locale.languageCode);

  Locale get locale => _loadLocaleFromBox();

  void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale);
    _saveLocaleToBox(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUs, 'vi_VN': viVn};
}
