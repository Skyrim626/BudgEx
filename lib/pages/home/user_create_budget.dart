import 'package:budgex/data/categoryData.dart';
import 'package:budgex/model/userModel.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:budgex/shared/loading.dart';
import 'package:budgex/widgets/custom_buttom.dart';
import 'package:budgex/widgets/custom_text.dart';
import 'package:budgex/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UserCreateBudget extends StatefulWidget {
  const UserCreateBudget({super.key});

  @override
  State<UserCreateBudget> createState() => _UserCreateBudgetState();
}

class _UserCreateBudgetState extends State<UserCreateBudget> {
  // Create an instance of the FirebaseAuthService to manage authentication.
  final FirebaseAuthService _authService = FirebaseAuthService();

  List<CategoryData> categories =
      sampleCategories.take(3).toList(); // Limit to 3 categories initially

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
            return const Loading();
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
                child: _buildCreateBudgetUI(context, userData));
          }
        });
  }

  // Builds the Create Budget
  Scaffold _buildCreateBudgetUI(BuildContext context, UserData? data) {
    // Create a global key that uniquely identifies the Form widget
    // and allows validation of the form.
    //
    // Note: This is a `GlobalKey<FormState>`,
    // not a GlobalKey<MyCustomFormState>.
    final _formKey = GlobalKey<FormState>();

    TextEditingController budgetDeclaredController = TextEditingController();

    final userData = data;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            //logo
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
                        fontFamily: poppins['semiBold']!),

                    const SizedBox(height: 10),

                    // Declare Budget Amount
                    TextFormField(
                      controller: budgetDeclaredController,
                      style: TextStyle(
                        fontFamily: poppins['regular'],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a budget amount";
                        }

                        // Check if the entered value is a number
                        if (double.tryParse(value) == null) {
                          return "Please enter a valid number";
                        }

                        return null;
                      },
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true), // Allow decimal input
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d+\.?\d{0,2}$')), // Allow only digits and up to 2 decimal places
                      ],
                      decoration: const InputDecoration(
                          prefixText: "₱",
                          hintText: "Enter your budget amount",
                          labelText: "Budget Amount"),
                    ),

                    // Categories Section
                    const SizedBox(height: 40),

                    CustomText(
                        title: 'Categories',
                        fontSize: fontSize['h3']!,
                        fontFamily: poppins['semiBold']!),

                    /* Text(
                      'Categories',
                      style: TextStyle(
                          fontSize: fontSize['h3'],
                          fontFamily: poppins['semiBold']),
                    ), */

                    const SizedBox(height: 15),

                    // Display existing categories
                    Column(
                      children: categories.map((category) {
                        return GestureDetector(
                          onTap: () {
                            _editCategory(context, userData!, category);

                            print(category.iconData);
                          },
                          child: ListTile(
                            title: Text(category.categoryName),
                            leading: Icon(IconData(category.iconData,
                                fontFamily: 'MaterialIcons')),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Button to add a new category
                        ElevatedButton(
                          onPressed: () {
                            _addCategory(context, userData);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Add Category",
                              style: TextStyle(
                                  fontFamily: poppins['regular'],
                                  fontSize: fontSize['h5']),
                            ),
                          ),
                        ),
                        // Confirm Budget
                        ElevatedButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Confirm Budget",
                              style: TextStyle(
                                  fontFamily: poppins['regular'],
                                  fontSize: fontSize['h5']),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
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
                double editedBudgetLimit =
                    double.parse(budgetLimitController.text.trim());

                if (editedCategoryName.isNotEmpty) {
                  setState(() {
                    category.categoryName = editedCategoryName;
                    category.leftLimit = editedBudgetLimit;
                    // _updateUserCategories(context, userData, categories);
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

  // Functioon to add a new category
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
                  fontFamily: poppins['semiBold'], fontSize: fontSize['h4']),
            ),
            content: Column(
              children: [
                // Prompts the User to input Category Name
                CustomTextField(
                    controller: categoryNameController,
                    hintText: "Enter category Name",
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
                  double newBudgetLimit =
                      double.parse(budgetLimitController.text.trim());

                  if (newCategoryName.isNotEmpty) {
                    // Category IconData
                    int newIconData = 0xe148;
                    double newCategoryExpense = 0.0;

                    CategoryData newCategory = CategoryData(
                      iconData: newIconData,
                      categoryName: newCategoryName,
                      leftLimit: newBudgetLimit,
                      categoryExpense: newCategoryExpense,
                    );

                    setState(() {
                      categories.add(newCategory);
                      // _updateUserCategories(context, userData, categories);

                      for (CategoryData category in categories) {
                        print(category.categoryName);
                      }
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
        });
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
                setState(() {
                  categories.remove(category);
                  // _updateUserCategories(context, userData, categories);
                  for (CategoryData category in categories) {
                    print(category.categoryName);
                  }
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
}
