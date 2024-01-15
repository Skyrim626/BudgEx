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
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({super.key});

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  // Open firestore service
  final FirebaseFirestoreService _firestoreDatabase =
      FirebaseFirestoreService();

  // Open firebase authentication service
  final FirebaseAuthService _auth = FirebaseAuthService();

  // Text Editing Controller
  final _fullNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  /* final _usernameController = TextEditingController(); */
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  /*
  Navigates the user to the 'User Signed Up' page upon successful form submission.

  This function handles the redirection logic after the user has successfully filled 
  out the required details and submitted the form. It should navigate to the page 
  displaying a success message or confirmation of registration.
*/
  /* void toUserRegisteredPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserSignedUp(),
        ));
  } */

  // A function that checks the credentials
  // Checks the if the password are matched
  // User redirects to the home screen if the credentials are valid
  Future toUserRegisteredPage() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // Show loading circle
      showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      //authenticate user
      if (passwordConfirmed()) {
        // Create New User
        _auth.createUserEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
      }

      // Add user details
      _firestoreDatabase.addUser(
          fullName: _fullNameController.text.trim(),
          age: int.parse(_ageController.text.trim()),
          email: _emailController.text.trim());

      // pop the loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // Redirects the user to a new page named (Registered Page)
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserSignedUp(),
          ));
    }
  }

  // A function that checks if the password is matched
  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  // A function that dispose the all the inputted text in the text fields
  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Function to navigate the user to the Login page.
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserLogin(),
                ));
          },
          icon: const Icon(Icons.arrow_back),
          color: LIGHT_COLOR_5,
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
                      // Full name textfield
                      CustomTextField(
                        controller: _fullNameController,
                        hintText: "Enter your full name",
                        labelText: "Full Name",
                        obscureText: false,
                        validatorText: "Please enter your full name",
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // Age textfield
                      CustomTextField(
                        controller: _ageController,
                        hintText: "Enter your age",
                        labelText: "Age",
                        obscureText: false,
                        validatorText: "Please enter your age",
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // Email textfield
                      CustomTextField(
                        controller: _emailController,
                        hintText: "Enter your email",
                        labelText: "Email",
                        obscureText: false,
                        validatorText: "Please enter your email",
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // Password textfield,
                      CustomTextField(
                          controller: _passwordController,
                          hintText: "Enter your new password",
                          labelText: "Password",
                          obscureText: true,
                          validatorText: "Please enter your password"),

                      const SizedBox(
                        height: 10,
                      ),
                      // Confirm Password textfield
                      CustomTextField(
                          controller: _confirmPasswordController,
                          hintText: "Enter your confirm password",
                          labelText: "Confirm Password",
                          obscureText: true,
                          validatorText: "Please enter your confirm password"),

                      const SizedBox(
                        height: 10,
                      ),

                      CustomButtom(
                          buttonText: "Sign Up",
                          onPressed: toUserRegisteredPage),
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
