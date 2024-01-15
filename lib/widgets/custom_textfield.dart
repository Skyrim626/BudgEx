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

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String validatorText;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.obscureText,
    required this.validatorText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // boolean variable
  // Initially, set to true to obscure the text
  // for checking if the password is shown/hidden
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return widget.obscureText ? withFieldObscure() : withoutFieldObscure();
  }

  TextFormField withFieldObscure() {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.validatorText;
        }
      },
      obscureText: isObscure,
      style: TextStyle(
        fontFamily: poppins['regular'],
      ),
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                if (isObscure) {
                  isObscure = false;
                } else {
                  isObscure = true;
                }
              });
            },
            icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility)),
        hintText: widget.hintText,
        labelText: widget.labelText,
      ),
    );
  }

  TextFormField withoutFieldObscure() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.validatorText;
        }
      },
      controller: widget.controller,
      style: TextStyle(
        fontFamily: poppins['regular'],
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
      ),
    );
  }
}
