import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeModeApp extends ChangeNotifier{
  bool isDarkModeOn = false;

  void updateTheme(bool isDarkModeOn) {
    this.isDarkModeOn = isDarkModeOn;
    notifyListeners();
    final storage = new FlutterSecureStorage();
    storage.write(key: "Them", value: isDarkModeOn.toString());
  }
}