import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:budgex/model/userModel.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:budgex/shared/loading.dart';
import 'package:budgex/widgets/custom_appbar.dart';
import 'package:budgex/widgets/custom_buttom.dart';
import 'package:budgex/widgets/custom_drawer.dart';
import 'package:budgex/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UserSettings extends StatefulWidget {
  UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  // Create an instance of the FirebaseAuthService to manage authentication.
  final FirebaseAuthService _authService = FirebaseAuthService();

  // Create an instance of the FirestoreFirebaseService for updating data in the Setting Screen
  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();

  late Stream<UserData?> userStream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userStream =
        FirebaseFirestoreService(uid: _authService.getCurrentUser().uid)
            .userDocumentStream;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData?>(
      stream: userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state
          return Loading();
        } else if (snapshot.hasError) {
          // Error state
          return Text("Error: ${snapshot.error}");
        } else {
          // Data loaded successfully
          UserData userData = snapshot.data!;
          return StreamProvider<UserData?>.value(
              value: FirebaseFirestoreService(uid: userData.uid)
                  .userMainDocumentStream,
              initialData: userData,
              child: _buildSettingsUI(context, userData));
        }
      },
    );
  }

  /* @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData?>(context);

    return _buildSettingsUI(context, userData);
  } */

  // A method that displays the edit dialog
  // Parameters:
  // labelText - A String type that reperesents the label text, example "Please Enter your new name"
  void showEditDialog(
      {required String labelText,
      required TextEditingController textController,
      required String option}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
            child: AlertDialog(
          title: Text(
            labelText,
            style: TextStyle(
              color: LIGHT_COLOR_3,
              fontFamily: poppins['regular'],
              fontSize: fontSize['h3'],
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // Text('Enter new budget:'),
                TextField(
                  controller: textController,
                ), // replace with your text field widget
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                // handle save button press

                if (option == "Name") {
                  _firestoreService.updateFullName(
                      newFullName: textController.text,
                      uuid: _authService.getCurrentUser().uid);
                } else if (option == "Age") {
                  // Handles the Error
                  // Checks if the value can be convered in to integer
                  try {
                    int age = int.parse(textController.text);

                    // Checks if the age is 18 or above
                    if (age >= 18) {
                      _firestoreService.updateAge(
                          age: int.parse(textController.text),
                          uuid: _authService.getCurrentUser().uid);
                    } else {
                      print("Age must be 18 or above");
                    }
                  } catch (e) {
                    print("Value cannot be converted into Integer $e");
                  }
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        ));
      },
    );
  }

  ///
  ///  A method to build the widgets of the Setting Screen
  ///
  Scaffold _buildSettingsUI(BuildContext context, UserData? userProfileData) {
    final userData = userProfileData;

    return Scaffold(
      appBar: customAppBar(context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  // Profile
                  Stack(alignment: Alignment.center, children: [
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 2)),
                        child: const ClipOval(
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
                            boxShadow: const [
                              BoxShadow(
                                color: LIGHT_COLOR_5,
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ]),
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_enhance,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ]),

                  // Name & Email
                  Text(
                    userData!.fullName,
                    style: TextStyle(
                      fontFamily: poppins['regular'],
                      letterSpacing: 3,
                      fontSize: fontSize["h2"],
                    ),
                  ),
                  Text(
                    userData.email,
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
                          formatTitle: userData.fullName,
                          isEditIcon: true,
                          onClick: () {
                            showEditDialog(
                                labelText: "Please Enter Your New Name",
                                textController: fullNameController,
                                option: 'Name');
                          }),
                      customListTile(
                          formatLeading: "Age",
                          formatTitle: userData.age.toString(),
                          isEditIcon: false,
                          editLabelText: "Please Enter your New Age",
                          onClick: () {
                            showEditDialog(
                                labelText: "Please Enter Your New Age",
                                textController: ageController,
                                option: 'Age');
                          }),
                      customListTile(
                          formatLeading: "Email",
                          formatTitle: userData.email,
                          isEditIcon: false),
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
                              buttonText: "Sign Out",
                              onPressed: () async {
                                /* logOut(); */
                                print("Logged Out");
                                await _authService.signOut();

                                final route = MaterialPageRoute(
                                    builder: (context) => Wrapper());

                                // Use Navigator.pushAndRemoveUntil to navigate to the Wrapper page and remove all previous routes
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(
                                    context, route, (route) => false);
                              })),
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
      drawer: const CustomDrawer(),
    );
  }

  ListTile customListTile(
      {String formatLeading = "Empty",
      String formatTitle = "",
      String editLabelText = "",
      Function()? onClick,
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
      trailing: onClick != null
          ? IconButton(
              onPressed: onClick,
              icon: Icon(Icons.edit),
              color: LIGHT_COLOR_3,
            )
          : Text(""),
    );
  }

  Text customOption({required String title}) {
    return Text(
      title,
      style: TextStyle(color: LIGHT_COLOR_3, fontSize: fontSize["h3"]),
    );
  }
}
