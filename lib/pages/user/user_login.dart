/*
  Flutter Developer Notes:

  This Dart class is the heart of the user login screen in our Flutter application. 
  It's where users will enter their credentials and initiate the login process.

  Key Components:
  - Text editing controllers for the email and password fields, allowing us to 
    retrieve and manage user input.
  - Functions for crucial actions:
    - `signUserInPage`: Navigates the user to their homepage upon successful login.
    - `signUpUserPage`: Redirects the user to the Sign Up page for account creation.
    - `toForgotPasswordPage`: Sends the user to the Forgot Password page for recovery.
  - Rich UI elements including a logo, welcoming text, input fields, and buttons.
  - Dependencies include pages for forgotten passwords, the user's home screen, 
    and user registration, as well as constants and custom UI widgets.

  Note: Be sure to check and potentially fix the 'emailController' assignment 
  for the password text field. It may need to be 'passwordController' instead.

  Happy Coding!
*/

// [Rest of the code remains unchanged]

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:budgex/pages/user/user_forgot_password.dart';
import 'package:budgex/pages/user/user_signup.dart';
import 'package:budgex/services/constants.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  /*  bool _obscureText = true; */ // Initially, set to true to obscure the text

  // TextField Editing Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Function to sign in the user and redirect them to their homepage.
  void toSignUserInPage() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    // try sign in
    // Authentication successful, navigate to the Home screen.
    // Open Firebase Authenticaion service
    // NOTE: This is a User Defined Class
    final FirebaseAuthService auth = FirebaseAuthService();

    // Checks the credentials
    auth
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((isSignedInSuccessfully) => {
              if (isSignedInSuccessfully ?? false)
                {
                  // Sign in was Successful
                  print("Sign In was successful!")
                }
              else
                {
                  // A dialog will be displayed if the credentials are invalid.
                  AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          desc: 'Invalid Credentials',
                          btnOkOnPress: () {},
                          btnOkColor: LIGHT_COLOR_3)
                      .show()
                }
            });
    // pop the loading circle
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  // Function to navigate the user to the Sign Up page.
  void toSignUpUserPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserSignUp(),
        ));
  }

  // Function to navigate the user to the Forgot Password page.
  void toForgotPasswordPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserForgotPassword(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //logo
                Image(
                  image: AssetImage("assets/images/logo_light.png"),
                  height: 270,
                ),
                /* const SizedBox(height: 5,), */

                // Welcome Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                                fontFamily: dosis["semiBold"],
                                fontSize: fontSize["h1"],
                                letterSpacing: 2),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Sign In",
                            style: TextStyle(
                                fontFamily: dosis["regular"],
                                fontSize: fontSize['h4'],
                                color: LIGHT_COLOR_2),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      // Email TextField
                      CustomTextField(
                        controller: emailController,
                        hintText: 'Enter your email',
                        labelText: 'Email',
                        obscureText: false,
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // Password textfield
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'Enter your password',
                        labelText: 'Password',
                        obscureText: true,
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      CustomButtom(
                          buttonText: "Sign In", onPressed: toSignUserInPage),
                      const SizedBox(
                        height: 15,
                      ),
                      bottomLinks()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widgets for "Forgot Password?" and "Sign Up?" links

  Row bottomLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: toForgotPasswordPage,
            child: Text(
              "Forgot Password?",
              style: TextStyle(
                  color: Colors.black, fontFamily: poppins['regular']),
            )),
        TextButton(
            onPressed: toSignUpUserPage,
            child: Text(
              "Sign Up?",
              style: TextStyle(
                  color: LIGHT_COLOR_3, fontFamily: poppins['poppins']),
            )),
      ],
    );
  }
}
