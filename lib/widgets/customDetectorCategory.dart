// ignore_for_file: must_be_immutable

import 'package:budgex/pages/constants/constants.dart';
import 'package:flutter/material.dart';

/// Generates a styled container representing a budget category with customizable details.
/// The container includes rounded corners, a background color based on the app theme,
/// and a circular icon with the specified [categoryIconData], category name, and financial information.
/// The financial details include the total expenses and the remaining amount, presented with appropriate styles.
class CustomCategoryDetector extends StatefulWidget {
  final String categoryName;
  // final int categoryIconData;

  double leftLimit;
  double categoryExpense;

  // This is for testing only
  // Purpose: Creates a screen that provides: category name, expense, left limit, and test
  // final int test;

  CustomCategoryDetector({
    super.key,
    required this.categoryName,
    required this.categoryExpense,
    required this.leftLimit,
  });

  @override
  State<CustomCategoryDetector> createState() => _CustomCategoryDetectorState();
}

class _CustomCategoryDetectorState extends State<CustomCategoryDetector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Prints the index
        // print("Index: ${widget.test}");
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        margin: const EdgeInsets.only(bottom: 20),
        height: 75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.background,
            border: Border.all(color: LIGHT_COLOR_5, width: 2.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Icon(
                    Icons.access_alarm,
                    color: Theme.of(context).colorScheme.background,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  widget.categoryName,
                  style: TextStyle(
                      fontFamily: poppins['semiBold'],
                      fontSize: fontSize['h4']),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "₱ ${widget.categoryExpense}",
                  style: TextStyle(
                      fontFamily: poppins['semiBold'],
                      fontSize: fontSize['h4']),
                ),
                Text(
                  "Left: ₱ ${widget.leftLimit}",
                  style: TextStyle(
                    fontFamily: poppins['regular'],
                    fontSize: fontSize['h6'],
                    color: LIGHT_COLOR_2,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
