import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/services/firebase_auth_service.dart';
/* import 'package:budgex/services/theme_provider.dart'; */
import 'package:budgex/widgets/custom_appbar.dart';
import 'package:budgex/widgets/custom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
/* import 'package:provider/provider.dart'; */

class UserHomepage extends StatefulWidget {
  const UserHomepage({super.key});

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  // Create an instance of the FirebaseAuthService to manage authentication.
  final FirebaseAuthService _auth = FirebaseAuthService();

  // Declare User
  late User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Initialize User
    user = _auth.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: CustomDrawer(),
      body: Center(
        child: Text(user.email ?? "Empty"),
      ),
    );
  }
}
