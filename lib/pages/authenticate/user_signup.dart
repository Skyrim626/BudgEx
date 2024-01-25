// Import necessary packages and files
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/shared/loading.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserSignUp extends StatefulWidget {
  // Function type variable for toggling between Sign Up and Sign In screens
  final Function toggleView;

  const UserSignUp({super.key, required this.toggleView});

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  // Global key for form validation
  final _formKey = GlobalKey<FormState>();

  // Firebase Authentication Service instance
  final FirebaseAuthService _auth = FirebaseAuthService();

  // Text Editing Controllers for user input
  final _fullNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Loading Screen Checker
  bool isLoading = false;

  // Flag to toggle password visibility
  bool isObscureForPassword = true;
  bool isObscureForConfirmPassword = true;

  // Function to check if the password matches the confirm password
  bool passwordConfirmed() {
    return _passwordController.text.trim() ==
        _confirmPasswordController.text.trim();
  }

  // Dispose of text editing controllers when the widget is disposed
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
    return isLoading
        ? const Loading() // Show loading screen when isLoading is true
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  // Navigate back to the Sign In screen
                  widget.toggleView();
                },
                icon: const Icon(Icons.arrow_back),
                color: LIGHT_COLOR_5,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SafeArea(
              child: Form(
                key: _formKey, // Form key for form validation
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Logo
                      const Image(
                        image: AssetImage("assets/images/logo_light.png"),
                        height: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          children: [
                            // Full name textfield
                            TextFormField(
                              controller: _fullNameController,
                              style: TextStyle(
                                fontFamily: poppins['regular'],
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Enter your full name',
                                labelText: 'Full Name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your full name";
                                }

                                if (value.length >= 35) {
                                  return "Your name is too long!";
                                }

                                // Use a regex to check if the value contains only letters and spaces
                                if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                                  return "Special characters and numbers are not allowed";
                                }

                                return null;
                              },
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            // Age textfield
                            TextFormField(
                              controller: _ageController,
                              style: TextStyle(
                                fontFamily: poppins['regular'],
                              ),
                              keyboardType: TextInputType
                                  .number, // Set the keyboard to accept only numbers
                              decoration: const InputDecoration(
                                hintText: 'Enter your age',
                                labelText: 'Age',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your age";
                                }

                                // Use a regex to check if the value contains only digits
                                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                  return "Please enter a valid age (numbers only)";
                                }

                                int? age = int.tryParse(value);
                                if (age == null || age <= 0) {
                                  return "Please enter a valid age above 0";
                                }

                                if (age < 18) {
                                  return "You must be 18 or older";
                                }

                                return null;
                              },
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            // Email Text Field
                            TextFormField(
                              controller: _emailController,
                              style: TextStyle(
                                fontFamily: poppins['regular'],
                              ),
                              keyboardType: TextInputType
                                  .emailAddress, // Set keyboard type to accept email addresses
                              decoration: const InputDecoration(
                                hintText: 'Enter your email',
                                labelText: 'Email',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email";
                                }

                                // Use a regex to check if the value is a valid email address
                                if (!RegExp(
                                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                    .hasMatch(value)) {
                                  return "Please enter a valid email address";
                                }

                                if (value.length > 20) {
                                  return "Email address should not exceed 20 characters";
                                }

                                return null;
                              },
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            // Password textfield
                            TextFormField(
                              controller: _passwordController,
                              style: TextStyle(
                                fontFamily: poppins['regular'],
                              ),
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isObscureForPassword =
                                          !isObscureForPassword;
                                    });
                                  },
                                  icon: Icon(isObscureForPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                              ),
                              obscureText: isObscureForPassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your password";
                                }

                                // Password strength criteria
                                if (value.length < 8) {
                                  return "Password must be at least 8 characters long";
                                }

                                if (value.length >= 100) {
                                  return "That is not the right age limit";
                                }

                                if (!RegExp(
                                        r'(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}|:<>?~,-.]).{8,}')
                                    .hasMatch(value)) {
                                  return "Password must contain at least one uppercase letter, one lowercase letter, one digit, and one special character";
                                }

                                return null;
                              },
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            // Confirm Password textfield
                            TextFormField(
                              controller: _confirmPasswordController,
                              style: TextStyle(
                                fontFamily: poppins['regular'],
                              ),
                              decoration: InputDecoration(
                                hintText: 'Enter your confirm password',
                                labelText: 'Confirm Password',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isObscureForConfirmPassword =
                                          !isObscureForConfirmPassword;
                                    });
                                  },
                                  icon: Icon(isObscureForConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                              ),
                              obscureText: isObscureForConfirmPassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your confirm password";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            // Sign Up Button
                            CustomButton(
                              buttonText: "Sign Up",
                              onPressed: () async {
                                // Form that is true will be registered
                                if (_formKey.currentState!.validate()) {
                                  // Show Loading Screen
                                  setState(() => isLoading = true);

                                  // Attempt to register user
                                  if (_passwordController.text ==
                                      _confirmPasswordController.text) {
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                      _emailController.text,
                                      _passwordController.text,
                                      {
                                        'fullName': _fullNameController.text,
                                        'age': int.parse(_ageController.text),
                                        'email': _emailController.text,
                                      },
                                    );

                                    if (result == null) {
                                      // Handle unsuccessful registration
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  } else {
                                    // Passwords do not match, show an error dialog
                                    setState(() {
                                      isLoading = false;
                                    });

                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.scale,
                                      title: "Password not matched!",
                                      btnOkOnPress: () {},
                                    ).show();
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
