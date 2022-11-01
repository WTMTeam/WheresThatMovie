

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Styles {

  // Dark theme variables
  static const Color _red = Color.fromARGB(255, 255, 0, 0);
  static const Color _redOpacity = Color.fromARGB(100, 255, 0, 0);
  static const Color _dark =Color.fromARGB(255, 20, 20, 20);
  static const Color _grey =Color.fromARGB(255, 119, 124, 135);
  static const Color _myCardColor =Color.fromARGB(255, 40, 40, 40);

  // Light theme variables
  static const Color _light = Color.fromARGB(255, 206, 211, 221);
  //static const Color _lightCanvasColor = Color.fromARGB(255, 206, 211, 221);
  static const Color _lightCardColor = Color.fromARGB(255, 232, 235, 241);

  // Both theme variables



  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(

// ------------------------------------------------------------------ //
//                             Colors                                 //
// ------------------------------------------------------------------ //

      primaryColor: _red,
      //focusColor: _red,
      cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
        primaryColor: _red,

      ),

      colorScheme: ThemeData().colorScheme.copyWith(
        secondary: 
          //isDarkTheme ? const Color(0xFF1a1f3c) : const Color(0xFFE8FDFD),
          isDarkTheme ? _dark : _light,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ),


// ------------------------------------------------------------------ //
//                         Text Themes                                //
// ------------------------------------------------------------------ //
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: _red,
        selectionColor: _red,
        selectionHandleColor: _red
        
      ),

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
          primary: _red,
          //padding: const EdgeInsets.symmetric(horizontal: 10.0),
          minimumSize: const Size(200, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),

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
          borderSide: BorderSide(
            color: isDarkTheme ? _redOpacity : _redOpacity
          ),
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