import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:budgex/model/userCategoryModel.dart';
import 'package:budgex/model/userExpenseModel.dart';
import 'package:budgex/model/userModel.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/pages/home/user_budgeting.dart';
import 'package:budgex/pages/home/user_expense.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:budgex/shared/loading.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_text.dart';
import 'package:budgex/widgets/custom_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UserAddExpense extends StatefulWidget {
  const UserAddExpense({super.key});

  @override
  State<UserAddExpense> createState() => _UserAddExpenseState();
}

class _UserAddExpenseState extends State<UserAddExpense> {
  // Create an instance of the FirebaseAuthService to manage authentication.
  final FirebaseAuthService _authService = FirebaseAuthService();

  late Stream<UserData?> userStream;

  // Create an instance of the FirebaseFirestoreService to add expense data.
  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();

  // Controllers
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  late String selectedCategory = '';

  // Generate Current Time
  DateTime? now;

  // Define the desired date format
  String? formattedDate;

  // Define the desired time format with AM/PM
  String? formattedTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userStream =
        FirebaseFirestoreService(uid: _authService.getCurrentUser().uid)
            .userDocumentStream;

    now = DateTime.now();
    formattedDate = DateFormat('MMMM dd, yyyy').format(now!);
    formattedTime = DateFormat('h:mm a').format(now!);
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    amountController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    _scrollController.dispose();
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
          // Data Loaded Successfully

          UserData userData = snapshot.data!;

