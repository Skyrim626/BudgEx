import 'package:budgex/data/categoryData.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/pages/home/user_create_budget.dart';

import 'package:budgex/pages/home/user_dashboard.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:budgex/shared/loading.dart';
import 'package:budgex/widgets/customDetectorCategory.dart';
import 'package:budgex/widgets/custom_appbar.dart';
import 'package:budgex/widgets/custom_buttom.dart';
import 'package:budgex/widgets/custom_circle_chart.dart';
import 'package:budgex/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:budgex/model/userModel.dart';

class UserHomeVerify extends StatefulWidget {
  const UserHomeVerify();

  @override
  State<UserHomeVerify> createState() => _UserHomeVerifyState();
}

class _UserHomeVerifyState extends State<UserHomeVerify> {
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
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state
          return const Loading();
        } else if (snapshot.hasError) {
          // Error state

          // Data Loads Successfully
          UserData userData = snapshot.data!;
          return Text("GOTCHA Error: ${snapshot.error}");
        } else {
          // Data Loads Successfully
          UserData userData = snapshot.data!;
          print("NOT NULL ${userData.dateRegistered}");
          if (userData.firstTimer) {
            return UserCreateBudget();
          } else {
            return UserDashBoard();
          }
        }
      }),
    );
  }
}
