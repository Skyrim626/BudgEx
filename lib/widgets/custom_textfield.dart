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
      obscureText: obscureText,
      decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
          ),
    );
  }
}
