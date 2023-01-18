


import 'package:flutter/material.dart';
import 'package:streaming_service_lister/utils/services/dark_theme_prefs.dart';


// Listen for the changes
class DarkThemeProvider with ChangeNotifier {

  DarkThemePrefs darkThemePrefs = DarkThemePrefs();

  bool _darkTheme = false;
  bool get getDarkTheme => _darkTheme;

  set setDarkTheme (bool value) {
    _darkTheme = value;
    darkThemePrefs.setDarkTheme(value);
    notifyListeners(); 
  }
}