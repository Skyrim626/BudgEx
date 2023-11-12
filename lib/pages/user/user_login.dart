/*
  Flutter Developer Notes:

  This Dart class is the heart of the user login screen in our Flutter application. 
  It's where users will enter their credentials and initiate the login process.

  Key Components:
  - Text editing controllers for the username and password fields, allowing us to 
    retrieve and manage user input.
  - Functions for crucial actions:
    - `signUserInPage`: Navigates the user to their homepage upon successful login.
    - `signUpUserPage`: Redirects the user to the Sign Up page for account creation.
    - `toForgotPasswordPage`: Sends the user to the Forgot Password page for recovery.
  - Rich UI elements including a logo, welcoming text, input fields, and buttons.
  - Dependencies include pages for forgotten passwords, the user's home screen, 
    and user registration, as well as constants and custom UI widgets.

  Note: Be sure to check and potentially fix the 'usernameController' assignment 
  for the password text field. It may need to be 'passwordController' instead.

  Happy Coding!
*/

// [Rest of the code remains unchanged]

import 'package:budgex/pages/user/user_forgot_password.dart';
import 'package:budgex/pages/user/user_home.dart';
import 'package:budgex/pages/user/user_signup.dart';
import 'package:budgex/services/constants.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_textfield.dart';

import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  /*  bool _obscureText = true; */ // Initially, set to true to obscure the text

  // TextField Editing Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Function to sign in the user and redirect them to their homepage.
  void toSignUserInPage() {
    // Use the Navigator to push a new route onto the navigator's stack.
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserHomepage(),
        ));
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

                      // Username TextField
                      CustomTextField(
                        controller: usernameController,
                        hintText: 'Enter your username',
                        labelText: 'Username',
                        obscureText: false,
                      ),

                      /* TextFormField(
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Enter your username',
                          labelText: 'Username',
                        ),
                      ), */
                      const SizedBox(
                        height: 10,
                      ),

                      // Password textfield
                      CustomTextField(
                        controller: usernameController,
                        hintText: 'Enter your password',
                        labelText: 'Password',
                        obscureText: true,
                      ),

                      /* TextFormField(
                        autofocus: true,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            hintText: 'Enter your password',
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            )),
                      ), */
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
