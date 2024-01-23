/*
  Flutter Developer Notes:

  This Dart class defines a CustomDrawer widget, an essential navigational element in the 
  application. It allows users to access different sections of the app through a menu that 
  slides in from the left side of the screen.

  Key Features:
  - Close Button Icon: Provides a way to dismiss the drawer.
  - Header (Logo): Displays the application logo at the top.
  - List of Menu Items: Presents a set of options with icons and labels.
  - Sign Out Option: Allows the user to log out of their account.

  Note: Ensure each menu item's onTap function is properly implemented for seamless 
  navigation or other actions.

  This component plays a crucial role in user navigation within the app. Great work!

*/

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:budgex/pages/home/user_budgeting.dart';
import 'package:budgex/pages/home/user_expense.dart';
import 'package:budgex/pages/home/user_home_verify.dart';
import 'package:budgex/pages/home/user_scanner.dart';
import 'package:budgex/pages/home/user_settings.dart';

import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> menuItems() {
  return [
    {
      'iconText': 'Home',
      'iconData': 0xe318,
      'toPage': UserHomeVerify(),
    },
    {
      'iconText': 'Expenses',
      'iconData': 0xe3f8,
      'toPage': UserExpense(),
    },
    {
      'iconText': 'Budgeting',
      'iconData': 0xe0b2,
      'toPage': UserBudgeting(),
    },
    {
      'iconText': 'Scan Receipt',
      'iconData': 0xe12f,
      'toPage': UserScanReceipt(),
    },
    {
      'iconText': 'Settings',
      'iconData': 0xe062,
      'toPage': UserSettings(),
    },
  ];
}

// ignore: must_be_immutable
class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  // Create an instance of the FirebaseAuthService to manage authentication.
  final FirebaseAuthService _auth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        /* color: Colors.white, */
        child: Column(
          children: [
            // Close Button Icon
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context); // Closes the drawer
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
              ],
            ),

            // Header (Logo)
            DrawerHeader(
              child: Image(
                image: AssetImage("assets/images/logo_light.png"),
              ),
            ),

            // List of items with SizedBox in each Column
            Expanded(
              child: ListView.builder(
                itemCount: menuItems().length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> menuItem = menuItems()[index];
                  return Column(
                    children: [
                      // A function that genrates ListTile
                      listTile(
                          iconText: menuItem['iconText'],
                          iconData: menuItem['iconData'],
                          toPage: menuItem['toPage']),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),

            // Sign Out
            /* listTile(
              iconText: "Sign Out",
              iconData: 0xe3b3,
              toPage: AuthPage(),
            ), */
          ],
        ),
      ),
    );
  }

  /*
   Generates a custom ListTile for the drawer menu.

  This function creates a ListTile with an icon specified by the iconData and text specified 
  by iconText. The icon color is set to LIGHT_COLOR_5, and the text is styled with a custom 
  font ('Dosis') and specific font size and weight.

  Args:
    - iconText: The text to display next to the icon.
    - iconData: The code point of the icon to be displayed.
    - toPage: The page that you will redirected when it is click.

  Returns:
    A ListTile with the specified icon and text.
*/
  ListTile listTile(
      {required String iconText,
      required int iconData,
      required var toPage,
      bool? isSelected}) {
    return ListTile(
      iconColor: Theme.of(context)
          .colorScheme
          .primary, // Setting the Navigation Icons Color
      leading: Icon(
        IconData(iconData, fontFamily: 'MaterialIcons'),
        size: 30,
      ),
      title: Text(
        iconText,
        style:
            TextStyle(fontFamily: dosis['semiBold'], fontSize: fontSize['h3']),
      ),
      onTap: () {
        // An alert box is displayd if the user wants to return to the login screen
        // Checks if the toPage parameter redirects to the UserLogin (equal to 'UserLogin')
        if (toPage.toString() == "UserLogin") {
          // Displays a dialog if the user wants to sign out or not
          AwesomeDialog(
            context: context,
            btnOkColor: LIGHT_COLOR_3,
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            desc: 'Are You Sure You Want to Log Out?',
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              // Logs out
              // Allows the user to return to the log in screen
              _auth.signOut();
              /* Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => toPage())); */
            },
          ).show();
        } else {
          final route = MaterialPageRoute(builder: (context) => toPage);

          // Use Navigator.pushAndRemoveUntil to navigate to the Wrapper page and remove all previous routes
          Navigator.pushAndRemoveUntil(context, route, (route) => false);

          /* Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => toPage));  */ // Redirects to the page
        }
      },
    );
  }
}
