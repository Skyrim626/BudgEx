import 'package:budgex/model/category_model_dummy.dart';
import 'package:budgex/model/userModel.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/widgets/customDetectorCategory.dart';
import 'package:budgex/widgets/custom_circle_chart.dart';
import 'package:budgex/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeFeature extends StatefulWidget {
  const HomeFeature({super.key});

  @override
  State<HomeFeature> createState() => _HomeFeatureState();
}

class _HomeFeatureState extends State<HomeFeature> {
  // Open Firebase Auth Service
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData?>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await _authService.signUserOut();
              },
              icon: Icon(Icons.logout))
        ],
      ) /* appBar: customAppBar(context: context) */,
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
              ...dummyCategories
                  .asMap()
                  .map((index, category) => MapEntry(
                        index,
                        CustomCategoryDetector(
                          categoryName: category["categoryName"],
                          leftLimit: category["leftLimit"],
                          expenses: category["expenses"],
                          categoryIconData: category["categoryIconData"],
                          // Other properties...
                          test: index, // You can now access the index
                        ),
                      ))
                  .values
                  .toList()
            ],
          )
        ],
      )),
    );
  }
}
