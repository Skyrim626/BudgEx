import 'package:budgex/model/end_users.dart';
import 'package:budgex/pages/user/user_home.dart';
import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Open Firebase Authentication Service
    final FirebaseAuthService auth = FirebaseAuthService();
    final FirebaseFirestore _fireStoreService = FirebaseFirestore.instance;

    // User Object
    late EndUser currentUser;

    initState() {}

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: auth.authStateChanges,
        builder: (context, snapshot) {
          // if user is logged in
          // Return Home Page
          if (snapshot.hasData) {
            return UserHomepage();
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
