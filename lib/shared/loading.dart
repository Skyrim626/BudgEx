import 'package:budgex/pages/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Widget for displaying a loading spinner
class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Set the background color for the loading screen
      color: LIGHT_COLOR_5,
      // Center the loading spinner within the container
      child: const Center(
        child: SpinKitSquareCircle(
          // Set the color of the loading spinner
          color: LIGHT_COLOR_3,
          // Set the size of the loading spinner
          size: 50.0,
        ),
      ),
    );
  }
}
