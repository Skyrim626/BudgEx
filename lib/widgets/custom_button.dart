import 'package:budgex/services/constants.dart';
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {

  final String buttonText;
  final Function()? onPressed;
  
  const CustomButtom({super.key, required this.buttonText, required this.onPressed});

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
            fontFamily: 'Dosis',
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
