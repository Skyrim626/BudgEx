import 'package:budgex/services/constants.dart';
import 'package:flutter/material.dart';

// Icon Buttons

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
        background: Colors.white,
        primary: LIGHT_COLOR_5,
        secondary: Colors.white,
        tertiary: LIGHT_COLOR_5));

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
      background: DARK_COLOR_4, primary: LIGHT_COLOR_1, tertiary: Colors.white),
);
