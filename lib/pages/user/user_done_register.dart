/*
  Flutter Developer Notes:

  This Dart class represents the UI for the screen displayed after a user has successfully
  registered for an account. It provides confirmation and instructions for the next steps.

  Key Components:
  - A congratulatory message and instructions for using the newly created account.
  - A button to return to the Sign In page.
  - Dependencies include the user login page and custom UI widgets.

  Note: Make sure that the navigation to the Sign In page is functioning correctly.

  Great job on creating this user-friendly experience!
*/

// [Rest of the code remains unchanged]

import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/services/constants.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserSignedUp extends StatefulWidget {
  const UserSignedUp({super.key});

  @override
  State<UserSignedUp> createState() => _UserSignedUpState();
}

class _UserSignedUpState extends State<UserSignedUp> {
  // Allows the user to return to the login page
  void toLoginPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserLogin(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            //logo
            Image.asset(
              "../assets/images/logo_light.png",
              height: 300,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  Text(
                    "Registered",
                    style: TextStyle(
                      fontFamily: dosis['bold'],
                      fontSize: fontSize["h4"],
                      color: LIGHT_COLOR_5,
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    "Congratulations! You have successfully created an account here on BudgEx. You can now sign in using the account you created.",
                    style: TextStyle(
                      fontFamily: poppins['regular'],
                      color: LIGHT_COLOR_2,
                      fontSize: fontSize["h4"],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  CustomButtom(
                      buttonText: "Back to Sign In", onPressed: toLoginPage),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
