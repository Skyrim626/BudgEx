/*
  Flutter Developer Notes:

  These color constants define the color schemes used in both the Light and Dark themes of our application.
  Naming conventions are meaningful and intuitive, making it easier to manage and understand the color choices.

  These font size constants define the font size used for this application.
  Naming conventions are based on heading and it's easier to set custom size.

  These font family constants defint the style of the font used for this applicatoin.
  Naming conventions are meaningful and intuitive, making sure what style of the font style choices.

  Light Theme Colors:
  - LIGHT_COLOR_1: A pale, soft color for backgrounds.
  - LIGHT_COLOR_2: A mid-tone color for secondary elements.
  - LIGHT_COLOR_3: A vibrant color used for highlights or calls to action.
  - LIGHT_COLOR_4: A dark color for text and accents.
  - LIGHT_COLOR_5: A very dark color for prominent text and elements.

  Dark Theme Colors:
  - DARK_COLOR_1: A subdued color for backgrounds in the dark theme.
  - DARK_COLOR_2: A mid-tone color for secondary elements in the dark theme.
  - DARK_COLOR_3: A vibrant color used for highlights or calls to action in the dark theme.
  - DARK_COLOR_4: A very dark color for text and accents in the dark theme.
  - DARK_COLOR_5: A light color for prominent text and elements in the dark theme.

  These color constants play a crucial role in maintaining a consistent and visually pleasing user experience.

  Well-organized color schemes contribute significantly to the overall design integrity of our application.

  Keep up the great work!
*/

import 'package:flutter/material.dart';

// Color Schemes for Light Theme
// ignore: constant_identifier_names
const Color LIGHT_COLOR_1 = Color(0xFFD8DBE2);
// ignore: constant_identifier_names
const Color LIGHT_COLOR_2 = Color(0xFFA9BCD0);
// ignore: constant_identifier_names
const Color LIGHT_COLOR_3 = Color(0xFF58A4B0);
// ignore: constant_identifier_names
const Color LIGHT_COLOR_4 = Color(0xFF373F51);
// ignore: constant_identifier_names
const Color LIGHT_COLOR_5 = Color(0xFF1B1B1E);

// Color Schemes for Dark Theme
// ignore: constant_identifier_names
const Color DARK_COLOR_1 = Color(0xFFADB3C2);
// ignore: constant_identifier_names
const Color DARK_COLOR_2 = Color(0xFF7B98B7);
// ignore: constant_identifier_names
const Color DARK_COLOR_3 = Color(0xFF41818B);
// ignore: constant_identifier_names
const Color DARK_COLOR_4 = Color(0xFF292F3D);
// ignore: constant_identifier_names
const Color DARK_COLOR_5 = Color(0xFF94949E);

// FONT SIZES
const Map<String, double> fontSize = {
  "h1": 28,
  "h2": 24,
  "h3": 20,
  "h4": 17,
  "h5": 14,
  "h6": 11,
};

// Font Family
// Poppins
const Map<String, String> poppins = {
  "regular": "PoppinsRegular",
  "semiBold": "PoppinsSemiBold",
  "bold": "PoppinsBold",
};

// Dosis
const Map<String, String> dosis = {
  "regular": "DosisRegular",
  "semiBold": "DosisSemiBold",
  "bold": "DosisBold",
};
