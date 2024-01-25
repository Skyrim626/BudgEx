// Import necessary packages and files
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:budgex/data/categoryData.dart';
import 'package:budgex/model/userModel.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:budgex/shared/loading.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_text.dart';
import 'package:budgex/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Class representing the screen for creating a budget
class UserCreateBudget extends StatefulWidget {
  const UserCreateBudget({super.key});

  @override
  State<UserCreateBudget> createState() => _UserCreateBudgetState();
}

class _UserCreateBudgetState extends State<UserCreateBudget> {
  // Create an instance of the FirebaseAuthService to manage authentication.
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Create an instance of the FirebaseFirestoreService to add budget data.
  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();

  List<CategoryData> categories = sampleCategories;
  int budgetDeclared = 0;

  TextEditingController budgetDeclaredController = TextEditingController();

  late Stream<UserData?> userStream;

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
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
            // Loading state while waiting for user data
            return const Loading();
          } else if (snapshot.hasError) {
            // Error state if there's an issue fetching user data
            return Text("Error: ${snapshot.error}");
          } else {
            // User data loaded successfully
            UserData userData = snapshot.data!;
            return StreamProvider<UserData?>.value(
                value: FirebaseFirestoreService(uid: userData.uid)
                    .userMainDocumentStream,
                initialData: userData,
                child: _buildCreateBudgetUI(context, userData));
          }
        });
  }

  // Builds the Create Budget UI
  Scaffold _buildCreateBudgetUI(BuildContext context, UserData? data) {
    final userData = data;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Logo
              const Image(
                image: AssetImage("assets/images/logo_light.png"),
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Categories Section
                      const SizedBox(height: 20),

                      // Budgeting Text
                      CustomText(
                        title: "Budgeting",
                        fontSize: fontSize['h3']!,
                        fontFamily: poppins['semiBold']!,
                      ),

                      const SizedBox(height: 10),

                      // Declare Budget Amount
                      TextFormField(
                        controller: budgetDeclaredController,
                        style: TextStyle(
                          fontFamily: poppins['regular'],
                        ),
                        validator: (value) {
                          // Validation for budget amount
                          if (value == null || value.isEmpty || value == "") {
                            return "Please enter a budget amount";
                          }

                          // Check if the entered value is a number
                          try {
                            if (int.tryParse(value) == null) {
                              return "Please enter a valid number";
                            }

                            if (int.parse(value) <= 0) {
                              return "Please enter the budget amount not less than 0";
                            }
                          } catch (e) {
                            return "Please enter a valid number";
                          }

                          return null;
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true), // Allow decimal input
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}$')),
                          // Allow only digits and up to 2 decimal places
                        ],
                        decoration: const InputDecoration(
                          prefixText: "\$",
                          hintText: "Enter your budget amount",
                          labelText: "Budget Amount",
                        ),
                      ),

                      // Categories Section
                      const SizedBox(height: 40),

                      // Display existing categories
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomText(
                            title: 'Categories',
                            fontSize: fontSize['h3']!,
                            fontFamily: poppins['semiBold']!,
                          ),
                          CustomText(
                            title: 'Limit',
                            fontSize: fontSize['h3']!,
                            fontFamily: poppins['semiBold']!,
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // Display existing categories as a list
                      Column(
                        children: categories.map((category) {
                          return GestureDetector(
                            onTap: () {
                              // Edit a category when tapped
                              _editCategory(context, userData!, category);
                            },
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    title: category.categoryName,
                                    fontSize: fontSize['h5']!,
                                    fontFamily: poppins['regular']!,
                                  ),
                                  CustomText(
                                    title: category.leftLimit.toString(),
                                    fontSize: fontSize['h5']!,
                                    fontFamily: poppins['regular']!,
                                  ),
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
                                  // Remove a category when delete icon is pressed
                                  _removeCategory(category, userData!);
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // Buttons to add a new category and confirm budget
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            buttonText: "Add Category",
                            onPressed: () {
                              // Add a new category when button is pressed
                              _addCategory(context, userData);
                            },
                            paddingHorizontal: 10,
                            paddingVertical: 7,
                            buttonColor: LIGHT_COLOR_5,
                            fontFamily: poppins['regular']!,
                            fontSize: fontSize['h5']!,
                            textColor: Colors.white,
                          ),
                          CustomButton(
                            buttonText: "Confirm Budget",
                            onPressed: () {
                              // Confirm budget when button is pressed
                              if (_formKey.currentState!.validate()) {
                                if (categories.isNotEmpty) {
                                  if (areCategoryNamesUnique(categories)) {
                                    int totalCategoriesLimit = 0;
                                    for (CategoryData category in categories) {
                                      totalCategoriesLimit +=
                                          category.leftLimit;
                                    }

                                    if (int.parse(
                                            budgetDeclaredController.text) >=
                                        totalCategoriesLimit) {
                                      // Perform budget update
                                      try {
                                        _firestoreService.updateBudgetUser(
                                          budgetDeclared: int.parse(
                                              budgetDeclaredController.text),
                                          uuid:
                                              _authService.getCurrentUser().uid,
                                          categories: categories,
                                        );
                                      } catch (e) {
                                        print(
                                            "[firebase_auth/email-already-in-use] The email address is already in use by another account.");
                                      }
                                    } else {
                                      // Show warning if budget limit is exceeded
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.warning,
                                        animType: AnimType.rightSlide,
                                        title:
                                            'Limit Exceed to the Budget Declared',
                                        desc:
                                            'Make sure your budget limit is greater than all your total limits in your categories.',
                                        btnOkOnPress: () {},
                                      ).show();
                                    }
                                  }
                                } else {
                                  // Show warning if no categories are added
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.warning,
                                    animType: AnimType.rightSlide,
                                    title: 'No categories added',
                                    desc:
                                        'You need at least 1 category for your budgeting.',
                                    btnOkOnPress: () {},
                                  ).show();
                                }
                              }
                            },
                            paddingHorizontal: 10,
                            paddingVertical: 7,
                            buttonColor: LIGHT_COLOR_5,
                            fontFamily: poppins['regular']!,
                            fontSize: fontSize['h5']!,
                            textColor: Colors.white,
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Function to edit a category
  void _editCategory(
      BuildContext context, UserData? userData, CategoryData category) {
    TextEditingController categoryNameController =
        TextEditingController(text: category.categoryName);
    TextEditingController budgetLimitController =
        TextEditingController(text: category.leftLimit.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Category'),
          content: Column(
            children: [
              TextFormField(
                controller: categoryNameController,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                ),
              ),
              TextFormField(
                controller: budgetLimitController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Budget Limit',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String editedCategoryName = categoryNameController.text.trim();
                int editedBudgetLimit =
                    int.parse(budgetLimitController.text.trim());

                if (editedCategoryName.isNotEmpty) {
                  // Update category details
                  setState(() {
                    category.categoryName = editedCategoryName;
                    category.leftLimit = editedBudgetLimit;
                    budgetDeclared = int.parse(budgetLimitController.text);
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
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
          title: Text(
            "Add New Category",
            style: TextStyle(
              fontFamily: poppins['semiBold'],
              fontSize: fontSize['h4'],
            ),
          ),
          content: Column(
            children: [
              // Prompt user to input category name
              CustomTextField(
                controller: categoryNameController,
                hintText: "Enter category Name",
                labelText: "Category Name",
                obscureText: false,
                validatorText: "Please enter category name",
              ),
              const SizedBox(
                height: 15,
              ),
              // Prompt user to input budget limit
              CustomTextField(
                controller: budgetLimitController,
                hintText: "Enter budget Limit",
                labelText: "Enter Budget Limit (₱)",
                obscureText: false,
                validatorText: "Please enter budget limit",
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: fontSize['h4'],
                  fontFamily: poppins['regular'],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String newCategoryName = categoryNameController.text.trim();
                int newBudgetLimit =
                    int.parse(budgetLimitController.text.trim());

                if (newCategoryName.isNotEmpty) {
                  // Create a new category and add it to the list
                  CategoryData newCategory = CategoryData(
                    iconData: "0xe148", // IconData for the category
                    categoryName: newCategoryName,
                    leftLimit: newBudgetLimit,
                    categoryExpense: 0,
                  );

                  setState(() {
                    categories.add(newCategory);
                  });
                }
                Navigator.pop(context);
              },
              child: Text(
                'Add',
                style: TextStyle(
                  fontSize: fontSize['h4'],
                  fontFamily: poppins['regular'],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to remove a category
  void _removeCategory(CategoryData category, UserData userData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove Category'),
          content:
              Text('Are you sure you want to remove ${category.categoryName}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Remove the selected category from the list
                setState(() {
                  categories.remove(category);
                });
                Navigator.pop(context);
              },
              child: Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  // Checks if the category names are unique
  bool areCategoryNamesUnique(List<CategoryData> catagories) {
    Set<String> categoryNames =
        categories.map((category) => category.categoryName).toSet();
    return categoryNames.length == categories.length;
  }
}
