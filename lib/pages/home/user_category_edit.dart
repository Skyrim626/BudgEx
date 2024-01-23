import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:budgex/data/categoryData.dart';
import 'package:budgex/model/userCategoryModel.dart';
import 'package:budgex/model/userModel.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/pages/home/user_budgeting.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:budgex/shared/loading.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_text.dart';
import 'package:budgex/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCategoryEdit extends StatefulWidget {
  const UserCategoryEdit({super.key});

  @override
  State<UserCategoryEdit> createState() => _UserCategoryEditState();
}

class _UserCategoryEditState extends State<UserCategoryEdit> {
  // Create an instance of the FirebaseAuthService to manage authentication.
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Create an instance of the FirestoreFirebaseService for updating data in the Setting Screen
  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();

  late Stream<UserData?> userStream;
  // late List<UserCategoryModel?> userCategories;
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
                child: _buildCategoryEdit(context, userData));
          }
        });
  }

  // Builds the Category Editing Screen
  Scaffold _buildCategoryEdit(BuildContext context, UserData? data) {
    final userData = data;

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            title: 'Budget Declared: ₱${userData?.budget.totalBudget}',
            fontSize: fontSize['h3']!,
            fontFamily: poppins['semiBold']!),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              final route =
                  MaterialPageRoute(builder: (context) => UserBudgeting());

              // Use Navigator.pushAndRemoveUntil to navigate to the UserBudgeting page and remove all previous routes
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(context, route, (route) => false);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            // Display Existing Categories
            children: [
              ...userData?.budget.userCategories.map((category) {
                    return GestureDetector(
                      onTap: () {
                        // _editCategory(context, userData!, category)
                        // _addCategory(context, data);
                      },
                      child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                  title: category.categoryName,
                                  fontSize: fontSize['h5']!,
                                  fontFamily: poppins['regular']!),
                              CustomText(
                                  title: category.leftLimit.toString(),
                                  fontSize: fontSize['h5']!,
                                  fontFamily: poppins['regular']!)
                            ],
                          ),
                          leading: Icon(
                            IconData(int.parse(category.iconData),
                                fontFamily: 'MaterialIcons'),
                            color: LIGHT_COLOR_5,
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              // _removeCategory(category, userData!);
                            },
                          )),
                    );
                  }).toList() ??
                  [],
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Button to add a new category
                  CustomButton(
                      buttonText: "Add Category",
                      onPressed: () {
                        _addCategory(context, userData);
                      },
                      paddingHorizontal: 8,
                      paddingVertical: 8,
                      buttonColor: LIGHT_COLOR_2,
                      fontSize: fontSize['h5']!,
                      fontFamily: poppins['regular']!,
                      textColor: Colors.white),

                  // Confirm Budget
                  CustomButton(
                      buttonText: "Confirm Edit",
                      onPressed: () {
                        double totalBudgetDeclared =
                            userData!.budget.totalBudget;

                        double totalCategoriesLimit = 0;
                        for (UserCategoryModel category
                            in userData.budget.userCategories) {
                          totalCategoriesLimit += category.leftLimit;
                        }

                        // Checks if the Declared Budget is greater than the total limits of the categories
                        if (totalBudgetDeclared >= totalCategoriesLimit) {
                          // Method for adding new category to the firestore
                          _firestoreService.updateCategoryUser(
                              uuid: _authService.getCurrentUser().uid,
                              categories: userData.budget.userCategories);

                          final route = MaterialPageRoute(
                              builder: (context) => UserBudgeting());

                          // Use Navigator.pushAndRemoveUntil to navigate to the UserBudgeting page and remove all previous routes
                          // ignore: use_build_context_synchronously
                          Navigator.pushAndRemoveUntil(
                              context, route, (route) => false);
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'Limit reached',
                            desc:
                                'Your categories total limit exceeds the declared budget you specified. Lower the category limit or edit your budget',
                            btnOkOnPress: () {},
                          ).show();
                        }
                      },
                      paddingHorizontal: 8,
                      paddingVertical: 8,
                      buttonColor: LIGHT_COLOR_3,
                      fontSize: fontSize['h5']!,
                      fontFamily: poppins['regular']!,
                      textColor: Colors.white)
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  // Function to add a new category
  void _addCategory(BuildContext context, UserData? data) {
    final userData = data;

    TextEditingController categoryNameController = TextEditingController();
    TextEditingController budgetLimitController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: CustomText(
                title: "Add New Category",
                fontSize: fontSize['h4']!,
                fontFamily: poppins['semiBold']!),
            content: Column(
              children: [
                // Prompts the User to input Category Name
                CustomTextField(
                    controller: categoryNameController,
                    hintText: "Enter category",
                    labelText: "Category Name",
                    obscureText: false,
                    validatorText: "Please enter category name"),

                const SizedBox(
                  height: 15,
                ),

                // Prompts the User to input Budget Limit
                CustomTextField(
                    controller: budgetLimitController,
                    hintText: "Enter budget Limit",
                    labelText: "Enter Budget Limit (₱)",
                    obscureText: false,
                    validatorText: "Please enter budget limit"),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: CustomText(
                    title: "Cancel",
                    fontSize: fontSize['h4']!,
                    fontFamily: poppins['regular']!,
                  )),
              ElevatedButton(
                  onPressed: () {
                    String newCategoryName = categoryNameController.text.trim();
                    double newBudgetLimit =
                        double.parse(budgetLimitController.text.trim());

                    if (newCategoryName.isNotEmpty) {
                      // Category Icon Data
                      String newIconData = "0xe148";
                      double newCategoryExpense = 0.0;

                      UserCategoryModel newCategory = UserCategoryModel(
                          iconData: newIconData,
                          categoryName: newCategoryName,
                          leftLimit: newBudgetLimit,
                          categoryExpense: newCategoryExpense);
                      setState(() {
                        userData?.budget.userCategories.add(newCategory);
                        for (UserCategoryModel category
                            in userData!.budget.userCategories) {
                          print(category.categoryName);
                        }
                      });
                    }

                    Navigator.pop(context);
                  },
                  child: CustomText(
                    title: "Add",
                    fontSize: fontSize['h4']!,
                    fontFamily: poppins['regular']!,
                  ))
            ],
          );
        });
  }

  // Function to edit category
  void _editCategory() {}
}
