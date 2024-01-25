// Import necessary packages and files
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/shared/loading.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_text.dart';
import 'package:flutter/material.dart';

// A class responsible for the Login Screen
class UserLogin extends StatefulWidget {
  final Function toggleView;

  const UserLogin({super.key, required this.toggleView});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  // Firebase Authentication Service instance
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Global key to uniquely identify the Form widget for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for email and password text fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Flag to toggle password visibility
  bool isObscure = true;

  String error = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Scaffold(
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Logo
                        const Image(
                          image: AssetImage("assets/images/logo_light.png"),
                          height: 270,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            children: [
                              // Welcome Title
                              Row(
                                children: [
                                  CustomText(
                                    title: "Welcome",
                                    fontSize: fontSize['h1']!,
                                    fontFamily: dosis['semiBold']!,
                                    letterSpacing: 2,
                                  ),
                                ],
                              ),

                              // Sign In Title
                              Row(
                                children: [
                                  CustomText(
                                    title: 'Sign In',
                                    fontSize: fontSize['h4']!,
                                    fontFamily: dosis['regular']!,
                                    titleColor: LIGHT_COLOR_2,
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 5,
                              ),

                              // Email TextField
                              TextFormField(
                                controller: emailController,
                                style: TextStyle(
                                  fontFamily: poppins['regular'],
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Enter your email',
                                  labelText: 'Email',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your email";
                                  }

                                  if (!value.contains('@')) {
                                    return "Please enter a valid email address";
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              // Password TextField
                              TextFormField(
                                controller: passwordController,
                                style: TextStyle(
                                  fontFamily: poppins['regular'],
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter your password',
                                  labelText: 'Password',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isObscure = !isObscure;
                                      });
                                    },
                                    icon: Icon(
                                      isObscure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                ),
                                obscureText: isObscure,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your password";
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(
                                height: 15,
                              ),

                              // Sign In Button
                              CustomButton(
                                buttonText: "Sign In",
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // Show Loading Screen
                                    setState(() => isLoading = true);

                                    // Attempt to sign in
                                    dynamic result = await _authService.signIn(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );

                                    if (result == null) {
                                      // Handle unsuccessful sign-in
                                      setState(() {
                                        error =
                                            'Could not sign in with credentials';
                                        isLoading = false;

                                        // Display Awesome Dialog for Invalid Credentials or could not sign in
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.warning,
                                          animType: AnimType.rightSlide,
                                          title: error,
                                          btnOkOnPress: () {},
                                        ).show();
                                      });
                                    }
                                  }
                                },
                                paddingHorizontal: 80,
                                paddingVertical: 15,
                                buttonColor: LIGHT_COLOR_3,
                                fontSize: fontSize['h4']!,
                                fontFamily: dosis['bold']!,
                                textColor: Colors.white,
                              ),

                              const SizedBox(
                                height: 15,
                              ),

                              // Links at the bottom of the Login Page
                              bottomLinks(),
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
        // Sign Up Link
        TextButton(
          onPressed: () {
            // Navigate the user to the Sign Up page
            widget.toggleView();
          },
          child: Text(
            "Sign Up?",
            style:
                TextStyle(color: LIGHT_COLOR_3, fontFamily: poppins['poppins']),
          ),
        ),

        // TO BE TESTED
        // Uncomment the following block to add "Sign Anonymously?" link
        /* TextButton(
          onPressed: () async {
            // Show Loading Screen
            setState(() => isLoading = true);

            // Test anonymous user sign-in
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
            style: TextStyle(color: LIGHT_COLOR_5, fontFamily: poppins['poppins']),
          ),
        ), */
      ],
    );
  }
}
