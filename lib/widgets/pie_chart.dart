import 'package:budgex/services/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart extends StatelessWidget {
  const CustomPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double chartSize = screenWidth * 0.8;
    return SizedBox(
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
    );
  }
}
