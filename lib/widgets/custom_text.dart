import 'package:flutter/material.dart';

class CustomText extends StatefulWidget {
  final String title;
  final String fontFamily;
  final double fontSize;
  final int? letterSpacing;
  final Color? titleColor;

  const CustomText(
      {super.key,
      required this.title,
      required this.fontSize,
      required this.fontFamily,
      this.letterSpacing,
      this.titleColor});

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: TextStyle(
          fontFamily: widget.fontFamily,
          fontSize: widget.fontSize,
          color: widget.titleColor),
    );
  }
}
