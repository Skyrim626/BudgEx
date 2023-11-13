import 'package:budgex/pages/user/user_home.dart';
import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Open Firebase Authentication Service
    final FirebaseAuthService auth = FirebaseAuthService();

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: auth.authStateChanges,
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            /*  User? user = snapshot.data;
            print(user?.uid); */
            return UserHomepage();
          }

          // user is NOT logged in
          else {
            return UserLogin();
          }
        },
      ),
    );
  }
}
