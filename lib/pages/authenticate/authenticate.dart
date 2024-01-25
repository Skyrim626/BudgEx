// Import necessary packages and files
import 'package:budgex/pages/authenticate/user_login.dart';
import 'package:budgex/pages/authenticate/user_signup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// Widget responsible for handling user authentication flow
class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

// State class for the Authenticate widget
class _AuthenticateState extends State<Authenticate> {
  // Flag to determine whether to show the Log In or Register Screen (Sign Up Screen)
  bool showSignIn = true;

  // Method for toggling between Log In and Register Screens
  void toggleView() {
    setState(() => showSignIn = !showSignIn); // !showSignIn reverses the value
  }

  @override
  Widget build(BuildContext context) {
    // Choose and return either the UserLogin or UserSignUp widget based on the showSignIn flag
    if (showSignIn) {
      // Display the Log In Screen
      // Passing the toggleView method (function) to the class for toggling screens
      return UserLogin(
        toggleView: toggleView,
      );
    } else {
      // Display the Register Screen
      // Passing the toggleView method (function) to the class for toggling screens
      return UserSignUp(
        toggleView: toggleView,
      );
    }
  }
}
