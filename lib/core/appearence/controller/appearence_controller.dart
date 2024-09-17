import 'package:tree_view/core/appearence/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppearenceController extends GetxController {
  final RxBool _isDarkModeON = false.obs;

  bool get isDarkModeON => _isDarkModeON.value;

  void toggleAppearenceMode() {
    Get.changeTheme(Get.isDarkMode ? AppTheme.lightMode : AppTheme.darkMode);

    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);

    Get.isDarkMode ? _isDarkModeON(false) : _isDarkModeON(true);
  }

  void setSystemThemeMode() {
    _isDarkModeON(
      PlatformDispatcher.instance.platformBrightness == Brightness.dark,
    );
  }
}
