import 'package:budgex/pages/home/user_budgeting.dart';

import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserCategoryExpense extends StatefulWidget {
  UserCategoryExpense({Key? key}) : super(key: key);

  @override
  State<UserCategoryExpense> createState() => _UserCategoryExpenseState();
}

class _UserCategoryExpenseState extends State<UserCategoryExpense> {
  late List _posts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _posts = [
      'post 1',
      'post 2',
      'post 3',
      'post 4',
      'post 5',
      'post 6',
      'post 7',
    ];
  }

  // A function that allows the user to return to the Budgeting Screen
  void toBudgetingScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserBudgeting(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          CustomButtom(buttonText: "Add Expense", onPressed: () {}),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: toBudgetingScreen,
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.tertiary,
            )),
        title: Text(
          'Food',
          style: TextStyle(fontFamily: dosis['bold'], fontSize: fontSize['h2']),
        ),
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),

                // Generate Expense Cateogry Budget Container
                budgetContainer(context),
                const SizedBox(
                  height: 50,
                ),

                Text(
                  "Expenses",
                  style: TextStyle(
                      fontFamily: poppins['bold'], fontSize: fontSize['h4']),
                ),

                const SizedBox(
                  height: 25,
                ),

                Container(
                  height: 300,
                  child: ListView.builder(
                      itemCount: _posts.length,
                      itemBuilder: (context, index) {
                        return expenseBox();
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // A function that retruns a container that for expense entry
  // Expense Entry Container contains some of this followings:
  // Gesture Button - (TBD)
  // Expense Title - Title of your Expense
  // Date and Time Expended - Date format (MM-DD-YYYY) and Time format (12hr-format), to when it was expended in that certain event
  Padding expenseBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                offset: const Offset(4.0, 4.0),
                spreadRadius: 1.0,
                blurRadius: 5.0,
              ),
            ]),
        height: 90,
      ),
    );
  }

  // A functoin that generates a widget container that contains the budget, edit and the value
  Container budgetContainer(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        margin: const EdgeInsets.only(bottom: 20),
        height: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.background,
            border: Border.all(color: LIGHT_COLOR_5, width: 2.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Budget",
              style: TextStyle(
                  fontFamily: poppins['bold'], fontSize: fontSize['h4']),
            ),
            Text(
              "\$ 1,000.00",
              style: TextStyle(
                  fontFamily: poppins['bold'], fontSize: fontSize['h4']),
            )
          ],
        ));
  }
}
