import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:budgex/pages/user/auth_page.dart';
/* import 'package:budgex/model/user.dart'; */
import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/services/constants.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/widgets/custom_appbar.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  // Create an instance of the FirebaseAuthService to manage authentication.
  final FirebaseAuthService _auth = FirebaseAuthService();

  // Declare User
  late User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Initialize User
    user = _auth.getCurrentUser();
  }

  // User instance
  /* User sampleUser = User(); */

  // Function to navigate the user to the Login page.
  void toLoginPage() {
    AwesomeDialog(
      context: context,
      btnOkColor: LIGHT_COLOR_3,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      desc: 'Are You Sure You Want to Log Out?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        _auth.signOut().then((res) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AuthPage()),
          );
        });

        /*  Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserLogin(),
            )); */
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  // Profile
                  Stack(alignment: Alignment.center, children: [
                    Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 2)),
                        child: ClipOval(
                          child: Image(
                            image:
                                AssetImage("assets/images/sample_profile.jpg"),
                            fit: BoxFit.cover,
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.background,
                            boxShadow: [
                              BoxShadow(
                                color: LIGHT_COLOR_5,
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ]),
                        child: IconButton(
                          icon: Icon(
                            Icons.camera_enhance,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ]),

                  // Name & Email
                  Text(
                    "John Doe",
                    style: TextStyle(
                      fontFamily: poppins['regular'],
                      letterSpacing: 3,
                      fontSize: fontSize["h2"],
                    ),
                  ),
                  Text(
                    "johnDoe@gmail.com",
                    style: TextStyle(
                      fontFamily: dosis['regular'],
                      fontSize: fontSize["h5"],
                    ),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*  Account Information
                - Full Name
                - Email
                - Username */
                      customOption(title: "Account Information"),
                      const Divider(),
                      customListTile(
                          formatLeading: "Full Name",
                          formatTitle: "sampleUser.getFullName",
                          isEditIcon: true),
                      customListTile(
                          formatLeading: "Age",
                          formatTitle: "20",
                          isEditIcon: false),
                      customListTile(
                          formatLeading: "Email",
                          formatTitle: "sampleUser.getUserEmail",
                          isEditIcon: true),
                      customListTile(
                          formatLeading: "Date Birth",
                          formatTitle: "MM-DD-YYYY",
                          isEditIcon: true),
                      const SizedBox(
                        height: 15,
                      ),

                      /* Privacy
                - Change Password */
                      customOption(title: "Privacy"),
                      const Divider(),
                      Center(
                        child: CustomButtom(
                            buttonText: "Change Password", onPressed: () {}),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      /* Manage Notifications
                - Notifications */
                      customOption(title: "Notification"),
                      const Divider(),
                      customListTile(
                          formatLeading: "Notifications", isEditIcon: false),
                      const SizedBox(
                        height: 50,
                      ),

                      // Sign Out
                      Center(
                          child: CustomButtom(
                              buttonText: "Sign Out", onPressed: toLoginPage)),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: CustomDrawer(),
    );
  }

  ListTile customListTile(
      {String formatLeading = "Empty",
      String formatTitle = "",
      required isEditIcon}) {
    return ListTile(
      minLeadingWidth: 0,
      leading: Text(
        formatLeading,
        style: TextStyle(
          fontFamily: dosis['regular'],
          fontSize: fontSize["h4"],
        ),
      ),
      title: Text(
        formatTitle,
        style: TextStyle(
            fontFamily: dosis['regular'],
            fontSize: fontSize["h4"],
            color: LIGHT_COLOR_2),
      ),
      trailing: isEditIcon
          ? IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
              color: LIGHT_COLOR_3,
            )
          : Text("ON"),
    );
  }

  Text customOption({required String title}) {
    return Text(
      title,
      style: TextStyle(color: LIGHT_COLOR_3, fontSize: fontSize["h3"]),
    );
  }
}
