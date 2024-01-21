/*
  Flutter Developer Notes:

  This Dart class defines a reusable widget for an introductory page within the application. 
  It typically displays an animation, a title, and a subtitle, providing users with engaging 
  content to introduce various sections or features of the app.

  Key Components:
  - Lottie animation loaded from a specified file.
  - Title text styled with a custom font and font size.
  - Subtitle text with customizable styling, including font family and font size.

  Args:
    - `fileName`: The file name of the Lottie animation to be displayed.
    - `title`: The main title displayed on the page.
    - `subTitle`: The supporting subtitle providing additional context.

  Returns:
    A container widget containing an animation, title, and subtitle configured based on the 
    provided arguments.

  Note: Ensure that the Lottie animation file exists and is correctly specified. This 
  IntroPage class serves as a flexible and visually appealing component for introductory 
  content in your app.

  Fantastic job on creating an aesthetically pleasing and informative introductory page!
*/

import 'package:budgex/pages/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class IntroPage extends StatelessWidget {
  String fileName;
  String title;
  String subTitle;

  IntroPage(
      {super.key,
      required this.fileName,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Animation
        Lottie.asset(fileName, width: 300, height: 300),

        const SizedBox(
          height: 10,
        ),

        // Title
        Text(
          title,
          style: TextStyle(
              fontFamily: dosis['semiBold'], fontSize: fontSize['h3']),
        ),

        const SizedBox(
          height: 7,
        ),

        // SubTitle
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: poppins['regular'], fontSize: fontSize['h5']),
            )),
      ],
    ));
  }
}
