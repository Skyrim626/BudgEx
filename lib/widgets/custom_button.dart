import 'package:budgex/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomButton extends StatefulWidget {
  final String buttonText;
  Function() onPressed;
  final double paddingHorizontal;
  final double paddingVertical;
  final Color buttonColor;
  final Color textColor;

  final double fontSize;
  final String fontFamily;

  CustomButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      required this.paddingHorizontal,
      required this.paddingVertical,
      required this.buttonColor,
      required this.fontSize,
      required this.fontFamily,
      required this.textColor});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: widget.paddingHorizontal,
            vertical: widget.paddingVertical),
        child: CustomText(
          title: widget.buttonText,
          fontSize: widget.fontSize,
          fontFamily: widget.fontFamily,
          titleColor: widget.textColor,
        ),
      ),
      style: TextButton.styleFrom(backgroundColor: widget.buttonColor),
    );
  }
}
