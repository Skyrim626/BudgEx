import 'package:budgex/services/constants.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  
  bool _obscureText = true; // Initially, set to true to obscure the text

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: (Column(
              children: [
                //logo
                Image.asset(
                  "../assets/images/logo_light.png",
                  height: 300,
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
                                fontFamily: 'Dosis',
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Sign In",
                            style: TextStyle(
                                fontFamily: 'Dosis',
                                fontSize: 15,
                                color: LIGHT_COLOR_2),
                          ),
                        ],
                      ),
          
                      // username textfield
                      TextFormField(
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Enter your username',
                          labelText: 'Username',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
          
                      // password textfield
                      TextFormField(
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
                      ),
                      const SizedBox(
                        height: 15,
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
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Dosis',
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.black),
                              )),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "Sign Up?",
                                style: TextStyle(color: LIGHT_COLOR_3),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
