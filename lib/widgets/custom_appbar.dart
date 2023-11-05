import 'package:budgex/pages/user/user_settings.dart';
import 'package:budgex/services/constants.dart';
import 'package:budgex/services/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBar customAppBar(BuildContext context) {
  IconData _iconLight = Icons.sunny;
  IconData _iconDark = Icons.nights_stay;

  return AppBar(
    backgroundColor: Colors.transparent,
    foregroundColor: Theme.of(context).colorScheme.tertiary,
    elevation: 0,
    actions: [
      // NOTE: THIS ICON IS FOR TESTING PURPOSES ONLY
      // FLUTTER ALREADY PROVIDES DARK/LIGHT MODE DURING PHONE SET THEME
      IconButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
          icon: Icon(Icons.nights_stay)),

      IconButton(
        onPressed: () {},
        icon: Icon(Icons.camera_alt),
      ),

      /* 
        If the user navigates to the Setting screen(UserSettings),
        the Profile Icon will not display to the AppBar.
      */
      context.widget.toString() != "UserSettings"
          ? IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserSettings(),
                    ));
              },
              icon: Container(
                  child: Icon(Icons.person_rounded),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(50))),
            )
          : const Text(""), // Empty Space/Text
    ],
  );
}
