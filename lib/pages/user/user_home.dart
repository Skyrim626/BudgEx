import 'package:budgex/pages/user/user_login.dart';
/* import 'package:budgex/services/theme_provider.dart'; */
import 'package:budgex/widgets/custom_appbar.dart';
import 'package:budgex/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
/* import 'package:provider/provider.dart'; */

class UserHomepage extends StatefulWidget {
  const UserHomepage({super.key});

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  // This allows the user to log out and return to the Login Page
  void userLogOut() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserLogin(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      backgroundColor: Theme.of(context).colorScheme.background,
      /* appBar: appBar(), */
      drawer: CustomDrawer(),
    );
  }

  /* AppBar appBar() {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            icon: Icon(Icons.dark_mode)),
        IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt)),
        IconButton(onPressed: () {}, icon: Icon(Icons.person)),
      ],
    );
  } */
}
