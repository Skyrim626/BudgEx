import 'package:budgex/model/userModel.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:budgex/shared/loading.dart';
import 'package:budgex/widgets/customDetectorCategory.dart';
import 'package:budgex/widgets/custom_appbar.dart';
import 'package:budgex/widgets/custom_buttom.dart';
import 'package:budgex/widgets/custom_circle_chart.dart';
import 'package:budgex/widgets/custom_drawer.dart';
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
            //print("HERRSIDAIDJASIDj");
            return Text(" HERRSIDAIDJASIDjError: ${snapshot.error}");
          } else {
            // Data loaded successfully
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
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Text(
            "Good day, ${userData?.fullName}",
            style: TextStyle(
                fontSize: fontSize['h3'], fontFamily: poppins['regular']),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "WELCOME TO",
            style: TextStyle(
              fontSize: fontSize['h1'],
              fontFamily: poppins['semiBold'],
            ),
          ),
          Text(
            "BudgEx",
            style: TextStyle(
                fontSize: fontSize['h1'], fontFamily: poppins['bold']),
          ),
          const SizedBox(
            height: 45,
          ),
          Text(
            "Account No: ${userData?.uid}",
            style: TextStyle(
                fontFamily: poppins['regular'], fontSize: fontSize['h6']),
          ),

          const SizedBox(
            height: 15,
          ),
          CustomButtom(buttonText: "Add Expense", onPressed: () {}),
          const SizedBox(
            height: 10,
          ),
          CustomCircleChart(),
          const SizedBox(
            height: 20,
          ),

          // Expense Category Expenses
          // Only displays 3 (Starts from higher expenses)

          Column(
            children: [
              Text(
                "Most Expenses",
                style: TextStyle(
                  fontFamily: poppins['semiBold'],
                  fontSize: fontSize['h4'],
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              // Use userCategories from userData
              ...userData?.budget.userCategories.map((category) {
                    return CustomCategoryDetector(
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
      )),
    );
  }
}
