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

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/services/constants.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class UserForgotPassword extends StatefulWidget {
  const UserForgotPassword({super.key});

  @override
  State<UserForgotPassword> createState() => _UserForgotPasswordState();
}

class _UserForgotPasswordState extends State<UserForgotPassword> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  // Text Controller
  final _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  /*
  Navigates the user to the verification code page if their email address exists in the system.

  This function handles the navigation logic when a user's email address is verified and 
  exists in our records. It should trigger the transition to the page where users input 
  their verification code.
*/
  void toVerifyCodePage() {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // Open firebase authentication service
      final FirebaseAuthService auth = FirebaseAuthService();

      // Show loading circle
      showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      // Checks if the email exist (for verification)
      auth
          .passwordReset(email: _emailController.text.trim())
          .then((isEmailExist) => {
                if (isEmailExist)
                  {
                    // pop the loading circle
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context),

                    // Navigates the user to the Verification code Screen
                    /* Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserVerifyCode(),
                      )) */

                    // Navigates the user to the Login Screen
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        desc: "Password Reset Email Sent.",
                        btnOkOnPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserLogin()));
                        }).show(),
                  }
                else
                  {
                    // pop the loading circle
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context),
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            desc:
                                "The email you currently inputted does not exist.",
                            btnOkOnPress: () {},
                            btnOkColor: LIGHT_COLOR_3)
                        .show()
                  }
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Function to navigate the user to the Login page.
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserLogin(),
                ));
          },
          color: Theme.of(context).colorScheme.tertiary,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //logo
                const Image(
                  image: AssetImage("assets/images/logo_light.png"),
                  height: 200,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      Text(
                        "Enter the email address associated with your account and we’ll send you a link to reset your password.",
                        style: TextStyle(
                            fontFamily: poppins['regular'],
                            color: LIGHT_COLOR_2,
                            fontSize: fontSize["h4"]),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomTextField(
                        controller: _emailController,
                        hintText: "Enter your email address",
                        labelText: "Email",
                        obscureText: false,
                        validatorText: "Please enter your email address",
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomButtom(
                          buttonText: "Continue", onPressed: toVerifyCodePage),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
