import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  bool get isDarkMode => _loadThemeFromBox();

  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  void switchTheme(bool isDarkMode) {
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    _saveThemeToBox(isDarkMode);
  }
}
