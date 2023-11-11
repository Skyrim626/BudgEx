import 'package:budgex/model/category_model.dart';
import 'package:budgex/services/constants.dart';
import 'package:budgex/widgets/custom_appbar.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_drawer.dart';
import 'package:budgex/widgets/pie_chart.dart';
import 'package:flutter/material.dart';

class UserBudgeting extends StatefulWidget {
  const UserBudgeting({super.key});

  @override
  State<UserBudgeting> createState() => _UserBudgetingState();
}

class _UserBudgetingState extends State<UserBudgeting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      drawer: CustomDrawer(),
      bottomNavigationBar:
          CustomButtom(buttonText: "Add Expense", onPressed: () {}),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                // Date Selection
                // First Row
                firstRow(),

                // Main Budget Container
                budgetContainer(),

                const SizedBox(
                  height: 20,
                ),
                // Category Section

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Most Expenses",
                          style: TextStyle(
                              fontFamily: poppins['semiBold'],
                              fontSize: fontSize['h4']),
                        ),
                        Text(
                          "Edit Category",
                          style: TextStyle(
                              fontFamily: poppins['regular'],
                              fontSize: fontSize['h5'],
                              color: LIGHT_COLOR_3),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ...dummyCategories
                        .map((category) => generateCategory(
                              categoryName: category["categoryName"],
                              leftLimit: 1000,
                              expenses: 1000,
                              categoryIconData: category["categoryIconData"],
                            ))
                        .toList(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Generates a styled container representing a budget category with customizable details.
  /// The container includes rounded corners, a background color based on the app theme,
  /// and a circular icon with the specified [categoryIconData], category name, and financial information.
  /// The financial details include the total expenses and the remaining amount, presented with appropriate styles.
  Container generateCategory(
      {required String categoryName,
      required double leftLimit,
      required double expenses,
      required int categoryIconData}) {
    return Container(
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
                  width: 45, // Adjust the size as needed
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Icon(
                    IconData(categoryIconData, fontFamily: "MaterialIcons"),
                    color: Theme.of(context).colorScheme.background,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  categoryName,
                  style: TextStyle(
                      fontFamily: poppins['semiBold'],
                      fontSize: fontSize['h4']),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\$ $expenses",
                  style: TextStyle(
                    fontFamily: poppins['semiBold'],
                    fontSize: fontSize['h4'],
                  ),
                ),
                Text(
                  "Left: \$ $leftLimit",
                  style: TextStyle(
                      fontFamily: poppins['regular'],
                      fontSize: fontSize['h6'],
                      color: LIGHT_COLOR_2),
                )
              ],
            )
          ],
        ));
  }

  Container budgetContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: LIGHT_COLOR_5,
      ),
      child: Column(
        children: [
          // First Row
          containerFirstRow(),

          const SizedBox(
            height: 20,
          ),
          // Second Row
          Center(
            child: CustomPieChart(),
          ),
          const SizedBox(
            height: 20,
          ),
          // Third Row
          containerThirdRow(),
        ],
      ),
    );
  }

  Row containerThirdRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRowWithCircle(LIGHT_COLOR_1, "Total Budget", 11),
            _buildRowWithCircle(LIGHT_COLOR_2, "Current Budget", 11),
            _buildRowWithCircle(LIGHT_COLOR_4, "Total Expenses", 11),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "\$ 15,000.00",
              style: TextStyle(
                  color: LIGHT_COLOR_1,
                  fontSize: 11,
                  fontFamily: poppins['regular']),
            ),
            Text("\$ 5,000.00",
                style: TextStyle(
                    color: LIGHT_COLOR_1,
                    fontSize: 11,
                    fontFamily: poppins['regular'])),
            Text("\$ 1,891.00",
                style: TextStyle(
                    color: LIGHT_COLOR_1,
                    fontSize: 11,
                    fontFamily: poppins['regular'])),
          ],
        ),
      ],
    );
  }

  Widget _buildRowWithCircle(Color color, String text, double fontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: fontSize, // Adjust the size as needed
          height: fontSize, // Adjust the size as needed
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 8.0), // Adjust the spacing as needed
        Text(
          text,
          style: TextStyle(
              fontSize: fontSize,
              fontFamily: poppins['regular'],
              color: LIGHT_COLOR_1),
        ),
      ],
    );
  }

  Row containerFirstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weekly',
              style: TextStyle(
                  color: LIGHT_COLOR_1,
                  fontFamily: poppins['regular'],
                  fontSize: fontSize['h6']),
            ),
            Text('Current Budget Period',
                style: TextStyle(
                    color: LIGHT_COLOR_1,
                    fontFamily: poppins['regular'],
                    fontSize: fontSize['h6'])),
            Text('October 29, 2023',
                style: TextStyle(
                    color: LIGHT_COLOR_1,
                    fontFamily: poppins['regular'],
                    fontSize: fontSize['h6'])),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.edit),
          color: LIGHT_COLOR_1,
        ),
      ],
    );
  }

  Row firstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.chevron_left_outlined),
          iconSize: 30,
        ),
        Text(
          "Oct 29 - Nov 04, 2023",
          style: TextStyle(
              fontFamily: dosis['semiBold'], fontSize: fontSize['h3']),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.chevron_right_outlined),
          iconSize: 30,
        ),
      ],
    );
  }
}
