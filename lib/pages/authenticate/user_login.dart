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
import 'package:budgex/pages/authenticate/user_signup.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/shared/loading.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_textfield.dart';

import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  final Function toggleView;

  UserLogin({super.key, required this.toggleView});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  // Open Flutter Auth Authentication
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  // TextField Editing Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String error = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //logo
                        const Image(
                          image: AssetImage("assets/images/logo_light.png"),
                          height: 270,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                                validatorText: 'Please Enter your Email',
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
                                validatorText: 'Please Enter your Password',
                              ),

                              const SizedBox(
                                height: 15,
                              ),

                              CustomButtom(
                                  buttonText: "Sign In",
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      // Loads Loading Screen
                                      setState(() => isLoading = true);

                                      // 2 OUTPUTS RETURNED:
                                      // null and object type
                                      dynamic result =
                                          await _authService.signIn(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                      if (result == null) {
                                        setState(() {
                                          error =
                                              'Could not sign in with credentials';
                                          isLoading = false;
                                        });
                                      }
                                    }
                                  }),
                              const SizedBox(
                                height: 15,
                              ),

                              // Creates a widget group for links at the bottom of the Login Page
                              bottomLinks()
                            ],
                          ),
                        ),
                      ],
                    ),
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
            onPressed: () {
              // Function to navigate the user to the Sign Up page.
              widget.toggleView();
            },
            child: Text(
              "Sign Up?",
              style: TextStyle(
                  color: LIGHT_COLOR_3, fontFamily: poppins['poppins']),
            )),
        TextButton(
            onPressed: () async {
              // Loads a Loading Screen
              setState(() => isLoading = true);

              // TEST ANONYMOUS USER
              dynamic result = await _authService.signInAnon();

              if (result == null) {
                print("Error signing in");
                setState(() {
                  isLoading = false;
                });
              } else {
                print("User signed in!");
                print(result.uid);
                setState(() {
                  isLoading = false;
                });
              }
            },
            child: Text(
              "Sign Anonymously?",
              style: TextStyle(
                  color: LIGHT_COLOR_5, fontFamily: poppins['poppins']),
            )),
      ],
    );
  }
}
