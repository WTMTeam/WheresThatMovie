import 'package:shared_preferences/shared_preferences.dart';

// Class to set and get the theme that the user has chosen
class DarkThemePrefs {
  static const THEME_STATUS = "THEME_STATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // null check, default to false
    return prefs.getBool(THEME_STATUS) ?? true;
  }
}
