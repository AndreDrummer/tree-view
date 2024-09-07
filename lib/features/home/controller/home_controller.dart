import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  bool _isDarkModeON = true;

  bool get isDarkModeON => _isDarkModeON;

  void _turnOffDarkMode() {
    _isDarkModeON = false;

    notifyListeners();
  }

  void _turnOnDarkMode() {
    _isDarkModeON = true;

    notifyListeners();
  }

  void toggleAppearenceMode() {
    _isDarkModeON ? _turnOffDarkMode() : _turnOnDarkMode();
  }
}
