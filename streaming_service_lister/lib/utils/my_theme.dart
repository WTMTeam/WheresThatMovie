// my_theme.dart
// Author: Samuel Rudqvist
// Date Created: 08/30/2022

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTheme{
  // Color variables
  final Color _red = const Color.fromARGB(255, 255, 0, 0);
  final Color _redOpacity = const Color.fromARGB(100, 255, 0, 0);
  final Color _dark = const Color.fromARGB(255, 20, 20, 20);
  final Color _grey = const Color.fromARGB(255, 119, 124, 135);
  //final MaterialStateProperty<Color> _myCheckColor = const Color.fromARGB(255, 100, 200, 100);

  ThemeData buildTheme(){
    return ThemeData(
      canvasColor: _dark,
      primaryColor: _red,
      secondaryHeaderColor: _grey,
      unselectedWidgetColor: _red,
      
      // Change the theme of text selection and cursor
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: _red,
        selectionColor: _red,
      ),

      // Change the theme of input borders
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: _redOpacity,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: _red,
          ),
        ),
        //iconColor: _red,
        //focusColor: _red,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: _red,
          //padding: const EdgeInsets.symmetric(horizontal: 10.0),
          minimumSize: const Size(200, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),

      checkboxTheme: CheckboxThemeData(
        //checkColor: _myCheckColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),          
        ),
        //overlayColor: _red,
      ),

      brightness: Brightness.dark, // Makes text light instead of dark by default      
    );
  }
}