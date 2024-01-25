// Import necessary packages and files
import 'package:budgex/model/userModel.dart';
import 'package:budgex/pages/authenticate/authenticate.dart';
import 'package:budgex/pages/home/user_home_verify.dart';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

// Wrapper widget to determine whether to show the authentication or home page
class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the UserModel from the provider
    final userModel = Provider.of<UserModel?>(context);

    // Return either the authentication or home page based on the presence of a user model
    if (userModel == null) {
      // Show the authentication page if the user model is null
      return const Authenticate();
    } else {
      // Show the home page if the user model is available
      return const UserHomeVerify();
    }
  }
}
