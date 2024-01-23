import "package:budgex/services/theme.dart";
import "package:flutter/material.dart";

// A class responsible for managing and providing the application's theme
class ThemeProvider with ChangeNotifier {
  // Default theme set to light mode
  ThemeData _themeData = lightMode;

  // Getter to access the current theme data
  ThemeData get themeData => _themeData;

  // Setter to update the theme data and notify listeners of the change
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners(); // Notify listeners of the theme change
  }

  // Method to toggle between light and dark themes
  void toggleTheme() {
    // If the current theme is light mode, switch to dark mode; otherwise, switch to light mode
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
