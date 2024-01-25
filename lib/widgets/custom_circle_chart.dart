import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:budgex/model/userCategoryModel.dart';
import 'package:budgex/model/userModel.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/pages/home/user_dashboard.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:budgex/widgets/custom_text.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class CustomCircleChart extends StatefulWidget {
  const CustomCircleChart({super.key});

  @override
  State<CustomCircleChart> createState() => _CustomCircleChartState();
}

class _CustomCircleChartState extends State<CustomCircleChart> {
  // Generate Current Time
  DateTime? now;

  // Define the desired date format
  String? formattedDate;

  // Define the desired time format with AM/PM
  String? formattedTime;

  TextEditingController _editController = TextEditingController();

  // Global key to uniquely identify the Form widget for validation
  final _formKey = GlobalKey<FormState>();

  // Create an instance of the FirebaseAuthService to manage authentication.
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Create an instance of the FirebaseFirestoreService to add expense data.
  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData?>(context);

    return Container(
      padding: const EdgeInsets.all(10),
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
          containerFirstRow(data: userData),

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
   * A method that displays the first row batch for the circle chart
   *
   * Displays:
   *  Budget Period
   */
  Row containerFirstRow({required UserData? data}) {
    final userData = data;

    now = DateTime.now();
    formattedDate = DateFormat('MMMM dd, yyyy').format(now!);
    formattedTime = DateFormat('h:mm a').format(now!);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: "Current Date:",
              fontFamily: poppins['regular']!,
              fontSize: fontSize['h6']!,
              titleColor: LIGHT_COLOR_1,
            ),
            CustomText(
              title: "$formattedDate",
              fontFamily: poppins['regular']!,
              fontSize: fontSize['h6']!,
              titleColor: LIGHT_COLOR_1,
            ),
            CustomText(
              title: "$formattedTime",
              fontFamily: poppins['regular']!,
              fontSize: fontSize['h6']!,
              titleColor: LIGHT_COLOR_1,
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            showEditDialog(
                budgetDeclared: userData!.budget.totalBudget, data: userData);
          },
          icon: Icon(Icons.add),
          color: LIGHT_COLOR_1,
        ),
      ],
    );
  }

  /**
   * A method that displays the second row batch for the circle chart
   *
   * Displays:
   *  Circle Charts with Current Budget
   */
  Center containerSecondRow(
      {required int currentBudget,
      required int totalBudget,
      required int totalExpenses}) {
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
                  "\$ $currentBudget",
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
    int totalBudget,
    int currentBudget,
    int totalExpenses,
  ) {
    int remainingBudget = totalBudget - totalExpenses;
    double currentBudgetPercentage = (currentBudget / totalBudget) * 100;
    double remainingBudgetPercentage = (remainingBudget / totalBudget) * 100;
    double expensesPercentage = (totalExpenses / totalBudget) * 100;

    return [
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

  /**
   * A method that displays the third row batch for the circle chart
   *
   * Displays:
   *  - Legend with Budget Declared, Current Budget, Total Expenses
   */
  Row containerThirdRow(
      {required int totalBudget,
      required int currentBudget,
      required int totalExpenses}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRowWithCircle(LIGHT_COLOR_2, "Current Budget", 11),
            _buildRowWithCircle(LIGHT_COLOR_4, "Total Expenses", 11),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "\$ $currentBudget",
              style: TextStyle(
                  color: LIGHT_COLOR_1,
                  fontSize: 11,
                  fontFamily: poppins['regular']),
            ),
            Text(
              "\$ $totalExpenses",
              style: TextStyle(
                  color: LIGHT_COLOR_1,
                  fontSize: 11,
                  fontFamily: poppins['regular']),
            ),
          ],
        )
      ],
    );
  }

  /**
   * A method to build a row with a colored circle and text
   */
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

  /**
   * A method that displays the edit dialog
   */
  void showEditDialog({
    required int budgetDeclared,
    required UserData? data,
  }) {
    final userData = data;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: CustomText(
              title: "Add Budget Amount",
              fontFamily: poppins['regular']!,
              fontSize: fontSize['h3']!,
              titleColor: LIGHT_COLOR_3,
            ),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: ListBody(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Empty budget value";
                        }

                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return "Please enter a valid age (numbers only)";
                        }

                        int? parseValue = int.tryParse(value);
                        if (parseValue == null || parseValue <= 0) {
                          return "Please enter a valid budget not less than 0";
                        }
                      },
                      controller: _editController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          prefixText: '\$',
                          labelText: 'Add budget',
                          helperText: "Edit your budget with caution"),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Add'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (int.parse(_editController.text) >=
                        userData!.budget.totalExpenses) {
                      int currentBudget = userData.budget.currentBudget;

                      // Get the new currentBudget
                      currentBudget += int.parse(_editController.text);

                      await _firestoreService.updateCurrentBudget(
                          uuid: _authService.getCurrentUser().uid,
                          newCurrentBudget: currentBudget);

                      final route = MaterialPageRoute(
                          builder: (context) => UserDashBoard());

                      Navigator.pushAndRemoveUntil(
                          context, route, (route) => false);
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.scale,
                        title: "Invalid budget declaration!",
                        desc:
                            'Your budget declared is less than the total expenses of your entries.',
                        btnOkOnPress: () {},
                      ).show();
                    }
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}
