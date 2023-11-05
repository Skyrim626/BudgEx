import 'package:budgex/pages/user/user_settings.dart';
import 'package:budgex/services/constants.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context) {
  return AppBar(
    foregroundColor: LIGHT_COLOR_5,
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
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
                      color: LIGHT_COLOR_3,
                      borderRadius: BorderRadius.circular(50))),
            )
          : Text(""), // Empty Space/Text
    ],
  );
}
