import 'package:budgex/pages/home/user_scannerOCR.dart';
import 'package:budgex/pages/home/user_settings.dart';
import 'package:budgex/services/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Custom AppBar widget for the application
AppBar customAppBar({required BuildContext context}) {
  // Uncomment these lines if you plan to use custom icons for light and dark mode
  /* const IconData _iconLight = Icons.sunny;
  const IconData _iconDark = Icons.nights_stay; */

  return AppBar(
    // Transparent background for a clean design
    backgroundColor: Colors.transparent,
    // Text color based on the theme's tertiary color
    foregroundColor: Theme.of(context).colorScheme.tertiary,
    // No elevation for a flat appearance
    elevation: 0,
    actions: [
      // Dark/Light mode toggle button
      // NOTE: This icon is for testing purposes only.
      // Flutter already provides dark/light mode during phone set theme.
      IconButton(
        onPressed: () {
          // Toggle theme using the Provider
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
        },
        icon: const Icon(Icons.nights_stay),
      ),

      // Placeholder for a camera icon (you can replace this with your functionality)
      IconButton(
        onPressed: () {
          final route = MaterialPageRoute(builder: (context) => OCRScreen());

          // Use Navigator.pushAndRemoveUntil to navigate to the UserBudgeting page and remove all previous routes
          // ignore: use_build_context_synchronously

          Navigator.pushAndRemoveUntil(context, route, (route) => false);
        },
        icon: const Icon(Icons.camera_alt),
      ),

      // Display profile icon only if not on the UserSettings screen
      // If on UserSettings screen, show an empty space
      context.widget.toString() != "UserSettings"
          ? IconButton(
              onPressed: () {
                // Navigate to UserSettings screen and remove the current screen from the stack
                final route = MaterialPageRoute(
                  builder: (context) => UserSettings(),
                );
                Navigator.pushAndRemoveUntil(context, route, (route) => false);

                /* Alternative navigation without removing the current screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserSettings(),
                  ),
                ); */
              },
              // A profile icon
              icon: const Icon(Icons.person_pin),
            )
          : const Text(""), // Empty space if on the UserSettings screen
    ],
  );
}
