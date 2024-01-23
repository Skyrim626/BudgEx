import 'package:budgex/pages/constants/constants.dart';
import 'package:flutter/material.dart';

// ThemeData for light mode
ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
        background: Colors.white,
        primary: LIGHT_COLOR_5,
        secondary: Colors.white,
        tertiary: LIGHT_COLOR_5));

// ThemeData for dark mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
      background: DARK_COLOR_4, primary: LIGHT_COLOR_1, tertiary: Colors.white),
);

// The above code defines two ThemeData instances, one for light mode and one for dark mode.
// These themes include color schemes with background, primary, secondary, and tertiary colors.
// The values for these colors are imported from the 'constants.dart' file.
// The 'lightMode' ThemeData is set with a light brightness, while 'darkMode' is set with a dark brightness.
// These themes can be used to apply consistent styling throughout the app based on the selected theme mode.
