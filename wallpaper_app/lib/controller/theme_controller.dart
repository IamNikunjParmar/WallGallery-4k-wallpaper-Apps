import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  bool isDark = false;

  themeChange() {
    isDark = !isDark;
    notifyListeners();
  }
}
