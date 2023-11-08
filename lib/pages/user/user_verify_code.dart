/*
  Flutter Developer Notes:

  This Dart class handles the UI for the screen where users enter a verification code sent to 
  their email address. This step is critical in the registration process.

  Key Components:
  - A message guides the user to check their email for the confirmation code.
  - Input fields for the verification code are divided into five separate boxes.
  - A button allows the user to request a new code if necessary.
  - Functions for essential actions:
    - `toLoginPage`: Navigates the user back to the Login page.
    - `toChangingPasswordPage`: Placeholder for navigating to the Change Password page after 
      successful code verification.
  - Dependencies include the user login page and custom UI widgets.

  Note: Ensure that the verification code input is functioning as expected and that the 
  navigation to the Change Password page is implemented.

  You're doing a great job providing a seamless user experience for this critical registration step!
*/

// [Rest of the code remains unchanged]

import 'package:budgex/pages/user/user_change_password.dart';
import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/services/constants.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserVerifyCode extends StatefulWidget {
  const UserVerifyCode({super.key});

  @override
  State<UserVerifyCode> createState() => _UserVerifyCodeState();
}

class _UserVerifyCodeState extends State<UserVerifyCode> {
  // Function to navigate the user to the Login page.
  void toLoginPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserLogin(),
        ));
  }

  // Function to navigate the user to the Change Password page if their code is verified.
  void toChangingPasswordPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserChangePassword(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: toLoginPage,
          color: Theme.of(context).colorScheme.tertiary,
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
                      "Check your email to get your confirmation code. If you need to request a new code, go back and re-enter email.",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: LIGHT_COLOR_2,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    digitCodeLayout(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Send code again",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: LIGHT_COLOR_2,
                            fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomButtom(
                        buttonText: "Confirm",
                        onPressed: toChangingPasswordPage),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

/*
  Generates a layout for a single pin code input field.

  This function creates a styled TextFormField with a width calculated based on the screen size 
  divided by 7 (for 7 boxes). It includes logic to handle input events, limiting the input to 
  one character and moving focus to the next input field when a character is entered.

  Args:
    - pinCode: Identifier for the pin code (e.g., "pinCode1", "pinCode2", ...).

  Returns:
    A SizedBox containing a TextFormField for pin code input.
*/
  SizedBox generatePinCodeLayout({required pinCode}) {
    double boxWidth =
        MediaQuery.of(context).size.width / 7; // Divide by 7 for 7 boxes

    return SizedBox(
      height: 75,
      width: boxWidth,
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        onSaved: (pinCode) {},
        decoration: InputDecoration(
            hintText: "0",
            filled: true,
            fillColor: LIGHT_COLOR_1,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4))),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }

  /*
  Generates the layout for the entire digit code input.

  This function creates a Form containing a row of 5 pin code input fields generated using 
  generatePinCodeLayout function. It arranges the input fields with space in between and 
  ensures they are evenly distributed.

  Returns:
    A Form widget containing a row of pin code input fields.
*/
  Form digitCodeLayout() {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          generatePinCodeLayout(pinCode: "pinCode1"),
          generatePinCodeLayout(pinCode: "pinCode2"),
          generatePinCodeLayout(pinCode: "pinCode3"),
          generatePinCodeLayout(pinCode: "pinCode4"),
          generatePinCodeLayout(pinCode: "pinCode5"),
        ],
      ),
    );
  }
}
