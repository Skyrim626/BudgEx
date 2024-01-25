// Import necessary packages and files
import 'package:budgex/pages/home/user_create_budget.dart';
import 'package:budgex/pages/home/user_dashboard.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:budgex/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:budgex/model/userModel.dart';

// Class representing the user's home screen with verification logic
class UserHomeVerify extends StatefulWidget {
  const UserHomeVerify({super.key});

  @override
  State<UserHomeVerify> createState() => _UserHomeVerifyState();
}

class _UserHomeVerifyState extends State<UserHomeVerify> {
  // Create an instance of the FirebaseAuthService to manage authentication.
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Stream to listen for changes in the user's data
  late Stream<UserData?> userStream;

  @override
  void initState() {
    super.initState();
    // Initialize the stream with the user's data from Firestore
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
          // Loading state while waiting for user data
          return const Loading();
        } else if (snapshot.hasError) {
          // Error state if there's an issue fetching user data
          return Text("Error: ${snapshot.error}");
        } else {
          // User data loaded successfully
          UserData userData = snapshot.data!;

          if (userData.firstTimer) {
            // If it's the user's first time, show the budget creation screen
            return const UserCreateBudget();
          } else {
            // If not the first time, show the dashboard screen
            return const UserDashBoard();
          }
        }
      }),
    );
  }
}
