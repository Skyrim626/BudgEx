import 'package:budgex/model/userModel.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CustomCircleChart extends StatefulWidget {
  CustomCircleChart({super.key});

  @override
  State<CustomCircleChart> createState() => _CustomCircleChartState();
}

class _CustomCircleChartState extends State<CustomCircleChart> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData?>(context);

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: LIGHT_COLOR_5),
      child: Column(
        children: [
          // First Row
          /**
           * First Row contains:
           * - Display Budget Period:
           *  - (Daily, Weekly, Monthly, Yearly)
           */
          containerFirstRow(),

          containerSecondRow(
            totalBudget: userData!.budget.totalBudget,
            currentBudget: userData.budget.currentBudget,
            totalExpenses: userData.budget.totalExpenses,
          ),

          containerThirdRow(
            totalBudget: userData.budget.totalBudget,
            currentBudget: userData.budget.currentBudget,
            totalExpenses: userData.budget.totalExpenses,
          ),
        ],
      ),
    );
  }

  /**
   * 
   * A method that displays the first row batch for the circle chart
   * 
   * Displays:
   *  Budget Period
   * 
   */
  Row containerFirstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Weekly",
              style: TextStyle(
                color: LIGHT_COLOR_1,
                fontFamily: poppins['regular'],
                fontSize: fontSize['h6'],
              ),
            ),
            Text(
              "Current Budget Period",
              style: TextStyle(
                color: LIGHT_COLOR_1,
                fontFamily: poppins['regular'],
                fontSize: fontSize['h6'],
              ),
            ),

            /**
             * 
             * Display the Date of Budget is Created
             * 
             * {INSERT DATA}
             */
            Text(
              "October 29, 2023",
              style: TextStyle(
                color: LIGHT_COLOR_1,
                fontFamily: poppins['regular'],
                fontSize: fontSize['h6'],
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {

          },
          icon: Icon(Icons.edit),
          color: LIGHT_COLOR_1,
        ),
      ],
    );
  }

  /**
   * 
   * A method that displays the second row batch for the circle chart
   * 
   * Displays:
   *  Circle Charts with Current Budget
   * 
   */
  Center containerSecondRow(
      {required double currentBudget,
      required double totalBudget,
      required double totalExpenses}) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _chartSize = _screenWidth * 0.8;

    return Center(
      child: SizedBox(
        width: _chartSize,
        height: _chartSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Current Budget",
                  style: TextStyle(
                      fontFamily: dosis['semiBold'],
                      fontSize: fontSize['h5'],
                      color: LIGHT_COLOR_1),
                ),
                Text(
                  "\₱ $currentBudget",
                  style: TextStyle(
                      fontFamily: dosis['semiBold'],
                      fontSize: 35,
                      color: Colors.white),
                ),
              ],
            ),
            PieChart(
              PieChartData(
                sections: generatePieChartSections(
                  totalBudget,
                  currentBudget,
                  totalExpenses,
                ),
              ),
              swapAnimationDuration: const Duration(milliseconds: 750),
              swapAnimationCurve: Curves.easeInOutQuint,
            )
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> generatePieChartSections(
    double totalBudget,
    double currentBudget,
    double totalExpenses,
  ) {
    double remainingBudget = totalBudget - totalExpenses;
    double currentBudgetPercentage = (currentBudget / totalBudget) * 100;
    double remainingBudgetPercentage = (remainingBudget / totalBudget) * 100;
    double expensesPercentage = (totalExpenses / totalBudget) * 100;

    return [
      PieChartSectionData(
        value: currentBudgetPercentage,
        color: LIGHT_COLOR_1,
        showTitle: false,
      ),
      PieChartSectionData(
        value: remainingBudgetPercentage,
        color: LIGHT_COLOR_2,
        showTitle: false,
      ),
      PieChartSectionData(
        value: expensesPercentage,
        color: LIGHT_COLOR_4,
        showTitle: false,
      ),
    ];
  }

  Row containerThirdRow(
      {required double totalBudget,
      required double currentBudget,
      required double totalExpenses}) {
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
              /**
               * 
               * INSERT REAL DATA ABOUT Budget Declared
               */
              "\$ $totalBudget",
              style: TextStyle(
                  color: LIGHT_COLOR_1,
                  fontSize: 11,
                  fontFamily: poppins['regular']),
            ),
            Text(
                /**
               * 
               * INSERT REAL DATA ABOUT CURRENT BUDGET
               */
                "\$ $currentBudget",
                style: TextStyle(
                    color: LIGHT_COLOR_1,
                    fontSize: 11,
                    fontFamily: poppins['regular'])),
            Text(
                /**
               * 
               * INSERT REAL DATA ABOUT Remaining BUDGET
               */
                "\$ $totalExpenses",
                style: TextStyle(
                    color: LIGHT_COLOR_1,
                    fontSize: 11,
                    fontFamily: poppins['regular'])),
          ],
        )
      ],
    );
  }

  Row _buildRowWithCircle(Color color, String text, double fontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: fontSize,
          height: fontSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
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
}
