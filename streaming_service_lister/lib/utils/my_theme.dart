// my_theme.dart
// Author: Samuel Rudqvist
// Date Created: 08/30/2022

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTheme{
  // Color variables
  Color _red = Color.fromARGB(255, 255, 0, 0);
  Color _dark = Color.fromARGB(255, 20, 20, 20);

  ThemeData buildTheme(){
    return ThemeData(
      canvasColor: _dark,
      brightness: Brightness.dark,
      
    );
  }
}