          return StreamProvider<UserData?>.value(
              value: FirebaseFirestoreService(uid: userData.uid)
                  .userMainDocumentStream,
              initialData: userData,
              child: _buildAddExpenseUI(context, userData));
        }
      },
    );
  }

  // A method to build Expense UI
  Scaffold _buildAddExpenseUI(BuildContext context, UserData? data) {
    final userData = data;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              final route =
                  MaterialPageRoute(builder: (context) => UserBudgeting());

              // Use Navigator.pushAndRemoveUntil to navigate to the UserBudgeting page and remove all previous routes
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(context, route, (route) => false);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 25, left: 18, right: 18, bottom: 10),
                  child: Column(
                    children: [
                      CustomText(
                          title: "Add Expense",
                          fontFamily: dosis['semiBold']!,
                          fontSize: fontSize['h3']!),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          buttonText: "Scan Receipt",
                          onPressed: () {},
                          paddingHorizontal: 80,
                          paddingVertical: 15,
                          buttonColor: LIGHT_COLOR_3,
                          fontFamily: dosis['bold']!,
                          fontSize: fontSize['h4']!,
                          textColor: Colors.white),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Wil add Method
                          _showDropDownMenu(context, userData);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 8.0, right: 8.0, bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      title: 'Expense Category *',
                                      fontSize: fontSize['h5']!,
                                      fontFamily: dosis['regular']!,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    CustomText(
                                      title: selectedCategory ??
                                          'Select a category', // Use selectedCategory here
                                      fontSize: fontSize['h5']!,
                                      fontFamily: poppins['semiBold']!,
                                    ),
                                  ],
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),

                      // Amount Text Field
                      TextFormField(
                        controller: amountController,
                        style: TextStyle(
                          fontFamily: poppins['regular'],
                        ),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: 'Enter the amount',
                            labelText: 'Amount*',
                            prefixText: "\$"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the amount";
                          }

                          // Use a regex to check if the value contains only digits
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return "Please enter a valid number";
                          }

                          if (value.contains('-')) {
                            return "Please enter the right amount";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      // Amount Text Field
                      TextFormField(
                        controller: nameController,
                        style: TextStyle(
                          fontFamily: poppins['regular'],
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter expense title',
                          labelText: 'Expense Title*',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the expense title";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 8,
                      ),

// Amount Text Field
                      TextFormField(
                        controller: descriptionController,
                        style: TextStyle(
                          fontFamily: poppins['regular'],
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter description',
                          labelText: 'Description*',
                        ),
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
                      CustomButton(
                          buttonText: "Add Expense",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (selectedCategory != '') {
                                // Calculation

                                if (userData!.budget.currentBudget >=
                                    userData.budget.totalExpenses) {
                                  // The current amount the user declared
                                  int currentExpenseAmountDeclared =
                                      int.parse(amountController.text);

                                  // Get the data of the specific category that was selected
                                  UserCategoryModel? categoryInfo =
                                      userData.budget.getUserCategoryByName(
                                          name: selectedCategory);

                                  // Checks if the amount declared is less than the left limit
                                  if (currentExpenseAmountDeclared <=
                                      categoryInfo!.leftLimit) {
                                    // Declare category expense for getting all the expenses in the specific category
                                    int categoryTotalExpense = 0;

                                    for (UserExpenseModel entry
                                        in categoryInfo.expenseEntry) {
                                      categoryTotalExpense += entry
                                          .amount; // Adds the amount of the specific entry
                                    }

                                    // Adds the current amount declared to the categoryTotalExpense
                                    categoryTotalExpense +=
                                        currentExpenseAmountDeclared;

                                    // Gets the left limit of the specifc category
                                    int categoryLeftLimit =
                                        categoryInfo.leftLimit;

                                    // Checks if the left limit is greater or equal to the expense entry of the specific catgegory combined
                                    if (categoryLeftLimit >= 0) {
                                      categoryLeftLimit -=
                                          currentExpenseAmountDeclared; // Subtracts the left limit with the categorYTotalExpense

                                      if (categoryLeftLimit >= 0) {
                                        // print("CHECK HERE $categoryLeftLimit");
                                        // Gets the curent amount of the budget
                                        int currentLeftBudget =
                                            userData.budget.currentBudget;

                                        // Gets all the info of the category except the selected one
                                        List<UserCategoryModel?>
                                            allCategoriesInfo = userData.budget
                                                .getAllCategoryInfoExceptTheSelected(
                                                    categoryExceptName:
                                                        selectedCategory);

                                        // Declate a total expense of that budget
                                        int totalBudgetExpense = 0;

                                        // Add all values to the list
                                        for (var category
                                            in allCategoriesInfo) {
                                          totalBudgetExpense +=
                                              category!.categoryExpense;
                                        }

                                        totalBudgetExpense +=
                                            categoryTotalExpense;

                                        // Subtracts the current budget to the total expense
                                        currentLeftBudget = currentLeftBudget -
                                            totalBudgetExpense;
                                        if (currentLeftBudget > 0) {
                                          String formattedDateTime =
                                              DateFormat('MMMM dd, yyyy h:mm a')
                                                  .format(now!);

                                          // Generate Unique ID for the Expense Entry
                                          // Create new UUID
                                          var uuid = Uuid();

                                          // Generate a random UUID
                                          String newUuid = uuid.v4();

                                          UserExpenseModel expenseEntry =
                                              UserExpenseModel(
                                                  uuid: newUuid,
                                                  expenseName:
                                                      nameController.text,
                                                  amount: int.parse(
                                                      amountController.text),
                                                  description:
                                                      descriptionController
                                                          .text,
                                                  transactionDate:
                                                      formattedDateTime);

                                          // Sends the expense entry to the firestore service class

                                          _firestoreService.addNewExpense(
                                            uuid: _authService
                                                .getCurrentUser()
                                                .uid,
                                            categoryName: selectedCategory,
                                            expenseEntry: expenseEntry,
                                            currentBudget: currentLeftBudget,
                                            totalExpenses: totalBudgetExpense,
                                            categoryExpense:
                                                categoryTotalExpense,
                                            leftLimit: categoryLeftLimit,
                                          );

                                          final route = MaterialPageRoute(
                                              builder: (context) =>
                                                  UserBudgeting());

                                          // Use Navigator.pushAndRemoveUntil to navigate to the UserBudgeting page and remove all previous routes
                                          // ignore: use_build_context_synchronously

                                          Navigator.pushAndRemoveUntil(
                                              context, route, (route) => false);
                                        } else {
                                          AwesomeDialog(
                                                  context: context,
                                                  dialogType: DialogType.error,
                                                  animType: AnimType.scale,
                                                  title:
                                                      "You have reached your limit!",
                                                  btnOkOnPress: () {})
                                              .show();
                                        }
                                      } else {
                                        AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.error,
                                                animType: AnimType.scale,
                                                title: "Category Limit Exceed!",
                                                desc:
                                                    'Your current budget for ${categoryInfo.categoryName} is reached it limit. Edit your budget, increase the limit, or lower the expenses!',
                                                btnOkOnPress: () {})
                                            .show();
                                      }
                                    } else {
                                      AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.error,
                                              animType: AnimType.scale,
                                              title: "Category Limit Exceed!",
                                              desc:
                                                  'Your current budget for ${categoryInfo.categoryName} is reached it limit. Edit your budget, increase the limit, or lower the expenses!',
                                              btnOkOnPress: () {})
                                          .show();
                                    }
                                  } else {
                                    AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.error,
                                            animType: AnimType.scale,
                                            title: "Category Limit Exceed!",
                                            desc:
                                                'Your current budget for ${categoryInfo.categoryName} is reached it limit. Edit your budget, increase the limit, or lower the expenses!',
                                            btnOkOnPress: () {})
                                        .show();
                                  }
                                } else {
                                  AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.error,
                                          animType: AnimType.scale,
                                          title: "Budget Limit Exceed!",
                                          desc:
                                              'Your current budget is reached it limit. Edit your budget or lower the expenses!',
                                          btnOkOnPress: () {})
                                      .show();
                                }
                              } else {
                                AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.scale,
                                        title: "Please Select a Category",
                                        btnOkOnPress: () {})
                                    .show();
                              }

                              // Show an error dialog if passwords do not match
                            }
                          },
                          paddingHorizontal: 80,
                          paddingVertical: 15,
                          buttonColor: LIGHT_COLOR_3,
                          fontFamily: dosis['bold']!,
                          fontSize: fontSize['h4']!,
                          textColor: Colors.white),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  // A method for drop down menu
  void _showDropDownMenu(BuildContext context, UserData? data) {
    final userData = data;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: userData!.budget.userCategories.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: CustomText(
                  title: userData.budget.userCategories[index].categoryName,
                  fontSize: fontSize['h4']!,
                  fontFamily: poppins['regular']!,
                ),
                onTap: () {
                  setState(() {
                    selectedCategory =
                        userData.budget.userCategories[index].categoryName;
                  });
                  print("Selected Category: $selectedCategory");
                  Navigator.pop(context); // Close the bottom sheet
                },
              );
            },
          ),
        );
      },
    );
  }
}
