import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Styles {
  // Dark theme variables

  static const Color _dark = Color.fromARGB(255, 20, 20, 20);
  static const Color _grey = Color.fromARGB(255, 119, 124, 135);
  static const Color _myCardColor = Color.fromARGB(255, 40, 40, 40);
  static const Color _darkContainerBackground = Color.fromARGB(255, 40, 40, 40);
  static const Color _darkBoxShadowColor = Color.fromARGB(255, 25, 25, 25);

  // Light theme variables
  static const Color _light = Color.fromARGB(255, 228, 228, 228);
  static const Color _lightContainerBackground =
      Color.fromARGB(255, 232, 235, 241);
  static const Color _lightBoxShadowColor = Color.fromARGB(255, 190, 191, 195);

  //static const Color _lightCanvasColor = Color.fromARGB(255, 206, 211, 221);
  static const Color _lightCardColor = Color.fromARGB(255, 204, 206, 210);

  // Both theme variables
  static const Color _red = Color.fromARGB(255, 164, 10, 10);
  static const Color _otherRed = Color.fromARGB(255, 203, 11, 11);
  static const Color _redOpacity = Color.fromARGB(100, 255, 0, 0);

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
// ------------------------------------------------------------------ //
//                             Colors                                 //
// ------------------------------------------------------------------ //

      primaryColor: _red,
      // primaryIconTheme: IconThemeData(
      //   color: _dark,
      // ),
      //focusColor: _red,
      // cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
      //   primaryColor: _red,

      // ),

      // Primary fixed the icon color
      colorScheme: ThemeData().colorScheme.copyWith(
            primary: isDarkTheme ? _light : _dark,
            // primary: isDarkTheme ? _red : _otherRed,
            secondary:
                //isDarkTheme ? const Color(0xFF1a1f3c) : const Color(0xFFE8FDFD),
                isDarkTheme ? _darkBoxShadowColor : _lightBoxShadowColor,
            tertiary: _red,
            // isDarkTheme ? _dark : _light,
            primaryContainer: isDarkTheme
                ? _darkContainerBackground
                : _lightContainerBackground,
            shadow: isDarkTheme ? _darkBoxShadowColor : _lightBoxShadowColor,
            brightness: isDarkTheme ? Brightness.dark : Brightness.light,
          ),

// ------------------------------------------------------------------ //
//                         Text Themes                                //
// ------------------------------------------------------------------ //

      textTheme: TextTheme(
        headline1: TextStyle(
            color: isDarkTheme ? _red : _otherRed,
            fontSize: 30.0,
            fontWeight: FontWeight.bold),
        headline2: TextStyle(
            color: isDarkTheme ? _red : _otherRed,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
        headline3: TextStyle(
            color: isDarkTheme ? _light : _dark,
            // color: isDarkTheme ? _red : _otherRed,
            fontSize: 16.0,
            fontWeight: FontWeight.bold),

        //bodyLarge: TextStyle(fontSize: ),

        labelMedium: TextStyle(fontSize: 20.0),
      ),

      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: _red, selectionColor: _red, selectionHandleColor: _red),

      //switchTheme: SwitchT

// ------------------------------------------------------------------ //
//                       Scaffold Themes                              //
// ------------------------------------------------------------------ //

      scaffoldBackgroundColor:
          //isDarkTheme ? const Color(0xFF00001a) : const Color(0xFFFFFFFF),
          isDarkTheme ? _dark : _light,

// ------------------------------------------------------------------ //
//                         Canvas Themes                              //
// ------------------------------------------------------------------ //

      //canvasColor: isDarkTheme ? Colors.black : Colors.grey,
      canvasColor: isDarkTheme ? _dark : _light,

// ------------------------------------------------------------------ //
//                           Card Themes                              //
// ------------------------------------------------------------------ //
      cardColor:
          //isDarkTheme ? _myCardColor : const Color(0xFFF2FDFD),
          isDarkTheme ? _myCardColor : _lightCardColor,

// ------------------------------------------------------------------ //
//                         Button Themes                              //
// ------------------------------------------------------------------ //

      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarkTheme
                ? const ColorScheme.dark()
                : const ColorScheme.light(),
          ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _red,
          //padding: const EdgeInsets.symmetric(horizontal: 10.0),
          minimumSize: const Size(200, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: isDarkTheme ? _light : _dark),

// ------------------------------------------------------------------ //
//                         Icon Themes                                //
// ------------------------------------------------------------------ //
      //iconTheme: ,

// ------------------------------------------------------------------ //
//                       Checkbox Themes                              //
// ------------------------------------------------------------------ //
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),

// ------------------------------------------------------------------ //
//                          Input Themes                              //
// ------------------------------------------------------------------ //

      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide:
              BorderSide(color: isDarkTheme ? _redOpacity : _redOpacity),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: isDarkTheme ? _red : _red,
          ),
        ),
      ),
    );
  }
}
