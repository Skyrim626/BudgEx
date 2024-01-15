import 'package:budgex/model/category_model_dummy.dart';
import 'package:budgex/model/end_users.dart';

import 'package:budgex/services/constants.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:budgex/widgets/customDetectorCategory.dart';
import 'package:budgex/widgets/custom_appbar.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_circle_chart.dart';
import 'package:budgex/widgets/custom_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserHomepage extends StatefulWidget {
  EndUser endUser;

  UserHomepage({required this.endUser});

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  // Create an instance of the FirebaseAuthService to manage authentication.
/*   final FirebaseAuthService _auth = FirebaseAuthService();

  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService(); */

  final FirebaseAuthService auth = FirebaseAuthService();
  final FirebaseFirestore _fireStoreService = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, endUser: widget.endUser),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: CustomDrawer(
        endUser: widget.endUser,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Text(
            "Good day, ${widget.endUser.fullName}!",
            style: TextStyle(
                fontSize: fontSize['h3'], fontFamily: poppins['regular']),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "WELCOME TO",
            style: TextStyle(
              fontSize: fontSize['h1'],
              fontFamily: poppins['semiBold'],
            ),
          ),
          Text(
            "BudgEx",
            style: TextStyle(
                fontSize: fontSize['h1'], fontFamily: poppins['bold']),
          ),
          const SizedBox(
            height: 45,
          ),
          Text(
            "Account No: 12780289063",
            style: TextStyle(
                fontFamily: poppins['regular'], fontSize: fontSize['h6']),
          ),

          const SizedBox(
            height: 15,
          ),
          CustomButtom(buttonText: "Add Expense", onPressed: () {}),
          const SizedBox(
            height: 10,
          ),
          CustomCircleChart(),
          const SizedBox(
            height: 20,
          ),

          // Expense Category Expenses
          // Only displays 3 (Starts from higher expenses)

          Column(
            children: [
              Text(
                "Most Expenses",
                style: TextStyle(
                  fontFamily: poppins['semiBold'],
                  fontSize: fontSize['h4'],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ...dummyCategories
                  .take(3)
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
      )),
    );
  }

  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        "Good day, User!",
                        style: TextStyle(
                            fontSize: fontSize['h3'],
                            fontFamily: poppins['regular']),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "WELCOME TO",
                        style: TextStyle(
                          fontSize: fontSize['h1'],
                          fontFamily: poppins['semiBold'],
                        ),
                      ),
                      Text(
                        "BudgEx",
                        style: TextStyle(
                            fontSize: fontSize['h1'],
                            fontFamily: poppins['bold']),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      Text(
                        "Account No: 12780289063",
                        style: TextStyle(
                            fontFamily: poppins['regular'],
                            fontSize: fontSize['h6']),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      CustomButtom(buttonText: "Add Expense", onPressed: () {}),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomCircleChart(),
                      const SizedBox(
                        height: 20,
                      ),

                      // Expense Category Expenses
                      // Only displays 3 (Starts from higher expenses)

                      Column(
                        children: [
                          Text(
                            "Most Expenses",
                            style: TextStyle(
                              fontFamily: poppins['semiBold'],
                              fontSize: fontSize['h4'],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ...dummyCategories
                              .take(3)
                              .map((category) => CustomCategoryDetector(
                                    categoryName: category["categoryName"],
                                    leftLimit: category["leftLimit"],
                                    expenses: category["expenses"],
                                    categoryIconData:
                                        category["categoryIconData"],
                                  ))
                              .toList(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } */
}
