import 'package:budgex/pages/authenticate/user_login.dart';
import 'package:budgex/pages/authenticate/user_signup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  // For showing Log In or Register Screen (Sign Up Screen)
  bool showSignIn = true;
  // A method for toggling Menus(Screens)
  void toggleView() {
    setState(
        () => showSignIn = !showSignIn); // !showSignIn just reverses the value
  }

  @override
  Widget build(BuildContext context) {
    // Conditional Statement
    // If the showSignIn is true then the app displays Login Screen
    // Else then the app displays the Register Screen
    if (showSignIn) {
      // Passing the toggleView method(function) to the class for toggling screen
      return UserLogin(
        toggleView: toggleView,
      );
    } else {
      // Passing the toggleView method(function) to the class for toggling screen
      return UserSignUp(
        toggleView: toggleView,
      );
    }
  }
}
