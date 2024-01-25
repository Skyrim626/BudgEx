import 'package:budgex/model/expense_entry_dummy.dart';
import 'package:budgex/model/userCategoryExpenseInfo.dart';
import 'package:budgex/model/userCategoryModel.dart';
import 'package:budgex/model/userExpenseModel.dart';
import 'package:budgex/model/userModel.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/pages/home/user_expenseEntry_screen.dart';

import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:budgex/shared/loading.dart';
import 'package:budgex/widgets/custom_appbar.dart';
import 'package:budgex/widgets/custom_drawer.dart';
import 'package:budgex/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UserExpense extends StatefulWidget {
  const UserExpense({super.key});

  @override
  State<UserExpense> createState() => _UserExpenseState();
}

class _UserExpenseState extends State<UserExpense> {
  /* // Get all expenses
  // Dummy Variable
  final List<Map<String, String>> expenseEntries = ExpenseEntry().listExpenses; */

  // Create an instance of the FirebaseAuthService to manage authentication.
  final FirebaseAuthService _authService = FirebaseAuthService();

  late Stream<UserData?> userStream;
  // late List<UserExpenseModel> listExpenseEntries;
  late List<UserCategoryExpenseInfo> expenseEntriesInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userStream =
        FirebaseFirestoreService(uid: _authService.getCurrentUser().uid)
            .userDocumentStream;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData?>(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading state
            return Loading();
          } else if (snapshot.hasError) {
            // Error state

            return Text("Error: ${snapshot.error}");
          } else {
            // Data loaded successfully
            UserData userData = snapshot.data!;

            // Get these types of data
            // Transaction Date
            // Expense Title
            // Category Type
            // Amount
            // Expense Entry Object

            // TESTING DATA
            // TYPE OF DATA Map<String, Map<String, dynamic>>
            expenseEntriesInfo = [];

            // Insert Data Entries
            List<UserCategoryModel> userCategories =
                userData.budget.userCategories;

            for (UserCategoryModel category in userCategories) {
              String categoryName = category.categoryName;

              for (UserExpenseModel expenseInfo in category.expenseEntry) {
                expenseEntriesInfo.add(UserCategoryExpenseInfo(
                    uuid: expenseInfo.uuid,
                    expenseTitle: expenseInfo.expenseName,
                    categoryType: categoryName,
                    transactionDate: expenseInfo.transactionDate,
                    amount: expenseInfo.amount,
                    userExpenseInfo: expenseInfo));
              }
            }

            return StreamProvider<UserData?>.value(
                value: FirebaseFirestoreService(uid: userData.uid)
                    .userMainDocumentStream,
                initialData: userData,
                child: _buildExpenseUI(context, userData, expenseEntriesInfo));
          }
        });
  }

  Scaffold _buildExpenseUI(BuildContext context, UserData? data,
      List<UserCategoryExpenseInfo> listExpenseEntries) {
    // Insert Data
    final userData = data;

    return Scaffold(
      appBar: customAppBar(context: context),
      drawer: const CustomDrawer(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView.builder(
          itemCount: listExpenseEntries.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print("Expense Entry ID: ${listExpenseEntries[index].uuid}");

                final route = MaterialPageRoute(
                    builder: (context) => UserExpenseEntryScreen(
                          uuid: listExpenseEntries[index].uuid,
                          categoryName: listExpenseEntries[index].categoryType,
                          expenseEntry:
                              listExpenseEntries[index].userExpenseInfo,
                        ));

                // Use Navigator.pushAndRemoveUntil to navigate to the UserExpense page and remove all previous routes
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(context, route, (route) => false);
              },
              child: _expenseBox(
                  uuid: listExpenseEntries[index].uuid,
                  dateTransaction: listExpenseEntries[index].transactionDate,
                  expenseTitle: listExpenseEntries[index].expenseTitle,
                  amount: listExpenseEntries[index].amount,
                  categoryName: listExpenseEntries[index].categoryType),
            );
          },
        ),
      )),
    );
  }

  Padding _expenseBox({
    required String uuid,
    required int amount,
    required String dateTransaction,
    required String expenseTitle,
    required String categoryName,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(color: LIGHT_COLOR_2, width: 2.0),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).colorScheme.background,
                  offset: const Offset(4.0, 4.0),
                  spreadRadius: 1.0),
            ]),
        height: 130,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: "Expense Report: $dateTransaction",
                    fontFamily: poppins['regular']!,
                    fontSize: fontSize["h6"]!,
                  ),
                  CustomText(
                    title: "Category: $categoryName",
                    fontFamily: poppins['regular']!,
                    fontSize: fontSize["h6"]!,
                  ),
                  CustomText(
                    title: "Title: $expenseTitle",
                    fontFamily: poppins['regular']!,
                    fontSize: fontSize["h4"]!,
                  ),
                  CustomText(
                    title: "\$$amount",
                    fontFamily: poppins['regular']!,
                    fontSize: fontSize["h4"]!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView.builder(
            itemCount: expenseEntries.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    expenseEntries.removeAt(index);
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Expense deleted')));
                },
                child: expenseBox(
                    dateExpend: expenseEntries[index]['report_date'] ?? "",
                    title: expenseEntries[index]['title'] ?? "",
                    amount: expenseEntries[index]['amount'] ?? ""),
              );
            },
          ),
        ),
      ),
    );
  } */
}
