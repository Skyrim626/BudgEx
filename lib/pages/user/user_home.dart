import 'package:budgex/model/expense_users.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:budgex/widgets/custom_appbar.dart';
import 'package:budgex/widgets/custom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserHomepage extends StatefulWidget {
  const UserHomepage({super.key});

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  // Create an instance of the FirebaseAuthService to manage authentication.
  final FirebaseAuthService _auth = FirebaseAuthService();

  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();

  // Declare User
  ExpenseUsers user = ExpenseUsers();

  @override
  void initState() {
    // TODO: implement initState
    // Initialize User data
    /* _initializeUserData(); */
    super.initState();

    /* user = _auth.getCurrentUser(); */
  }

  /* Future<void> _initializeUserData() async {
    try {
      // Get the current user
      User? currentUser = _auth.getCurrentUser();

      // Fetch user data from Firestore based on the email
      Map<String, dynamic> userData =
          await _firestoreService.getUserDataByEmail(currentUser.email);

      // Update the user instance with fetched data
      user = ExpenseUsers.fromMap(userData);
      /* print(user.getFullName); */

      setState(() {});
    } catch (e) {
      print("Error initializing user data: $e");
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: CustomDrawer(),
      body: Center(
        child: Column(),
      ),
    );
  }
}
