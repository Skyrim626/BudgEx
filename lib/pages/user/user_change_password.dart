/*
  Flutter Developer Notes:

  This Dart class manages the UI for the screen where users can change their password.
  It's a crucial step in ensuring account security and user authentication.

  Key Features:
  - Allows the user to enter a new password and confirm it.
  - Provides visual indicators for password strength requirements.
  - Includes buttons for navigating back to the Forgot Password page or for resetting the 
    password.

  Note: Consider adding an alert dialog for confirming the user's intent to change the password.

  You're doing a great job in implementing a user-friendly password change process!

*/

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:budgex/pages/user/user_forgot_password.dart';
import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/services/constants.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class UserChangePassword extends StatefulWidget {
  UserChangePassword({super.key});

  @override
  State<UserChangePassword> createState() => _UserChangePasswordState();
}

class _UserChangePasswordState extends State<UserChangePassword> {
  // TextField Editing Controllers
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Function to navigate the user to the Forgot Password page if the back_arrow icon is click.
  void toForgotPasswordPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserForgotPassword(),
        ));
  }

  // Function to navigate the user to the Login page.
  // NOTE: ADD A ALERT BOX FOR CONFIRM IF THE USER WANT TO CHANGE PASSWORD OR NOT
  void toLoginPage() {
    AwesomeDialog(
      context: context,
      btnCancelOnPress: () {},
      btnOkColor: LIGHT_COLOR_3,
      dialogType: DialogType.info,
      desc: "Are you sure you want to change your password?",
      btnOkOnPress: () {
        displaySuccessDialog(); // Display Success Dialog
      },
    ).show();
  }

  // Function that displays a success dialog if the password is change.
  void displaySuccessDialog() {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        desc: "Password Changed!",
        btnOkColor: LIGHT_COLOR_3,
        btnOkOnPress: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserLogin(),
              ));
        }).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: toForgotPasswordPage,
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //logo
              Image.asset(
                "../assets/images/logo_light.png",
                height: 200,
              ),

              // Padding
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),

                /* Text Info/Sign
              - Create new Password
              - Text Info */
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Create New Password",
                          style: TextStyle(
                              fontFamily: poppins['bold'],
                              fontSize: fontSize["h3"]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "This password should be different from the previous password.",
                      style: TextStyle(
                          fontFamily: poppins['regular'],
                          color: LIGHT_COLOR_2,
                          fontSize: fontSize["h4"]),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    // Password TextFields
                    CustomTextField(
                        controller: newPasswordController,
                        hintText: "Enter New Password",
                        labelText: "New Password",
                        obscureText: true),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: confirmPasswordController,
                        hintText: "Enter Confirm Password",
                        labelText: "Confirm Password",
                        obscureText: true),

                    // Verify Checkers
                    const SizedBox(
                      height: 30,
                    ),
                    customChecker(text: "At least 1 number"),
                    const SizedBox(
                      height: 8,
                    ),

                    customChecker(text: "At least 1 special character"),
                    const SizedBox(
                      height: 8,
                    ),

                    customChecker(text: "Both uppercase and lowercase letter"),

                    const SizedBox(
                      height: 25,
                    ),
                    // Reset Password Button
                    CustomButtom(
                        buttonText: "Reset Password", onPressed: toLoginPage)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*
    Generates a custom Row widget with a checkmark icon and a text.

    This function creates a Row containing an icon indicating a successful check, and a 
    text displaying verification information. The color of the icon and text is set to 
    LIGHT_COLOR_3.

    Args:
      - text: The verification text to be displayed.

    Returns:
      A Row widget with a checkmark icon and verification text.
  */
  Row customChecker({required String text}) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          color: LIGHT_COLOR_3,
        ),
        Text(
          text,
          style: TextStyle(
              color: LIGHT_COLOR_3,
              fontFamily: poppins['regular'],
              fontSize: fontSize["h6"]),
        )
      ],
    );
  }
}
