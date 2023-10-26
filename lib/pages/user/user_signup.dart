import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/services/constants.dart';
import 'package:flutter/material.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({super.key});

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {

  bool _passwordText = true; // Initially, set to true to obscure the text (Password TextField)
  bool _confirmPasswordText = true; // Initially, set to true to obscure the text (Confirm Password TextField)

  
  // Allows the user to return to the login page 
  void returnToLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserLogin(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: returnToLogin,
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
              Image.asset(
                "../assets/images/logo_light.png",
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

                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: LIGHT_COLOR_3,
                      ),
                      onPressed: null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80.0, vertical: 15), // Add padding here
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Dosis',
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
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
