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

import 'package:budgex/pages/user/user_budgeting.dart';
import 'package:budgex/pages/user/user_expense.dart';
import 'package:budgex/pages/user/user_home.dart';
import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/pages/user/user_scanner.dart';
import 'package:budgex/pages/user/user_settings.dart';
import 'package:budgex/services/constants.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List<Map<String, dynamic>> menuItems = [
    {
      'iconText': 'Home',
      'iconData': 0xe318,
      'toPage': UserHomepage(),
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
              child: Image.asset("../assets/images/logo_light.png"),
            ),

            // List of items with SizedBox in each Column
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> menuItem = menuItems[index];
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
            listTile(
              iconText: "Sign Out",
              iconData: 0xe3b3,
              toPage: UserLogin(),
            ),
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
        style: const TextStyle(
            fontFamily: 'Dosis', fontWeight: FontWeight.w600, fontSize: 23),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => toPage)); // Redirects to the page
      },
    );
  }
}
