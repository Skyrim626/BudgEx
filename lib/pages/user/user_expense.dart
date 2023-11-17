import 'package:budgex/model/expense_entry_dummy.dart';
import 'package:budgex/services/constants.dart';
import 'package:budgex/widgets/custom_appbar.dart';
import 'package:budgex/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class UserExpense extends StatefulWidget {
  const UserExpense({super.key});

  @override
  State<UserExpense> createState() => _UserExpenseState();
}

class _UserExpenseState extends State<UserExpense> {
  // Get all expenses
  // Dummy Variable
  final List<Map<String, String>> expenseEntries = ExpenseEntry().listExpenses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView.builder(
            itemCount: expenseEntries.length,
            itemBuilder: (context, index) {
              String? reportDate = expenseEntries[index]['report_date'] ?? "";
              String? expenseTitle = expenseEntries[index]['title'] ?? "";
              String? amount = expenseEntries[index]['amount'] ?? "";
              return expenseBox(
                  dateExpend: reportDate, title: expenseTitle, amount: amount);
            },
          ),
        ),
      ),
    );
  }

  Padding expenseBox(
      {required String dateExpend,
      required String title,
      required String amount}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border.all(
                color: LIGHT_COLOR_2,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).colorScheme.background,
                    offset: const Offset(4.0, 4.0),
                    spreadRadius: 1.0),
              ]),
          height: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 100,
                    height: 120,
                    child: Image(
                        image: AssetImage(
                            "assets/images/expense_sample_logo.png")),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Expense Report: $dateExpend",
                          style: TextStyle(
                            color: LIGHT_COLOR_3,
                            fontFamily: poppins['regular'],
                            fontSize: fontSize["h6"],
                          ),
                        ),
                        Text(
                          title,
                          style: TextStyle(
                              fontFamily: poppins['regular'],
                              fontSize: fontSize["h4"]),
                        ),
                        Text(
                          "\$$amount",
                          style: TextStyle(
                            fontFamily: poppins['bold'],
                            fontSize: fontSize["h4"],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              /* Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.person),
                  Icon(Icons.person),
                  Icon(Icons.person),
                ],
              ), */
            ],
          )),
    );
  }
}
