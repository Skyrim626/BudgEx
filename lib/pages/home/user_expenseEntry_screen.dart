import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:budgex/model/userCategoryModel.dart';
import 'package:budgex/model/userExpenseModel.dart';
import 'package:budgex/model/userModel.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/pages/home/user_expense.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:budgex/shared/loading.dart';
import 'package:budgex/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserExpenseEntryScreen extends StatefulWidget {
  final String uuid;
  final String categoryName;
  final UserExpenseModel expenseEntry;

  const UserExpenseEntryScreen(
      {super.key,
      required this.uuid,
      required this.expenseEntry,
      required this.categoryName});

  @override
  State<UserExpenseEntryScreen> createState() => _UserExpenseEntryScreenState();
}

class _UserExpenseEntryScreenState extends State<UserExpenseEntryScreen> {
  // Create an instance of the FirebaseAuthService to manage authentication.
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Create an instance of the FirestoreFirebaseService for updating data in the Setting Screen
  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();

  late Stream<UserData?> userStream;

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
          return StreamProvider<UserData?>.value(
              value: FirebaseFirestoreService(uid: userData.uid)
                  .userMainDocumentStream,
              initialData: userData,
              child: _buildExpenseEntryUI(context, userData));
        }
      },
    );
  }

  Scaffold _buildExpenseEntryUI(BuildContext context, UserData? data) {
    print(widget.uuid);

    final userData = data;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.tertiary,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              final route =
                  MaterialPageRoute(builder: (context) => UserExpense());

              // Use Navigator.pushAndRemoveUntil to navigate to the UserExpense page and remove all previous routes
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(context, route, (route) => false);
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    btnOkColor: LIGHT_COLOR_3,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    desc: 'Are You Sure You Want to Delete the Expense Entry?',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () async {
                      // An algorithm that returns the amount
                      // Returned the amount
                      String expenseEntryUUID = widget.expenseEntry.uuid;
                      int amountReturned = widget.expenseEntry.amount;

                      UserCategoryModel? categoryInfo = userData!.budget
                          .getUserCategoryByName(name: widget.categoryName);

                      int categoryExpense =
                          categoryInfo!.categoryExpense - amountReturned;
                      int categoryLeftLimit =
                          categoryInfo.leftLimit + amountReturned;

                      int currentBudget =
                          userData.budget.currentBudget + amountReturned;
                      int totalBudgetExpense =
                          userData.budget.totalExpenses - amountReturned;

                      _firestoreService.deleteExpense(
                        uuid: _authService.getCurrentUser().uid,
                        expenseUUID: widget.uuid,
                        categoryType: widget.categoryName,
                        categoryExpense: categoryExpense,
                        categoryLeftLimit: categoryLeftLimit,
                        currentBudget: currentBudget,
                        totalBudgetExpense: totalBudgetExpense,
                      );

                      final route = MaterialPageRoute(
                          builder: (context) => UserExpense());

                      // Use Navigator.pushAndRemoveUntil to navigate to the UserExpense page and remove all previous routes
                      // ignore: use_build_context_synchronously
                      Navigator.pushAndRemoveUntil(
                          context, route, (route) => false);
                    },
                  ).show();
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: "Expense Title",
                  fontSize: fontSize['h3']!,
                  fontFamily: dosis['regular']!,
                  titleColor: LIGHT_COLOR_3,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                  child: CustomText(
                    title: widget.expenseEntry.expenseName,
                    fontSize: fontSize['h5']!,
                    fontFamily: poppins['semiBold']!,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CustomText(
                          title: "Category",
                          fontSize: fontSize['h3']!,
                          fontFamily: dosis['regular']!,
                          titleColor: LIGHT_COLOR_3,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 10),
                          child: CustomText(
                            title: widget.categoryName,
                            fontSize: fontSize['h5']!,
                            fontFamily: poppins['semiBold']!,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomText(
                          title: "Amount",
                          fontSize: fontSize['h3']!,
                          fontFamily: dosis['regular']!,
                          titleColor: LIGHT_COLOR_3,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 10),
                          child: CustomText(
                            title: '\$${widget.expenseEntry.amount}',
                            fontSize: fontSize['h5']!,
                            fontFamily: poppins['semiBold']!,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomText(
                  title: "Date",
                  fontSize: fontSize['h3']!,
                  fontFamily: dosis['regular']!,
                  titleColor: LIGHT_COLOR_3,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                  child: CustomText(
                    title: widget.expenseEntry.transactionDate,
                    fontSize: fontSize['h5']!,
                    fontFamily: poppins['semiBold']!,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomText(
                  title: "Expense Description",
                  fontSize: fontSize['h3']!,
                  fontFamily: dosis['regular']!,
                  titleColor: LIGHT_COLOR_3,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                  child: CustomText(
                    title: widget.expenseEntry.description,
                    fontSize: fontSize['h5']!,
                    fontFamily: poppins['semiBold']!,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
              ],
            ),
          ),
        )));
  }
}
