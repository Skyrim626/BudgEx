
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
  void returnToLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserLogin(),));
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
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Dosis',
                          fontSize: 24,
                          color: LIGHT_COLOR_5,
                        ),
                        ),
                      const SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Congratulations! You have successfully created an account here on BudgEx. You can now sign in using the account you created.",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: LIGHT_COLOR_2,
                        ),
                        ),

                      const SizedBox(
                        height: 35,
                      ),
                      CustomButtom(buttonText: "Back to Sign In", onPressed: returnToLogin),
                    ],
                  ),
                )
            ],
          )
        ),
      ),
    );
  }
}