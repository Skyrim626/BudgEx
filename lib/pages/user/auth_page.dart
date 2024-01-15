import 'package:budgex/model/end_users.dart';
import 'package:budgex/pages/user/user_home.dart';
import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // Firebase Authentication Service
  final FirebaseAuthService auth =
      FirebaseAuthService(); // Service for managing authentication

// Firestore Service
  final FirebaseFirestoreService _fireStoreService =
      FirebaseFirestoreService(); // Service for interacting with Firestore database

// User Object
// This object is used for storing and manipulating user data
  late EndUser currentUser = EndUser(fullName: "", age: 0, email: "");

  @override
  void initState() {
    // TODO: implement initState

    _initializeCurrentUser();
    super.initState();
  }

  /// Asynchronously initializes the current user by retrieving user data from Firestore.
  ///
  /// This method uses the [_fireStoreService.getUserDataByEmail] function to fetch user data
  /// based on the user's email address. The data is then assigned to the [currentUser]
  /// variable, and the UI is updated using [setState].
  ///
  /// If any errors occur during the initialization process, they are caught and logged.
  ///
  /// Note: This method is typically called in the [initState] lifecycle method of the
  /// corresponding State object.
  Future<void> _initializeCurrentUser() async {
    try {
      // Use await to wait for the Future to complete
      currentUser = await _fireStoreService.getUserDataByEmail();

      // Update the UI after obtaining the user data
      setState(() {});
    } catch (e) {
      // Handle any errors that might occur during the initialization
      print("Error initializing user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: auth.authStateChanges,
        builder: (context, snapshot) {
          // if user is logged in
          // Return Home Page
          if (snapshot.hasData) {
            return UserHomepage(
              endUser: currentUser,
            );
          }

          // if user is not logged in
          // return Login Page
          else {
            return UserLogin();
          }
        },
      ),
    );
  }
}
