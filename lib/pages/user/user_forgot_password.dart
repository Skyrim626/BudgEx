/*
  Flutter Developer Notes:

  This Dart class manages the UI for the 'Forgot Password' feature. It enables users 
  to initiate the process of resetting their password by entering their associated 
  email address.

  Key Components:
  - A text field for users to input their email address.
  - Functions for essential actions:
    - `toVerifyCodePage`: Navigates to the verification code page if the email address 
      exists in the system, initiating the password reset process.
    - `toLoginPage`: Allows the user to return to the login page.
  - Rich UI elements including a logo, instructional text, and a button to continue 
    the process.
  - Dependencies include the user login page and custom UI widgets.

  Note: The 'toVerifyCodePage' function should be implemented to handle navigation 
  to the verification code page.

  Keep up the great work!
*/

import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/pages/user/user_verify_code.dart';
import 'package:budgex/services/constants.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class UserForgotPassword extends StatefulWidget {
  const UserForgotPassword({super.key});

  @override
  State<UserForgotPassword> createState() => _UserForgotPasswordState();
}

class _UserForgotPasswordState extends State<UserForgotPassword> {
  final emailController = TextEditingController();

  /*
  Navigates the user to the verification code page if their email address exists in the system.

  This function handles the navigation logic when a user's email address is verified and 
  exists in our records. It should trigger the transition to the page where users input 
  their verification code.
*/
  void toVerifyCodePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserVerifyCode(),));
  }

  // Function to navigate the user to the Login page.
  void toLoginPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserLogin(),));
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: toLoginPage,
          color: LIGHT_COLOR_5,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    Text(
                      "Enter the email address associated with your account and we’ll send you a link to reset your password.",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: LIGHT_COLOR_2,
                          fontSize: 14),
                    ),

                    const SizedBox(
                        height: 25,
                      ),

                    CustomTextField(
                        controller: emailController,
                        hintText: "Enter your email address",
                        labelText: "Email",
                        obscureText: false),

                    const SizedBox(
                        height: 25,
                      ),

                    CustomButtom(buttonText: "Continue", onPressed: toVerifyCodePage),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
