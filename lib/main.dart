import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/pages/user/user_signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserLogin(),
      /* home: UserSignUp(), */
    );
  }

}