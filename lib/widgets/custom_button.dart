/*
  Flutter Developer Notes:

  This Dart class represents a custom button widget tailored for the application. It's designed 
  to offer a consistent look and feel across the UI. The button is styled with a background color 
  defined in LIGHT_COLOR_3, and it accepts an `onPressed` function for handling user interactions. 
  Additionally, it features customizable text through the `buttonText` parameter.

  Key Components:
  - TextButton widget with custom styling.
  - Customizable text, color, font family, font weight, and font size.

  Note: Ensure that the provided `onPressed` function handles user interactions correctly.

  Well done on creating a reusable and visually appealing button component!
*/

import 'package:budgex/pages/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;

  const CustomButtom(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: LIGHT_COLOR_3,
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 80.0, vertical: 15), // Add padding here
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontFamily: dosis['bold'],
            fontSize: fontSize['h4'],
          ),
        ),
      ),
    );
  }
}
