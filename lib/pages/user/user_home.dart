import 'package:budgex/pages/user/user_login.dart';
import 'package:flutter/material.dart';

class UserHomepage extends StatefulWidget {
  const UserHomepage({super.key});

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {


  // This allows the user to log out and return to the Login Page
  void userLogOut() {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserLogin(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text("Welcome To The HomePage"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: userLogOut, icon: const Icon(Icons.logout)),
        ],
      ),
    );
  }
}