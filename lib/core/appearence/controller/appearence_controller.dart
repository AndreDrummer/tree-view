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
    _isDarkModeON.value ? _turnOffDarkMode() : _turnOnDarkMode();
  }
}
