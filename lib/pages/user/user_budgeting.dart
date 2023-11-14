import 'package:budgex/model/budget.dart';

import 'package:budgex/model/category_model_dummy.dart';
import 'package:budgex/services/constants.dart';
import 'package:budgex/widgets/custom_appbar.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_drawer.dart';
import 'package:budgex/widgets/custom_dropdown_button.dart';
import 'package:budgex/widgets/custom_textfield.dart';
/* import 'package:budgex/widgets/pie_chart.dart'; */
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class UserBudgeting extends StatefulWidget {
  const UserBudgeting({super.key});

  @override
  State<UserBudgeting> createState() => _UserBudgetingState();
}

class _UserBudgetingState extends State<UserBudgeting> {
  // Budget Instance
  /* Budget sampleBudget = Budget(totalBudget: 10000); */
  Budget sampleBudget = Budget(budget: 10000);

  // Controllers
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: ListView(
                /* height: 1000, */
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 25, left: 18, right: 18, bottom: 10),
                      child: Column(
                        children: [
                          Text(
                            "Add Expense",
                            style: TextStyle(
                                fontFamily: dosis['semiBold'],
                                fontSize: fontSize['h3']),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButtom(
                              buttonText: "Scan Receipt", onPressed: () {}),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomDropDownButton(),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                              controller: amountController,
                              hintText: "Enter amount*",
                              labelText: "Amount*",
                              obscureText: false),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                              controller: nameController,
                              hintText: "Enter name*",
                              labelText: "Name*",
                              obscureText: false),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                              controller: descriptionController,
                              hintText: "Enter description*",
                              labelText: "Description*",
                              obscureText: false),
                          const SizedBox(
                            height: 8,
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          CustomButtom(
                              buttonText: "Add Expense", onPressed: () {}),
                        ],
                      ),
                    ),
                  ),
                ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomButtom(
          buttonText: "Add Expense",
          onPressed: () {
            _displayBottomSheet(context);
          }),
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
                              leftLimit: category["leftLimit"],
                              expenses: category["expenses"],
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
  GestureDetector generateCategory(
      {required String categoryName,
      required double leftLimit,
      required double expenses,
      required int categoryIconData}) {
    return GestureDetector(
      onTap: () {
        print("hello 1");
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
          )),
    );
  }

  // A function that returns and displays the budget Container
  // Inside contains row function (containerFirstRow(), containerSecondRow(), containerThirdRow())
  // containerFirstRow() = displays the details of the budget (budget period, current budget, date, and edit button)
  // containerSecondRow() = displays the details of the current budget with a circle chart/chart at the center
  // containerThirdRow() = displays the color indicators of the budget details and values
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
          containerSecondRow(),
          const SizedBox(
            height: 20,
          ),
          // Third Row
          containerThirdRow(),
        ],
      ),
    );
  }

  Center containerSecondRow() {
    double screenWidth = MediaQuery.of(context).size.width;
    double chartSize = screenWidth * 0.8;

    return Center(
      child: SizedBox(
        width: chartSize,
        height: chartSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Current Budget",
                    style: TextStyle(
                        fontFamily: dosis['semiBold'],
                        fontSize: fontSize['h5'],
                        color: LIGHT_COLOR_1)),
                Text("\$ 5000.00",
                    style: TextStyle(
                        fontFamily: dosis['semiBold'],
                        fontSize: 35,
                        color: Colors.white)),
              ],
            ),
            PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                      value: 50, color: LIGHT_COLOR_1, showTitle: false),
                  PieChartSectionData(
                      value: 20, color: LIGHT_COLOR_2, showTitle: false),
                  PieChartSectionData(
                      value: 20, color: LIGHT_COLOR_4, showTitle: false),
                ],
              ),
              swapAnimationDuration: const Duration(milliseconds: 750),
              swapAnimationCurve: Curves.easeInOutQuint,
            ),
          ],
        ),
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
              "\$ ${sampleBudget.getBudget}",
              style: TextStyle(
                  color: LIGHT_COLOR_1,
                  fontSize: 11,
                  fontFamily: poppins['regular']),
            ),
            Text("\$ ${sampleBudget.getcurrentBudget}",
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

  Row _buildRowWithCircle(Color color, String text, double fontSize) {
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
