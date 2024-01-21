import 'package:budgex/pages/constants/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomCircleChart extends StatefulWidget {
  CustomCircleChart({super.key});

  @override
  State<CustomCircleChart> createState() => _CustomCircleChartState();
}

class _CustomCircleChartState extends State<CustomCircleChart> {
  @override
  Widget build(BuildContext context) {
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

          containerSecondRow(),

          containerThirdRow(),
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
          onPressed: () {},
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
  Center containerSecondRow() {
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
                  "\$ 5000.00",
                  style: TextStyle(
                      fontFamily: dosis['semiBold'],
                      fontSize: 35,
                      color: Colors.white),
                ),
              ],
            ),
            PieChart(
              PieChartData(sections: [
                PieChartSectionData(
                    value: 50, color: LIGHT_COLOR_1, showTitle: false),
                PieChartSectionData(
                    value: 20, color: LIGHT_COLOR_2, showTitle: false),
                PieChartSectionData(
                    value: 20, color: LIGHT_COLOR_4, showTitle: false),
              ]),
              swapAnimationDuration: const Duration(milliseconds: 750),
              swapAnimationCurve: Curves.easeInOutQuint,
            )
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
              /**
               * 
               * INSERT REAL DATA ABOUT Budget Declared
               */
              "\$ Budget Declared",
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
                "\$ Current Budget",
                style: TextStyle(
                    color: LIGHT_COLOR_1,
                    fontSize: 11,
                    fontFamily: poppins['regular'])),
            Text(
                /**
               * 
               * INSERT REAL DATA ABOUT Remaining BUDGET
               */
                "\$ Remaining Buget",
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
