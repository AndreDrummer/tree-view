import 'package:tree_view/core/appearence/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AppearenceController extends GetxController {
  final RxBool _isDarkModeON = true.obs;

  bool get isDarkModeON => _isDarkModeON.value;

  void _turnOffDarkMode() {
    _isDarkModeON(false);
  }

  void _turnOnDarkMode() {
    _isDarkModeON(true);
  }

  void toggleAppearenceMode() {
    Get.changeTheme(isDarkModeON ? AppTheme.lightMode : AppTheme.darkMode);
    _isDarkModeON.value ? _turnOffDarkMode() : _turnOnDarkMode();
  }

  void setSystemThemeMode() {
    _isDarkModeON(
      PlatformDispatcher.instance.platformBrightness == Brightness.dark,
    );
  }
}
