import 'package:budgex/model/userModel.dart';
import 'package:budgex/pages/home/onboarding_screen.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/theme_provider.dart';
import 'package:budgex/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

// Variable to store the initial screen to be displayed
int? initScreen;

// Main function to run the Flutter application
Future<void> main() async {
  // Ensure that Flutter is initialized and can access native code
  WidgetsFlutterBinding.ensureInitialized();

  // Open SharedPreferences to store and retrieve data persistently
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Retrieve the value of the key 'initScreen' from SharedPreferences
  initScreen = prefs.getInt("initScreen");

  // Set the value of 'initScreen' to 1 if it's null
  await prefs.setInt("initScreen", 1);

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the app, providing a ThemeProvider through a ChangeNotifierProvider
  runApp(ChangeNotifierProvider(
    create: ((context) => ThemeProvider()),
    child: const MyApp(),
  ));
}

// The main application widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      // Provide the user data stream from the FirebaseAuthService
      value: FirebaseAuthService().user,
      initialData: null,
      builder: (context, snapshot) {
        return MaterialApp(
          // Display either the OnBoardingScreen or the Wrapper based on initScreen value
          home: initScreen == null || initScreen == 0
              ? const OnBoardingScreen()
              : const Wrapper(),
          // Remove the debug banner in release mode
          debugShowCheckedModeBanner: false,
          // Set the theme based on the selected theme in ThemeProvider
          theme: Provider.of<ThemeProvider>(context).themeData,
        );
      },
    );
  }
}
