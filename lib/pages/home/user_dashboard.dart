import 'package:budgex/model/userModel.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:budgex/shared/loading.dart';
import 'package:budgex/widgets/customDetectorCategory.dart';

import 'package:budgex/widgets/custom_appbar.dart';
import 'package:budgex/widgets/custom_circle_chart.dart';
import 'package:budgex/widgets/custom_drawer.dart';
import 'package:budgex/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({super.key});

  @override
  State<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  // Create an instance of the FirebaseAuthService to manage authentication.
  final FirebaseAuthService _authService = FirebaseAuthService();

  late Stream<UserData?> userStream;

  @override
  void initState() {
    // Initialize the state
    super.initState();
    // Obtain the userStream from the user document using the FirebaseAuthService
    userStream =
        FirebaseFirestoreService(uid: _authService.getCurrentUser().uid)
            .userDocumentStream;
  }

  @override
  Widget build(BuildContext context) {
    // Build the widget based on the userStream
    return StreamBuilder<UserData?>(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading state while waiting for the data
            return Loading();
          } else if (snapshot.hasError) {
            // Error state if an error occurs while fetching data
            return Text("Error: ${snapshot.error}");
          } else {
            // Data loaded successfully, build the UI with the obtained user data
            UserData userData = snapshot.data!;
            return StreamProvider<UserData?>.value(
                value: FirebaseFirestoreService(uid: userData.uid)
                    .userMainDocumentStream,
                initialData: userData,
                child: _buildDashboardUI(context, userData));
          }
        });
  }

  // Builds the Dashboard Widgets
  Scaffold _buildDashboardUI(BuildContext context, UserData? data) {
    final userData = data;

    return Scaffold(
      appBar: customAppBar(context: context),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomText(
                title: "Good day, ${userData?.fullName}",
                fontSize: fontSize['h3']!,
                fontFamily: poppins['regular']!),

            const SizedBox(
              height: 20,
            ),

            CustomText(
                title: "WELCOME TO",
                fontSize: fontSize['h1']!,
                fontFamily: poppins['semiBold']!),

            CustomText(
                title: "BudgEx",
                fontSize: fontSize['h1']!,
                fontFamily: poppins['bold']!),

            const SizedBox(
              height: 45,
            ),

            CustomText(
                title: "Account No: ${userData?.uid}",
                fontSize: fontSize['h6']!,
                fontFamily: poppins['regular']!),

            const SizedBox(
              height: 15,
            ),
            CustomCircleChart(),
            const SizedBox(
              height: 20,
            ),

            // Expense Category Expenses
            Column(
              children: [
                CustomText(
                    title: "Most Expenses",
                    fontSize: fontSize['h4']!,
                    fontFamily: poppins['semiBold']!),

                const SizedBox(
                  height: 10,
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
    );
  }
}
