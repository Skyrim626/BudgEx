/*
  Flutter Developer Notes:

  This Dart class defines a custom text input field widget tailored for the application. It is 
  designed to provide a consistent look and feel for text input across the UI. The field allows 
  for both single-line and obscured (password) text input.

  Key Components:
  - TextFormField widget with specified properties:
    - `obscureText` determines whether the text should be obscured (e.g., for passwords).
    - `decoration` defines visual attributes such as hint text and label text.

  Args:
    - `controller`: The TextEditingController for this text field.
    - `hintText`: The text to display when the field is empty.
    - `labelText`: The text displayed as the label for the field.
    - `obscureText`: Indicates whether the text should be obscured (e.g., for passwords).

  Returns:
    A TextFormField widget configured with the specified properties.

  Note: Ensure that the provided TextEditingController is properly managed and used as needed.

  Excellent work on creating a reusable and configurable text input field component!
*/

import 'package:budgex/services/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final String labelText;
  final bool obscureText;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.labelText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        fontFamily: poppins['regular'],
      ),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
      ),
    );
  }
}
