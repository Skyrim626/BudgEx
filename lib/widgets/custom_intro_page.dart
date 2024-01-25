// Import necessary packages and files
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// Onboarding Page Widget
// ignore: must_be_immutable
class IntroPage extends StatelessWidget {
  String fileName;
  String title;
  String subTitle;

  // Constructor to initialize the properties
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
        CustomText(
            title: title,
            fontFamily: dosis['semiBold']!,
            fontSize: fontSize['h3']!),

        const SizedBox(
          height: 7,
        ),

        // SubTitle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: CustomText(
              title: subTitle,
              fontFamily: poppins['regular']!,
              fontSize: fontSize['h5']!),
        ),
      ],
    ));
  }
}
