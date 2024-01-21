/*
  Flutter Developer Notes:

  This Dart function defines a custom AppBar widget. The AppBar is a crucial element in 
  the application's UI, providing navigation and actions to the user.

  Key Features:
  - Transparent Background: The AppBar blends seamlessly with the rest of the UI.
  - Custom Icons: Includes icons for toggling themes, notifications, and accessing the 
    camera.
  - Dynamic Profile Icon: Conditionally displays a profile icon based on the current screen.

  Note: The profile icon display logic is based on the context.widget property, which may 
  require further review and testing to ensure correct behavior across all screens.

  This custom AppBar enhances the user experience and adds functionality to the application.

*/

import 'package:budgex/pages/home/user_settings.dart';

import 'package:budgex/services/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBar customAppBar({required BuildContext context}) {
  /* const IconData _iconLight = Icons.sunny;
  const IconData _iconDark = Icons.nights_stay; */

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
        icon: Icon(Icons.notifications),
      ),

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
