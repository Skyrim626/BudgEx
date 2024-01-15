import 'package:budgex/model/budget.dart';

import 'package:budgex/model/category_model_dummy.dart';
import 'package:budgex/services/constants.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/widgets/customDetectorCategory.dart';
import 'package:budgex/widgets/custom_appbar.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_circle_chart.dart';
import 'package:budgex/widgets/custom_drawer.dart';
import 'package:budgex/widgets/custom_dropdown_button.dart';
import 'package:budgex/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
/* import 'package:budgex/widgets/pie_chart.dart'; */
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserBudgeting extends StatefulWidget {
  const UserBudgeting({super.key});

  @override
  State<UserBudgeting> createState() => _UserBudgetingState();
}

class _UserBudgetingState extends State<UserBudgeting> {
  // Create an instance of the FirebaseAuthService to manage authentication.
  final FirebaseAuthService _auth = FirebaseAuthService();

  // Declare User
  late User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Initialize User
    user = _auth.getCurrentUser();
  }

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

  Future<void> _displayBottomSheet(BuildContext context) {
    // Generate Current Time
    final DateTime now = DateTime.now();

    // Define the desired date format
    final String formattedDate = DateFormat('MMMM dd, yyyy').format(now);

    // Define the desired time format with AM/PM
    final String formattedTime = DateFormat('h:mm a').format(now);

    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
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
                            obscureText: false,
                            validatorText: "Please enter your amount",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            controller: nameController,
                            hintText: "Enter name*",
                            labelText: "Name*",
                            obscureText: false,
                            validatorText: "Please enter your expense title",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            controller: descriptionController,
                            hintText: "Enter description*",
                            labelText: "Description*",
                            obscureText: false,
                            validatorText: "Please enter your description",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          Text(
                            "Transaction date and time:",
                            style: TextStyle(
                                fontFamily: poppins['semiBold'],
                                fontSize: fontSize['h4']),
                          ),
                          Text(
                            "$formattedDate | $formattedTime",
                            style: TextStyle(
                                color: LIGHT_COLOR_3,
                                fontFamily: poppins['regular'],
                                fontSize: fontSize['h5']),
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
                // Call a class
                CustomCircleChart(),

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
                        .map((category) => CustomCategoryDetector(
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
