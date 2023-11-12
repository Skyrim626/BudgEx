/*
  Flutter Developer Notes:

  This Dart class is responsible for the User Sign Up screen in our Flutter application.
  It allows new users to provide their information and register for an account.

  Key Components:
  - Text fields for entering full name, email, username, password, and confirming password.
  - Functions for crucial actions:
    - `toLoginPage`: Navigates the user back to the Login page.
    - `toUserRegisteredPage`: Redirects the user to a 'User Signed Up' page upon successful 
      form submission.
  - Rich UI elements including a logo and a button to initiate the sign-up process.
  - Dependencies include the user login page and a page for confirming successful registration.

  Note: Ensure that the password fields are working as expected, including the visibility toggle.

  Keep up the excellent work!
*/

// [Rest of the code remains unchanged]

import 'package:budgex/pages/user/user_done_register.dart';
import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/services/constants.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({super.key});

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  bool _passwordText =
      true; // Initially, set to true to obscure the text (Password TextField)
  bool _confirmPasswordText =
      true; // Initially, set to true to obscure the text (Confirm Password TextField)

  // Function to navigate the user to the Login page.
  void toLoginPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserLogin(),
        ));
  }

  /*
  Navigates the user to the 'User Signed Up' page upon successful form submission.

  This function handles the redirection logic after the user has successfully filled 
  out the required details and submitted the form. It should navigate to the page 
  displaying a success message or confirmation of registration.
*/
  void toUserRegisteredPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserSignedUp(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: toLoginPage,
          icon: const Icon(Icons.arrow_back),
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
              Image(
                image: AssetImage("assets/images/logo_light.png"),
                height: 200,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    // Full name textfield
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your full name',
                        labelText: 'Enter your full name',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Email textfield
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // username textfield
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your username',
                        labelText: 'Username',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Password textfield
                    TextFormField(
                      obscureText: _passwordText,
                      decoration: InputDecoration(
                          hintText: 'Enter your new password',
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordText = !_passwordText;
                              });
                            },
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Confirm Password textfield
                    // Password textfield
                    TextFormField(
                      style: TextStyle(fontFamily: poppins['regular']),
                      obscureText: _confirmPasswordText,
                      decoration: InputDecoration(
                          hintText: 'Enter your confirm password',
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _confirmPasswordText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _confirmPasswordText = !_confirmPasswordText;
                              });
                            },
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    CustomButtom(
                        buttonText: "Sign Up", onPressed: toUserRegisteredPage),
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
