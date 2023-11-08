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
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserLogin(),
        ));
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
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "This password should be different from the previous password.",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: LIGHT_COLOR_2,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    // Password TextFields
                    CustomTextField(
                        controller: () {},
                        hintText: "Enter New Password",
                        labelText: "New Password",
                        obscureText: true),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: () {},
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
                        buttonText: "Reset Password",
                        onPressed: toForgotPasswordPage)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
              color: LIGHT_COLOR_3, fontFamily: 'Poppins', fontSize: 11),
        )
      ],
    );
  }
}
