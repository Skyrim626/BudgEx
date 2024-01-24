import 'package:budgex/model/category_model_dummy.dart';
import 'package:budgex/model/userModel.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/pages/home/user_add_expense.dart';
import 'package:budgex/pages/home/user_category_edit.dart';
import 'package:budgex/pages/home/user_scannerMain.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:budgex/shared/loading.dart';
import 'package:budgex/widgets/customDetectorCategory.dart';
import 'package:budgex/widgets/custom_appbar.dart';
import 'package:budgex/widgets/custom_buttom.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_circle_chart.dart';
import 'package:budgex/widgets/custom_drawer.dart';
import 'package:budgex/widgets/custom_dropdown_button.dart';
import 'package:budgex/widgets/custom_text.dart';
import 'package:budgex/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UserBudgeting extends StatefulWidget {
  UserBudgeting({super.key});

  @override
  State<UserBudgeting> createState() => _UserBudgetingState();
}

class _UserBudgetingState extends State<UserBudgeting> {
  // Create an instance of the FirebaseAuthService to manage authentication.
  final FirebaseAuthService _authService = FirebaseAuthService();

  late Stream<UserData?> userStream;

  // Controllers
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  late String selectedCategory;
  late List<String> items;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userStream =
        FirebaseFirestoreService(uid: _authService.getCurrentUser().uid)
            .userDocumentStream;
  }

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
            // Data loaded successfully
            UserData userData = snapshot.data!;
            items = List.generate(userData.budget.userCategories.length,
                (index) => userData.budget.userCategories[index].categoryName);
            selectedCategory = items[0];

            return StreamProvider<UserData?>.value(
                value: FirebaseFirestoreService(uid: userData.uid)
                    .userMainDocumentStream,
                initialData: userData,
                child: _buildBudgetingUI(
                    context, userData, selectedCategory, items));
          }
        });
  }

  // Builds Budgeting Widgets
  Scaffold _buildBudgetingUI(BuildContext context, UserData? data,
      String selectedCategory, List<String> categoryItems) {
    final userData = data;

    return Scaffold(
      appBar: customAppBar(context: context),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomButton(
          buttonText: "Add Expense",
          onPressed: () {
            //print("Test Add Expense");

            final route =
                MaterialPageRoute(builder: (context) => UserAddExpense());

            // Use Navigator.pushAndRemoveUntil to navigate to the UserAddExpense page and remove all previous routes
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(context, route, (route) => false);

            /* _displayBottomSheet(
                context, userData, selectedCategory, categoryItems); */
          },
          paddingHorizontal: 80,
          paddingVertical: 15,
          buttonColor: LIGHT_COLOR_3,
          fontSize: fontSize['h4']!,
          fontFamily: dosis['bold']!,
          textColor: Colors.white),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
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
                      CustomText(
                          title: "Most Expenses",
                          fontSize: fontSize['h5']!,
                          fontFamily: poppins['semiBold']!),

                      // Will add a button for this widget
                      TextButton(
                        onPressed: () async {
                          final route = MaterialPageRoute(
                              builder: (context) => UserCategoryEdit());

                          // Use Navigator.pushAndRemoveUntil to navigate to the UserCategoryEdit page and remove all previous routes
                          // ignore: use_build_context_synchronously
                          Navigator.pushAndRemoveUntil(
                              context, route, (route) => false);
                        },
                        child: CustomText(
                          title: "Edit Category",
                          fontSize: fontSize['h5']!,
                          fontFamily: poppins['semiBold']!,
                          titleColor: LIGHT_COLOR_3,
                        ),
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // Use userCategories from userData
                  ...userData?.budget.userCategories.map((category) {
                        print("Category Limit: ${category.leftLimit}");
                        return CustomCategoryDetector(
                          iconData: int.parse(category.iconData),
                          categoryName: category.categoryName,
                          leftLimit: category.leftLimit,
                          categoryExpense: category.categoryExpense,
                          // You can add other properties based on your needs
                        );
                      }).toList() ??
                      [],
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  // A method that displays the Drop Down Menu
  void _showDropDownMenu(
      BuildContext context, UserData? data, List<String> categoryName) {
    final userData = data;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: categoryName.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: CustomText(
                  title: categoryName[index],
                  fontSize: fontSize['h4']!,
                  fontFamily: poppins['regular']!,
                ),
                onTap: () {
                  setState(() {
                    selectedCategory = categoryName[index];
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

  // A method that displays the Drop Down UI Widget
  GestureDetector _dropDownUI(BuildContext context, UserData? data,
      String selectedCategory, List<String> categoryItems) {
    final userData = data;

    /* List<String> items = List.generate(userData!.budget.userCategories.length,
        (index) => userData!.budget.userCategories[index].categoryName);
    selectedCategory = items[0]; */

    return GestureDetector(
      onTap: () {
        _showDropDownMenu(context, userData, items);
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
                    title: userData!.budget.userCategories[0].categoryName,
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
    );
  }

  Future<void> _displayBottomSheet(BuildContext context, UserData? data,
      String selectedCategory, List<String> categoryItems) {
    final userData = data;

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
                              buttonText: "Scan Receipt",
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainScanner()));
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          _dropDownUI(
                              context, userData, selectedCategory, items),
                          // CustomDropDownButton(),
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

  // Builds and returns a Row widget representing the first row of a date range display.
  Row firstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // IconButton for navigating to the previous date range
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.chevron_left_outlined),
          iconSize: 30,
        ),

        // Text widget displaying the current date range
        Text(
          "Oct 29 - Nov 04, 2023",
          style: TextStyle(
            fontFamily: dosis['semiBold'],
            fontSize: fontSize['h3'],
          ),
        ),

        // IconButton for navigating to the next date range
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.chevron_right_outlined),
          iconSize: 30,
        ),
      ],
    );
  }
}
