import 'package:budgex/pages/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LIGHT_COLOR_5,
      child: const Center(
        child: SpinKitSquareCircle(
          color: LIGHT_COLOR_3,
          size: 50.0,
        ),
      ),
    );
  }
}
