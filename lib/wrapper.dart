import 'package:budgex/model/userModel.dart';
import 'package:budgex/pages/authenticate/authenticate.dart';
import 'package:budgex/pages/home/user_home.dart';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel?>(context);

    // Return either home or authenticated page
    if (userModel == null) {
      return Authenticate();
    } else {
      return UserHomepage();
    }
  }
}
